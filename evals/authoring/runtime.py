"""Run one authoring trial's connector on the real Power Query engine.

Usage: uv run python evals/authoring/runtime.py TRIAL_DIR --tools SDKTOOLS_DIR

SDKTOOLS_DIR is the `tools` folder of the Microsoft.PowerQuery.SdkTools NuGet package
(it holds MakePQX.exe and PQTest.exe; Windows only). The script compiles
TRIAL_DIR/connector/ into a .mez, stores a dummy API key in a credential file of its
own, and runs each check below with PQTest's HTTP mock standing in for the Ledgerly API.
Writes TRIAL_DIR/runtime/ (mez, mock, queries, raw PQTest output) and
TRIAL_DIR/runtime.json, and prints one summary line.

PQTest's mock is stateless and matches the first entry whose query parameters are a
subset of the request's, so specific entries are listed first, and "429 then success"
cannot be mocked: the retry checks send the error forever and expect a clean failure
after a bounded number of retries.
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

KIND = "Ledgerly"
SEP = "-" * 66
TABLES = {"Invoices", "Customers", "Payments"}
DATETIME = {"datetime", "datetimezone"}
EXPECTED_KINDS = {
    "Invoices": {
        "id": {"text"}, "number": {"text"}, "customerid": {"text"},
        "issuedat": DATETIME, "dueat": {"date"}, "total": {"number"},
        "currency": {"text"}, "status": {"text"}, "updatedat": DATETIME,
    },
    "Customers": {
        "id": {"text"}, "name": {"text"}, "email": {"text"}, "country": {"text"},
        "createdat": DATETIME,
    },
    "Payments": {
        "id": {"text"}, "invoiceid": {"text"}, "amount": {"number"},
        "paidat": DATETIME, "method": {"text"},
    },
}  # fmt: skip

INVOICE = {
    "id": "in_1", "number": "A-1", "customer_id": "c_1",
    "issued_at": "2026-01-02T03:04:05Z", "due_at": "2026-02-01", "total": 12.5,
    "currency": "EUR", "status": "open", "updated_at": "2026-01-02T03:04:05Z",
}  # fmt: skip
CUSTOMER = {
    "id": "c_1", "name": "Acme", "email": "ap@acme.example", "country": "NL",
    "created_at": "2025-05-06T07:08:09Z",
}  # fmt: skip
ERROR_HOSTS = [
    ("auth", "401 Unauthorized", "unauthorized", "API key is invalid or expired.", None),
    ("limit", "429 Too Many Requests", "rate_limited", "Too many requests.", "1"),
    ("down", "503 Service Unavailable", "unavailable", "Ledgerly is briefly unavailable.", None),
]


def url(host: str, path: str = "") -> str:
    return f"https://{host}.ledgerly.example/api/v2{path}"


def entry(request: str, status: str, body: object, headers: dict | None = None) -> str:
    lines = [f"GET {request} HTTP/1.1", "", f"HTTP/1.1 {status}"]
    lines.append("Content-Type: application/json")
    lines += [f"{k}: {v}" for k, v in (headers or {}).items()]
    return "\n".join([*lines, "", json.dumps(body), ""])


def page(rows: list, cursor: str | None) -> dict:
    return {"data": rows, "next_cursor": cursor}


def mock_text() -> str:
    me = {"id": "acct_1", "name": "Acme"}
    sparse = {k: v for k, v in INVOICE.items() if k not in {"due_at", "total"}}
    sparse.update(id="in_3", number="A-3")
    second = {**INVOICE, "id": "in_2", "number": "A-2"}
    ok = [
        # Invoices: two pages; the last record omits null fields.
        entry(url("ok", "/invoices?limit=200&cursor=i2"), "200 OK", page([sparse], None)),
        entry(url("ok", "/invoices?limit=200"), "200 OK", page([INVOICE, second], "i2")),
        # Customers: an empty page in the middle that still has a next cursor.
        entry(url("ok", "/customers?limit=200&cursor=c3"), "200 OK",
              page([{**CUSTOMER, "id": "c_2"}], None)),
        entry(url("ok", "/customers?limit=200&cursor=c2"), "200 OK", page([], "c3")),
        entry(url("ok", "/customers?limit=200"), "200 OK", page([CUSTOMER], "c2")),
        # Payments: empty.
        entry(url("ok", "/payments?limit=200"), "200 OK", page([], None)),
        entry(url("ok", "/me"), "200 OK", me),
    ]  # fmt: skip
    errors = []
    for host, status, code, text, retry_after in ERROR_HOSTS:
        body = {"error": {"code": code, "message": text}}
        headers = {"Retry-After": retry_after} if retry_after else None
        for path in ["/invoices", "/customers", "/payments", "/me"]:
            errors.append(entry(url(host, path), status, body, headers))
    nav = [entry(url("nav", "/me"), "200 OK", me)]
    return f"\n{SEP}\n\n".join(ok + errors + nav)


def query(source_url: str, body: str) -> str:
    lines = ["let", f'    Source = {KIND}.Contents("{source_url}"),', f"    Result = {body}"]
    return "\n".join([*lines, "in", "    Result", ""])


def table(name: str) -> str:
    return f'Source{{[Name = "{name}"]}}[Data]'


def schema(name: str) -> str:
    return f'Table.SelectColumns(Table.Schema({table(name)}), {{"Name", "Kind"}})'


CHECKS = {
    "navigation": query(url("ok"), 'Table.SelectColumns(Source, {"Name"})'),
    "navigation_lazy": query(url("nav"), 'Table.SelectColumns(Source, {"Name"})'),
    "invoices_rows": query(url("ok"), table("Invoices")),
    "invoices_schema": query(url("ok"), schema("Invoices")),
    "customers_rows": query(url("ok"), table("Customers")),
    "customers_schema": query(url("ok"), schema("Customers")),
    "payments_empty_schema": query(url("ok"), schema("Payments")),
    "payments_empty_rows": query(url("ok"), table("Payments")),
    "error_401": query(url("auth"), table("Invoices")),
    "error_404": query(url("nav"), table("Invoices")),
    "error_429": query(url("limit"), table("Invoices")),
    "error_503": query(url("down"), table("Invoices")),
    "http_rejected": query("http://ok.ledgerly.example/api/v2", table("Invoices")),
}
CREDENTIAL_PATHS = [url(h) for h in ("ok", "nav", "auth", "limit", "down")]
CREDENTIAL_PATHS.append("http://ok.ledgerly.example/api/v2")


def save(path: Path, data: object) -> None:
    path.write_text(json.dumps(data, indent=2) + "\n", encoding="utf-8")


def pqtest(tools: Path, *args: str, stdin: str | None = None, timeout: int = 300) -> dict:
    started = time.monotonic()
    try:
        proc = subprocess.run(
            [str(tools / "PQTest.exe"), *args],
            input=stdin, text=True, encoding="utf-8", capture_output=True, timeout=timeout,
        )  # fmt: skip
        out, code = proc.stdout, proc.returncode
    except subprocess.TimeoutExpired as exc:
        partial = exc.stdout or ""
        out = partial.decode("utf-8", "replace") if isinstance(partial, bytes) else partial
        code = "timeout"
    seconds = round(time.monotonic() - started, 1)
    starts = [i for i in (out.find("["), out.find("{")) if i >= 0]
    try:
        parsed = json.JSONDecoder().raw_decode(out[min(starts) :])[0] if starts else None
    except json.JSONDecodeError:
        parsed = None
    raw = None if parsed else out[-2000:]
    return {"exit": code, "seconds": seconds, "json": parsed, "raw": raw}


def first(result: dict) -> dict:
    data = result["json"]
    if isinstance(data, list):
        data = data[0] if data else None
    return data if isinstance(data, dict) else {}


def message(run: dict) -> str:
    return str((run.get("Error") or {}).get("Message") or run.get("Details") or "")


def norm(name: str) -> str:
    return re.sub(r"[^a-z0-9]", "", name.lower())


def schema_verdict(run: dict, table_name: str) -> tuple[bool, str]:
    if run.get("Status") != "Passed":
        return False, message(run)[:200]
    got = {norm(r["Name"]): r["Kind"] for r in run.get("Output") or []}
    problems = []
    for column, kinds in EXPECTED_KINDS[table_name].items():
        if column not in got:
            problems.append(f"{column} missing")
        elif got[column] not in kinds:
            problems.append(f"{column} is {got[column]}")
    return not problems, "; ".join(problems) or "all columns typed"


def ids(run: dict) -> list:
    rows = run.get("Output") or []
    return [row.get(next((k for k in row if norm(k) == "id"), "id")) for row in rows]


def mock_stats(run: dict) -> dict:
    mock = run.get("HttpMock") or {}
    return {k: mock.get(k) for k in ("RequestCount", "FailedMatches", "UnmatchedRequests")}


def judge(name: str, result: dict) -> dict:
    run = first(result)
    text = message(run)
    note = text[:200]
    requests = (run.get("HttpMock") or {}).get("RequestCount") or 0
    failed = run.get("Status") == "Failed"
    if name == "navigation":
        names = {r.get("Name") for r in run.get("Output") or []}
        ok = names == TABLES
        note = f"names {sorted(n for n in names if n)}" if names else note
    elif name == "navigation_lazy":
        unmatched = (run.get("HttpMock") or {}).get("UnmatchedRequests") or []
        data_calls = [u for u in unmatched if not u.endswith("/me")]
        ok = run.get("Status") == "Passed" and not data_calls
        note = f"data requests while listing: {data_calls}" if data_calls else note
        note = "no data requests" if ok else note
    elif name.endswith("_rows"):
        want = {"invoices_rows": ["in_1", "in_2", "in_3"], "customers_rows": ["c_1", "c_2"]}
        want = want.get(name, [])
        got = ids(run)
        ok = run.get("Status") == "Passed" and got == want
        note = f"ids {got}" if got or ok else note
    elif name.endswith("_schema"):
        ok, note = schema_verdict(run, name.split("_")[0].capitalize())
    elif name == "error_401":
        ok = failed and bool(re.search(r"key|credential|401|unauthori", text, re.I))
    elif name == "error_404":
        ok = failed and bool(re.search(r"invoices|not found|could not find|404", text, re.I))
    elif name in {"error_429", "error_503"}:
        ok = failed and requests > 1 and result["seconds"] < 240
        note = f"{requests} requests, {result['seconds']}s: {text[:160]}"
    elif name == "http_rejected":
        ok = failed and requests == 0 and "https" in text.lower()
    else:
        ok, note = False, "unknown check"
    return {"pass": bool(ok), "note": note, "seconds": result["seconds"], "mock": mock_stats(run)}


def compile_mez(tools: Path, connector: Path, work: Path) -> tuple[Path, str]:
    build = subprocess.run(
        [str(tools / "MakePQX.exe"), "compile", str(connector), "-d", str(work), "-t", KIND],
        text=True, encoding="utf-8", capture_output=True, timeout=300,
    )  # fmt: skip
    return work / f"{KIND}.mez", (build.stdout + build.stderr)[-2000:]


def store_credentials(tools: Path, ext: list[str], creds: Path) -> None:
    creds.unlink(missing_ok=True)
    key = {
        "AuthenticationKind": "Key", "AuthenticationProperties": {"Key": "test-key"},
        "PrivacySetting": "None", "Permissions": [],
    }  # fmt: skip
    for path in CREDENTIAL_PATHS:
        args = ["set-credential", *ext, "-dsk", KIND, "-dsp", path, "-cfp", str(creds)]
        pqtest(tools, *args, stdin=json.dumps(key), timeout=120)


def test_connection(tools: Path, base: list[str], work: Path, path: str, want: bool) -> dict:
    args = ["test-connection", *base, "-dsk", KIND, "-dsp", path]
    result = pqtest(tools, *args)
    save(work / "raw" / f"test_connection_{'ok' if want else '401'}.json", result)
    run = first(result)
    passed = str(run.get("Status", "")).lower() in {"passed", "success"}
    note = message(run)[:200] or str(run.get("Status") or result["raw"])
    return {"pass": passed == want, "note": note, "seconds": result["seconds"]}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Run a trial connector on PQTest, mocked API.")
    parser.add_argument("trial_dir", type=Path)
    parser.add_argument("--tools", type=Path, required=True, help="SdkTools 'tools' folder")
    args = parser.parse_args(argv)
    trial, tools = args.trial_dir.resolve(), args.tools.resolve()
    connector = trial / "connector"
    if not connector.is_dir():
        print(f"{trial.name}: no connector folder")
        return 1
    if not (tools / "PQTest.exe").is_file():
        print(f"{tools}: PQTest.exe not found")
        return 2
    work = trial / "runtime"
    (work / "queries").mkdir(parents=True, exist_ok=True)
    (work / "raw").mkdir(exist_ok=True)
    mez, build_log = compile_mez(tools, connector, work)
    if not mez.is_file():
        save(trial / "runtime.json", {"trial": trial.name, "compile_error": build_log})
        print(f"{trial.name}: compile failed")
        return 1
    ext = ["-e", str(mez)]
    creds = work / "credentials.bin"
    store_credentials(tools, ext, creds)
    mock = work / "ledgerly.mock.txt"
    mock.write_text(mock_text(), encoding="utf-8")
    base = [*ext, "-cfp", str(creds)]

    info = first(pqtest(tools, "info", *ext, timeout=120))
    record: dict = {
        "trial": trial.name,
        "load_error": info.get("ErrorStatus"),
        "shared_functions": [m.get("Name") for m in info.get("Members") or []],
        "checks": {},
    }
    for name, text in CHECKS.items():
        qfile = work / "queries" / f"{name}.query.pq"
        qfile.write_text(text, encoding="utf-8")
        result = pqtest(tools, "run-test", *base, "-q", str(qfile), "-hm", str(mock))
        save(work / "raw" / f"{name}.json", result)
        record["checks"][name] = judge(name, result)
    # test-connection has no HTTP mock option: on the fictional host it can only show
    # whether TestConnection is wired up and fails fast, not that it succeeds.
    record["checks"]["test_connection_runs"] = test_connection(
        tools, base, work, url("ok"), want=False
    )
    passed = sum(c["pass"] for c in record["checks"].values())
    record["passed"], record["total"] = passed, len(record["checks"])
    save(trial / "runtime.json", record)
    failed = [n for n, c in record["checks"].items() if not c["pass"]]
    tail = f", failed: {', '.join(failed)}" if failed else ""
    print(f"{trial.name}: runtime {passed}/{len(record['checks'])}{tail}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
