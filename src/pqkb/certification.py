"""Check connector source against Microsoft's Power Query connector certification rules.

Rules come from "Power Query Connector Certification" (Microsoft Learn, 2024-01-18),
which now redirects elsewhere; see CERTIFICATION_SOURCE for the archived copy. Each
check reads the code statically and returns one status:

- pass / fail: the rule is met or not, as far as the code shows.
- review: the code needs judgement (for example, what a trace contains).
- n/a: the rule does not apply (for example, no credentials are used).
- info: a fact the rule depends on but cannot be judged from one version
  (for example, Beta must be true only on the initial release).

These are source-reading checks. They do not reproduce Microsoft's review.
"""

from __future__ import annotations

import re
from dataclasses import dataclass

from pqkb.functions import Function, _mask, index_connector

CERTIFICATION_SOURCE = (
    "https://web.archive.org/web/20240809185021/"
    "https://learn.microsoft.com/en-us/power-query/connector-certification"
)
BANNED_NAME_WORDS = re.compile(r"power\s*bi|connector|\bapi\b", re.IGNORECASE)


@dataclass(frozen=True)
class Rule:
    id: str
    level: str  # MUST, SHOULD, SECURITY
    text: str


RULES = (
    Rule("section-document", "MUST", "Use section document format."),
    Rule("version-header", "MUST", "Contain a version header above the section document."),
    Rule("function-documentation", "MUST", "Provide function documentation metadata."),
    Rule("test-connection", "MUST", "Have a TestConnection handler."),
    Rule(
        "naming",
        "MUST",
        "Name shared functions DataSourceKind.FunctionName, without "
        "'Power BI', 'Connector', or 'API'.",
    ),
    Rule("beta-flag", "MUST", "Set the Beta flag to true on the initial release."),
    Rule("icons", "SHOULD", "Have icons."),
    Rule("navigation-table", "SHOULD", "Provide a navigation table."),
    Rule("resource-strings", "SHOULD", "Place UI strings in resources.resx."),
    Rule("https-credentials", "SECURITY", "Send credentials only over HTTPS."),
    Rule(
        "credential-query-string",
        "SECURITY",
        "Pass credentials in a GET query only through CredentialQueryString.",
    ),
    Rule("diagnostics-gated", "SECURITY", "Gate tracing behind a flag that is off at submission."),
    Rule("expression-evaluate", "SECURITY", "Never evaluate user-provided or fetched expressions."),
)


@dataclass(frozen=True)
class Finding:
    rule: str
    status: str
    detail: str
    file: str = ""
    line: int = 0


class _Source:
    """A connector's files with masked text (comments and string literals blanked)."""

    def __init__(self, files: dict[str, str]):
        self.files = files
        self.masked = {name: _mask(text) for name, text in files.items()}

    def find(self, pattern: str, masked: bool = True) -> tuple[str, int] | None:
        regex = re.compile(pattern)
        for name in sorted(self.files):
            text = self.masked[name] if masked else self.files[name]
            match = regex.search(text)
            if match:
                return name, text.count("\n", 0, match.start()) + 1
        return None

    def sections(self) -> dict[str, str]:
        return {n: t for n, t in self.files.items() if not n.lower().endswith(".pqm")}


def _found(rule: str, hit, yes: str, no: str, missing_status: str = "fail") -> Finding:
    if hit:
        return Finding(rule, "pass", yes, *hit)
    return Finding(rule, missing_status, no)


KIND = re.compile(r'DataSource\.Kind\s*=\s*"([^"]+)"')


def _function_kind(src: _Source, function: Function) -> str:
    """The DataSource.Kind attribute on a shared function, if any."""
    match = KIND.search(src.files[function.file].splitlines()[function.start - 1])
    return match.group(1) if match else ""


def _kinds(functions: list[Function], src: _Source) -> dict[str, Function | None]:
    """Every data source kind declared on a shared function, mapped to its kind record."""
    names = {_function_kind(src, f) for f in functions if f.shared} - {""}
    return {name: next((f for f in functions if f.name == name), None) for name in sorted(names)}


def _body(src: _Source, function: Function, masked: bool = True) -> str:
    text = src.masked[function.file] if masked else src.files[function.file]
    return "\n".join(text.splitlines()[function.start - 1 : function.end])


def check_connector(connector: str, files: dict[str, str]) -> list[Finding]:
    src = _Source(files)
    functions = index_connector(connector, files)
    kinds = _kinds(functions, src)
    findings = [
        _found(
            "section-document",
            src.find(r"\bsection\s+[\w.#\"]+\s*;"),
            "Section document.",
            "No section document found.",
        ),
        _found(
            "version-header",
            src.find(r"(?m)^\s*\[\s*Version\s*=", masked=False),
            "Version header present.",
            "No [Version = ...] header.",
        ),
        _found(
            "function-documentation",
            src.find(r"Documentation\.(Name|Caption|Description|LongDescription|FieldCaption)"),
            "Documentation metadata present.",
            "No Documentation.* metadata.",
        ),
    ]
    findings.append(_test_connection(kinds, src))
    findings.append(_naming(functions, src))
    findings.append(_beta(src))
    findings.append(
        _found(
            "icons",
            src.find(r"\bSourceImage\s*="),
            "Publish record sets icons.",
            "No SourceImage in a Publish record.",
        )
    )
    findings.append(_navigation(src))
    findings.append(
        _found(
            "resource-strings",
            src.find(r"Extension\.LoadString\s*\("),
            "Uses Extension.LoadString.",
            "No Extension.LoadString calls.",
        )
    )
    findings += _security(functions, src)
    return findings


