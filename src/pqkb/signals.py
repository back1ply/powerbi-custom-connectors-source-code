"""Evidence requirements for the documented patterns, not runtime guarantees."""

from dataclasses import dataclass


@dataclass(frozen=True)
class Signal:
    label: str
    expression: str


def call(symbols: str) -> str:
    return rf"(?<![\w.])(?:{symbols})\s*\("


SIGNALS = {
    "actions": (
        Signal(
            "action operation",
            call(r"Action\.(?:Sequence|Return)|TableAction\.(?:InsertRows|UpdateRows|DeleteRows)"),
        ),
        Signal("action type or handler", r"\b(?:type\s+action|On(?:Insert|Update|Delete)Rows\s*=)"),
    ),
    "async-exports": (
        Signal("task state inspection", r"\[\s*taskState\s*\]"),
        Signal("task identifier", r"\btaskId\b"),
        Signal("delayed status request", call(r"Function\.InvokeAfter")),
        Signal("HTTP operation", call(r"Web\.Contents")),
    ),
    "date-filters": (
        Signal("range-start parameter", r"\bRangeStart\b"),
        Signal("range-end parameter", r"\bRangeEnd\b"),
        Signal("date serialization", call(r"DateTime\.ToText|DateTimeZone\.ToText")),
    ),
    "parameter-metadata": (
        Signal("parameter documentation", r"\bDocumentation\.FieldCaption\s*="),
        Signal("typed function binding", call(r"Value\.ReplaceType")),
        Signal("function signature", r"\btype\s+function\s*\("),
    ),
    "buffering": (Signal("explicit buffer call", call(r"(?:Table|List|Binary)\.Buffer")),),
    "credentials": (
        Signal("credential access", call(r"Extension\.CurrentCredential")),
        Signal(
            "credential field consumption",
            r"\[\s*(?:Key|Username|Password|access_token|refresh_token|AuthenticationKind)\s*\]",
        ),
    ),
    "diagnostics": (
        Signal("trace invocation", call(r"Diagnostics\.Trace")),
        Signal("trace level", r"\bTraceLevel\.(?:Error|Warning|Information|Verbose|Critical)\b"),
    ),
    "errors": (
        Signal("structured error construction", call(r"Error\.Record")),
        Signal("error propagation or handling", r"\b(?:error|try)\b|\bManualStatusHandling\s*="),
    ),
    "graphql": (
        Signal("GraphQL query payload", r"\[\s*query\s*=|\bquery\s*=[^;\n]*,\s*variables\s*="),
        Signal("JSON serialization", call(r"Json\.FromValue")),
        Signal(
            "HTTP request or retry transport", call(r"Web\.Contents|RetryWithExponentialBackoff")
        ),
    ),
    "hmac": (
        Signal("HMAC invocation", call(r"Crypto\.CreateHmac")),
        Signal("signature encoding", call(r"Binary\.ToText")),
    ),
    "navigation": (
        Signal("navigation table construction", call(r"Table\.ToNavigationTable")),
        Signal(
            "navigation metadata",
            r"\bNavigationTable\.(?:NameColumn|DataColumn|ItemKindColumn|IsLeafColumn)\s*=",
        ),
    ),
    "native-query": (Signal("native query invocation", call(r"Value\.NativeQuery")),),
    "oauth2": (
        Signal("OAuth authentication registration", r"\bOAuth\s*=\s*\["),
        Signal("login callback registration", r"\bStartLogin\s*="),
        Signal("completion callback registration", r"\bFinishLogin\s*="),
        Signal("token grant construction", r"\bgrant_type\s*="),
        Signal("HTTP token exchange", call(r"Web\.Contents")),
    ),
    "odata": (Signal("OData feed invocation", call(r"OData\.Feed")),),
    "odbc": (Signal("ODBC source or query invocation", call(r"Odbc\.(?:DataSource|Query)")),),
    "packaging": (Signal("packaged resource access", call(r"Extension\.(?:Contents|LoadString)")),),
    "pagination": (
        Signal("page generator invocation", call(r"Table\.GenerateByPage|List\.Generate")),
        Signal(
            "page state or continuation",
            r"\[\s*(?:Next|next|Offset|offset|Page|page|Cursor|cursor)\s*\]|\b(?:Next|next|Offset|offset|Page|page|Cursor|cursor)\s*=",
        ),
    ),
    "pkce": (
        Signal("authorization challenge", r"\bcode_challenge\s*="),
        Signal("token verifier", r"\bcode_verifier\s*="),
        Signal("challenge hashing", call(r"Crypto\.CreateHash")),
    ),
    "response-metadata": (
        Signal("metadata inspection", call(r"Value\.Metadata")),
        Signal(
            "response field access",
            r"\[\s*(?:Response\.Status|Headers|Content\.Type)\s*\]|\b(?:Response\.Status|Headers)\s*=",
        ),
    ),
    "retry-polling": (
        Signal("wait or delayed invocation", call(r"Value\.WaitFor|Function\.InvokeAfter")),
        Signal("delay interval", r"#duration\s*\("),
        Signal("retry or completion condition", r"\b(?:if|until)\b"),
    ),
    "schema": (
        Signal(
            "schema application",
            call(
                r"SchemaTransformTable|Table\.ChangeType|Table\.TransformColumnTypes|Value\.ReplaceType"
            ),
        ),
        Signal("table type or schema", r"\btype\s+table\b|\bSchema\s*=|\bTable\.Schema\s*\("),
    ),
    "table-view": (
        Signal("table view construction", call(r"Table\.View")),
        Signal(
            "view handler registration",
            r"\b(?:GetType|GetRows|OnSelectRows|OnTake|OnSkip|OnSelectColumns)\s*=",
        ),
    ),
    "web-requests": (
        Signal("HTTP invocation", call(r"Web\.Contents")),
        Signal("relative path option", r"\bRelativePath\s*="),
    ),
}
