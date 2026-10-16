import codecs
import json
import zipfile
from datetime import UTC, datetime
from pathlib import Path

import pytest

from pqkb import bundle, frontmatter
from pqkb.manifest import latest_packages
from pqkb.package import extract_package, safe_extract
from pqkb.redact import REDACTED, redact_file
from pqkb.refresh import ConnectorRecord, diff, write_index
from pqkb.scan import Rule, auth_kinds, scan

HOST = "https://content.prod.powerquery.microsoft.com/api/certifiedExtensions"
RESX = """<?xml version="1.0" encoding="utf-8"?><root>
<data name="ButtonTitle" xml:space="preserve"><value>Demo</value></data>
<data name="ButtonHelp" xml:space="preserve"><value>Connect to   Demo.</value></data>
</root>"""
M_SOURCE = """section Demo;
client_id = "public-client-id-123";
client_secret = "s3cr3tvalue!!";
token_url = "https://login.example.com/token";
Demo = [
    Authentication = [
        OAuth = [ StartLogin = StartLogin, Label = "x = [ y ]" ],
        // Key = [ ] is only a comment
        UsernamePassword = []
    ]
];
result = Value.WaitFor((i) => i, (i) => #duration(0, 0, 0, i));
"""


def entry(name: str, version: str, url: str | None = None) -> dict:
    return {
        "fileName": name,
        "version": version,
        "publisher": "Pub",
        "url": url or f"{HOST}/{name}/{version}/{name}",
    }


def make_package(path: Path, files: dict[str, str]) -> Path:
    with zipfile.ZipFile(path, "w") as zf:
        for name, text in files.items():
            zf.writestr(name, text)
    return path


# manifest ---------------------------------------------------------------------------------


def test_latest_packages_compares_versions_numerically():
    manifest = {
        "extensions": [entry("A.pqx", "1.0.9"), entry("A.pqx", "1.0.10"), entry("B.mez", "2.0")]
    }
    picked = {p.name: p.version for p in latest_packages(manifest)}
    assert picked == {"A": "1.0.10", "B": "2.0"}


@pytest.mark.parametrize(
    "bad",
    [
        entry("A.pqx", "1", url="https://evil.example.com/A.pqx"),
        entry("../A.pqx", "1"),
        entry("A.exe", "1"),
    ],
)
def test_latest_packages_rejects_unexpected_entries(bad):
    with pytest.raises(ValueError):
        latest_packages({"extensions": [bad]})


# redaction --------------------------------------------------------------------------------


def test_redacts_secrets_but_keeps_client_ids_and_urls(tmp_path):
    source = tmp_path / "Demo.pq"
    source.write_text(M_SOURCE, encoding="utf-8")
    assert redact_file(source) == 1
    text = source.read_text(encoding="utf-8")
    assert f'client_secret = "{REDACTED}"' in text
    assert "public-client-id-123" in text
    assert "https://login.example.com/token" in text


def test_redaction_keeps_byte_order_mark(tmp_path):
    source = tmp_path / "Demo.pq"
    source.write_bytes(codecs.BOM_UTF8 + M_SOURCE.encode("utf-8"))
    redact_file(source)
    assert source.read_bytes().startswith(codecs.BOM_UTF8 + b"section Demo;")


def test_redacts_secret_files_and_json(tmp_path):
    (tmp_path / "client_secret").write_text("abc123", encoding="utf-8")
    (tmp_path / "client_id").write_text("keep-me", encoding="utf-8")
    (tmp_path / "Config.json").write_text(
        '{"apiKey": "abcdefgh1234", "name": "x"}', encoding="utf-8"
    )
    assert redact_file(tmp_path / "client_secret") == 1
    assert redact_file(tmp_path / "client_id") == 0
    assert redact_file(tmp_path / "Config.json") == 1
    assert (tmp_path / "client_secret").read_text(encoding="utf-8").strip() == REDACTED
    assert REDACTED in (tmp_path / "Config.json").read_text(encoding="utf-8")


# package extraction -----------------------------------------------------------------------


def test_extract_package_reads_titles_strips_noise_and_redacts(tmp_path):
    archive = make_package(
        tmp_path / "Demo.pqx",
        {
            "Demo.pq": M_SOURCE,
            "resources.resx": RESX,
            "Demo16.png": "png",
            "_rels/.rels": "x",
            "lib/Helpers.pqm": "shared x = 1;",
        },
    )
    out = tmp_path / "Demo"
    extracted = extract_package(archive, out)
    assert extracted.resources == {"ButtonTitle": "Demo", "ButtonHelp": "Connect to Demo."}
    assert extracted.source_files == ["Demo.pq", "lib/Helpers.pqm"]
    assert extracted.redactions == 1
    assert sorted(p.name for p in out.rglob("*")) == ["Demo.pq", "Helpers.pqm", "lib"]