def _test_connection(kinds: dict[str, Function | None], src: _Source) -> Finding:
    if not kinds:
        return Finding("test-connection", "review", "No data source kind found.")
    missing = [
        k
        for k, record in kinds.items()
        if not (record and re.search(r"\bTestConnection\s*=", _body(src, record)))
    ]
    if not missing:
        record = next(iter(kinds.values()))
        return Finding(
            "test-connection",
            "pass",
            f"TestConnection defined for {', '.join(kinds)}.",
            record.file,
            record.start,
        )
    handler = src.find(r"\bOnTestConnection\s*=")
    if handler:
        return Finding(
            "test-connection",
            "pass",
            f"No TestConnection in {', '.join(missing)}; tests through a Table.View "
            "OnTestConnection handler.",
            *handler,
        )
    return Finding("test-connection", "fail", f"No TestConnection for {', '.join(missing)}.")


def _naming(functions: list[Function], src: _Source) -> Finding:
    shared = [f for f in functions if f.shared and _function_kind(src, f)]
    if not shared:
        return Finding("naming", "review", "No shared function with a data source kind found.")
    for f in shared:
        kind = _function_kind(src, f)
        if not f.name.startswith(f"{kind}.") or BANNED_NAME_WORDS.search(f.name):
            return Finding(
                "naming",
                "fail",
                f"Shared function {f.name} (kind {kind}) does not follow "
                "DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'.",
                f.file,
                f.start,
            )
    return Finding(
        "naming",
        "pass",
        f"Shared functions: {', '.join(f.name for f in shared)}.",
        shared[0].file,
        shared[0].start,
    )


def _navigation(src: _Source) -> Finding:
    own = src.find(r"NavigationTable\.(NameColumn|DataColumn)|Table\.ToNavigationTable")
    if own:
        return Finding("navigation-table", "pass", "Builds a navigation table.", *own)
    source = src.find(
        # Engine source functions that return their own navigation tables.
        r"\b(Odbc\.DataSource|OData\.Feed|AdoDotNet\.DataSource|OleDb\.DataSource|"
        r"(Sql|MySQL|PostgreSQL|Oracle|Snowflake|AnalysisServices)\.Databases?)\s*\("
    )
    if source:
        return Finding(
            "navigation-table", "pass", "Navigation comes from the source function.", *source
        )
    return Finding("navigation-table", "fail", "No navigation table found.")


def _beta(src: _Source) -> Finding:
    hit = src.find(r"\bBeta\s*=\s*(true|false)\b")
    if not hit:
        return Finding("beta-flag", "info", "No Beta flag in the Publish record.")
    file, line = hit
    value = re.search(r"\bBeta\s*=\s*(true|false)", src.masked[file].splitlines()[line - 1])
    return Finding(
        "beta-flag", "info", f"Beta = {value and value.group(1)} in this version.", file, line
    )


def _security(functions: list[Function], src: _Source) -> list[Finding]:
    findings = []
    credential = src.find(r"Extension\.CurrentCredential\s*\(")
    if not credential:
        findings.append(Finding("https-credentials", "n/a", "No Extension.CurrentCredential use."))
        findings.append(
            Finding("credential-query-string", "n/a", "No Extension.CurrentCredential use.")
        )
    else:
        https = src.find(
            r'ValidateUrlScheme|Scheme[^\n]{0,60}"https"|"https"[^\n]{0,60}Scheme|'
            r'Text\.StartsWith\([^\n]{0,80}"https://',
            masked=False,
        )
        findings.append(
            Finding("https-credentials", "pass", "Validates the https scheme.", *https)
            if https
            else Finding(
                "https-credentials",
                "review",
                "Credentials used; no explicit https check found.",
                *credential,
            )
        )
        in_query = src.find(r"Query\s*=\s*\[[^\]]*Extension\.CurrentCredential")
        if src.find(r"CredentialQueryString"):
            findings.append(
                Finding("credential-query-string", "pass", "Uses CredentialQueryString.")
            )
        elif in_query:
            findings.append(
                Finding(
                    "credential-query-string",
                    "fail",
                    "Credential placed in a Query record.",
                    *in_query,
                )
            )
        else:
            findings.append(
                Finding("credential-query-string", "pass", "No credential in a Query record.")
            )
    trace = src.find(r"Diagnostics\.(Trace|LogValue|LogFailure)\s*\(")
    if not trace:
        findings.append(Finding("diagnostics-gated", "n/a", "No Diagnostics tracing."))
    else:
        gate = src.find(
            r"\bEnableTraceOutput\b|\b\w*[Tt]race\w*(Enabled|Output)\w*\s*=\s*(false|true)"
        )
        findings.append(
            Finding("diagnostics-gated", "pass", "Tracing is gated by a flag.", *gate)
            if gate
            else Finding(
                "diagnostics-gated", "review", "Tracing without a recognised flag.", *trace
            )
        )
    findings.append(_expression_evaluate(functions, src))
    return findings


def _expression_evaluate(functions: list[Function], src: _Source) -> Finding:
    users = [f for f in functions if re.search(r"Expression\.Evaluate\s*\(", _body(src, f))]
    if not users:
        return Finding("expression-evaluate", "n/a", "No Expression.Evaluate use.")
    risky = [f for f in users if "Extension.Contents" not in _body(src, f)]
    if risky:
        f = risky[0]
        return Finding(
            "expression-evaluate",
            "review",
            f"{f.name} evaluates an expression not loaded from the package.",
            f.file,
            f.start,
        )
    return Finding(
        "expression-evaluate",
        "pass",
        "Only the module loader evaluates packaged files.",
        users[0].file,
        users[0].start,
    )