def test_safe_extract_refuses_path_traversal(tmp_path):
    archive = make_package(tmp_path / "Bad.pqx", {"../escape.pq": "x"})
    with pytest.raises(ValueError):
        safe_extract(archive, tmp_path / "out")


# scanning ---------------------------------------------------------------------------------


def test_auth_kinds_reads_top_level_fields_only():
    assert auth_kinds(M_SOURCE) == {"OAuth", "UsernamePassword"}


def test_scan_reports_first_matching_line_per_file():
    rule = Rule.build("retries", [r"Value\.WaitFor"])
    hits = scan({"Demo": {"Demo.pq": M_SOURCE, "Other.pqm": "x"}}, [rule])
    assert [(h.connector, h.file, h.line) for h in hits["retries"]] == [("Demo", "Demo.pq", 12)]


def test_diff_reports_added_removed_and_updated():
    def rec(name, version):
        return ConnectorRecord(name, name, "", "", version, "", [])

    changes = diff(
        {"A": rec("A", "1"), "B": rec("B", "1")}, {"A": rec("A", "2"), "C": rec("C", "1")}
    )
    assert (changes.added, changes.removed, changes.updated) == (["C"], ["B"], [("A", "1", "2")])


# bundle -----------------------------------------------------------------------------------

PATTERN = """---
type: Power Query Pattern
title: Retries with Value.WaitFor
description: Retry transient failures.
category: Data retrieval
detect: ['Value\\.WaitFor']
---

Body text.

# Seen in

<!-- seen-in:start -->
<!-- seen-in:end -->
"""


@pytest.fixture
def repo(tmp_path):
    (tmp_path / "pyproject.toml").write_text("", encoding="utf-8")
    connector = tmp_path / "connectors" / "Demo"
    connector.mkdir(parents=True)
    (connector / "Demo.pq").write_text(M_SOURCE, encoding="utf-8")
    write_index(
        tmp_path / "connectors",
        [
            ConnectorRecord(
                "Demo", "Demo", "Connect to Demo.", "Pub", "1.0", f"{HOST}/Demo.pqx", ["Demo.pq"]
            ),
        ],
    )
    patterns = tmp_path / "knowledge" / "patterns"
    patterns.mkdir(parents=True)
    (patterns / "retries.md").write_text(PATTERN, encoding="utf-8")
    return tmp_path


def test_build_writes_connector_page_and_seen_in(repo):
    bundle.build(repo, datetime(2026, 10, 17, tzinfo=UTC))
    page = frontmatter.read(repo / "knowledge" / "connectors" / "Demo.md")
    assert page.meta["type"] == "Power Query Connector"
    assert page.meta["tags"] == ["oauth", "usernamepassword"]
    assert page.meta["generated"] == {"by": "process:pqkb-build", "at": "2026-10-17T00:00:00Z"}
    assert page.meta["stale_after"] == "2026-10-31T00:00:00Z"
    assert "(../patterns/retries.md)" in page.body
    pattern = (repo / "knowledge" / "patterns" / "retries.md").read_text(encoding="utf-8")
    assert "Detected in **1** connector in this archive." in pattern
    assert "Demo.pq#L12" in pattern
    root = (repo / "knowledge" / "index.md").read_text(encoding="utf-8")
    assert "# Data retrieval" in root and "patterns/retries.md" in root


def test_build_is_stable_when_nothing_changed(repo):
    bundle.build(repo, datetime(2026, 10, 17, tzinfo=UTC))
    first = (repo / "knowledge" / "connectors" / "Demo.md").read_text(encoding="utf-8")
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    assert (repo / "knowledge" / "connectors" / "Demo.md").read_text(encoding="utf-8") == first


def test_append_log_groups_entries_by_day(repo):
    from pqkb.refresh import Changes, load_index

    log = repo / "knowledge" / "log.md"
    records = load_index(repo / "connectors")
    day = datetime(2026, 10, 17, tzinfo=UTC)
    bundle.append_log(log, Changes(added=["Demo"]), records, day)
    bundle.append_log(log, Changes(removed=["Old"]), records, day)
    text = log.read_text(encoding="utf-8")
    assert text.count("## 2026-10-17") == 1
    assert "**Creation**" in text and "**Deletion**: Removed Old" in text


def test_index_json_round_trip(repo):
    data = json.loads((repo / "connectors" / "index.json").read_text(encoding="utf-8"))
    assert data["connectors"][0]["name"] == "Demo"
