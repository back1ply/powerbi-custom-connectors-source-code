import codecs
import json
import shutil
import urllib.error
import zipfile
from datetime import UTC, datetime
from pathlib import Path

import pytest

from pqkb import bundle, frontmatter, refresh
from pqkb.cli import main
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
        entry("..\\A.pqx", "1"),
        entry("C:\\A.pqx", "1"),
        entry("A.exe", "1"),
    ],
)
def test_latest_packages_rejects_unexpected_entries(bad):
    with pytest.raises(ValueError):
        latest_packages({"extensions": [bad]})


def test_manifest_rejects_connector_names_shared_by_different_package_formats():
    with pytest.raises(ValueError, match="Duplicate connector name"):
        latest_packages({"extensions": [entry("Demo.mez", "1"), entry("demo.pqx", "2")]})


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


def test_local_refresh_replaces_complete_set_redacts_and_rebuilds(repo):
    bundle.build(repo)
    packages = repo / "packages"
    packages.mkdir()
    make_package(packages / "New.mez", {"New.pq": M_SOURCE, "resources.resx": RESX})
    assert main(["--repo", str(repo), "refresh", "--source-dir", str(packages)]) == 0
    assert not (repo / "connectors" / "Demo").exists()
    assert REDACTED in (repo / "connectors" / "New" / "New.pq").read_text()
    assert not (repo / "build" / "knowledge" / "connectors" / "Demo.md").exists()
    assert (repo / "build" / "knowledge" / "connectors" / "New.md").is_file()
    log = (repo / "knowledge" / "log.md").read_text()
    assert "**Creation**" in log and "**Deletion**: Removed Demo" in log
    record = refresh.load_index(repo / "connectors")["New"]
    assert (record.version, record.publisher, record.package_url) == ("", "", "")


@pytest.mark.parametrize(
    "failure", ["empty", "missing", "duplicate", "corrupt", "no-source", "inside"]
)
def test_invalid_local_packages_preserve_existing_archive(repo, failure):
    source = repo / "packages"
    source.mkdir()
    if failure == "missing":
        source = repo / "missing"
    elif failure == "duplicate":
        make_package(source / "Demo.mez", {"Demo.pq": M_SOURCE})
        make_package(source / "demo.pqx", {"Demo.pq": M_SOURCE})
    elif failure == "corrupt":
        (source / "Bad.mez").write_text("not an archive")
    elif failure == "no-source":
        make_package(source / "Bad.mez", {"icon.png": "image"})
    elif failure == "inside":
        source = repo / "connectors"
    before = {p: p.read_bytes() for p in (repo / "connectors").rglob("*") if p.is_file()}
    with pytest.raises((ValueError, zipfile.BadZipFile)):
        refresh.refresh(repo, source_dir=source)
    assert {p: p.read_bytes() for p in (repo / "connectors").rglob("*") if p.is_file()} == before
    assert not list(repo.glob(".refresh-*"))


@pytest.mark.parametrize(
    ("manifest", "expected_error"),
    [({}, ValueError), ({"extensions": [entry("New.mez", "1")]}, urllib.error.URLError)],
)
def test_feed_failure_preserves_existing_archive(repo, monkeypatch, manifest, expected_error):
    def unavailable(url, **kwargs):
        raise urllib.error.URLError("download unavailable")

    monkeypatch.setattr("urllib.request.urlopen", unavailable)
    original = (repo / "connectors" / "index.json").read_bytes()
    with pytest.raises(expected_error):
        refresh.refresh(repo, manifest)
    assert (repo / "connectors" / "index.json").read_bytes() == original
    assert (repo / "connectors" / "Demo" / "Demo.pq").read_text() == M_SOURCE
    assert not list(repo.glob(".refresh-*"))


def test_failed_archive_install_restores_previous_tree(repo, monkeypatch):
    source = repo / "packages"
    source.mkdir()
    make_package(source / "New.mez", {"New.pq": M_SOURCE})
    rename = Path.rename

    def fail_install(path, target):
        if path.name == "connectors" and path.parent.name.startswith(".refresh-"):
            raise OSError("install failed")
        return rename(path, target)

    monkeypatch.setattr(Path, "rename", fail_install)
    with pytest.raises(OSError, match="install failed"):
        refresh.refresh(repo, source_dir=source)
    assert (repo / "connectors" / "Demo" / "Demo.pq").read_text() == M_SOURCE
    assert not (repo / "connectors" / "New").exists()


def test_failed_rollback_keeps_previous_tree_for_recovery(repo, monkeypatch):
    source = repo / "packages"
    source.mkdir()
    make_package(source / "New.mez", {"New.pq": M_SOURCE})
    rename = Path.rename

    def fail_install_and_recovery(path, target):
        if path.parent.name.startswith(".refresh-"):
            raise OSError("filesystem unavailable")
        return rename(path, target)

    monkeypatch.setattr(Path, "rename", fail_install_and_recovery)
    with pytest.raises(OSError, match="previous connectors retained at"):
        refresh.refresh(repo, source_dir=source)
    backups = list(repo.glob(".refresh-*/previous/Demo/Demo.pq"))
    assert len(backups) == 1
    assert backups[0].read_text() == M_SOURCE


def test_build_writes_connector_page_and_seen_in(repo):
    authored = (repo / "knowledge" / "patterns" / "retries.md").read_bytes()
    bundle.build(repo, datetime(2026, 10, 17, tzinfo=UTC))
    page = frontmatter.read(repo / "build" / "knowledge" / "connectors" / "Demo.md")
    assert page.meta["type"] == "Power Query Connector"
    assert page.meta["tags"] == ["oauth", "usernamepassword"]
    assert page.meta["generated"] == {"by": "process:pqkb-build", "at": "2026-10-17T00:00:00Z"}
    assert "stale_after" not in page.meta  # Building is not a source refresh.
    assert "(../patterns/retries.md)" in page.body
    pattern = (repo / "build" / "knowledge" / "patterns" / "retries.md").read_text(encoding="utf-8")
    assert "**0 agent-supported; 1 uncertain or awaiting review.**" in pattern
    assert "Demo.pq#L12" in pattern
    assert (repo / "knowledge" / "patterns" / "retries.md").read_bytes() == authored
    root = (repo / "build" / "knowledge" / "index.md").read_text(encoding="utf-8")
    assert "patterns/index.md" in root
    directory = (repo / "build" / "knowledge" / "patterns" / "index.md").read_text(encoding="utf-8")
    assert "# Data retrieval" in directory and "retries.md" in directory
    assert frontmatter.parse(root).meta == {"okf_version": "0.2"}
    assert (repo / "knowledge" / "log.md").is_file()
    tags = (repo / "build" / "knowledge" / "tags" / "index.md").read_text()
    assert "# retries" not in tags
    assert "# oauth" in tags and "(../connectors/Demo.md)" in tags


def test_build_is_stable_when_nothing_changed(repo):
    bundle.build(repo, datetime(2026, 10, 17, tzinfo=UTC))
    first = {path: path.read_bytes() for path in (repo / "build" / "knowledge").rglob("*.md")}
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    assert {
        path: path.read_bytes() for path in (repo / "build" / "knowledge").rglob("*.md")
    } == first


def test_refresh_confirmation_survives_rebuild_without_regenerating_content(repo):
    bundle.build(repo, datetime(2026, 10, 17, tzinfo=UTC))
    bundle.confirm_archive(repo, datetime(2026, 11, 1, tzinfo=UTC))
    bundle.build(repo, datetime(2026, 11, 2, tzinfo=UTC))
    page = frontmatter.read(repo / "build" / "knowledge" / "connectors" / "Demo.md")
    assert page.meta["generated"]["at"] == "2026-10-17T00:00:00Z"
    assert page.meta["verified"] == {"by": "process:pqkb-refresh", "at": "2026-11-01T00:00:00Z"}
    assert page.meta["stale_after"] == "2026-11-15T00:00:00Z"
    bundle.append_log(
        repo / "knowledge" / "log.md", refresh.Changes(), {}, datetime(2026, 11, 1, tzinfo=UTC)
    )
    assert "no package version changes" in (repo / "knowledge" / "log.md").read_text()
    output = (repo / "build").resolve()
    assert output.parent == repo.resolve()
    shutil.rmtree(output)
    bundle.build(repo, datetime(2026, 11, 3, tzinfo=UTC))
    rebuilt = frontmatter.read(repo / "build" / "knowledge" / "connectors" / "Demo.md")
    assert rebuilt.meta["verified"] == page.meta["verified"]
    assert rebuilt.meta["stale_after"] == page.meta["stale_after"]
    source = repo / "connectors" / "Demo" / "Demo.pq"
    source.write_text(source.read_text() + "\n// Archive changed outside refresh.\n")
    bundle.build(repo, datetime(2026, 11, 4, tzinfo=UTC))
    changed = frontmatter.read(repo / "build" / "knowledge" / "connectors" / "Demo.md")
    assert "verified" not in changed.meta
    assert "stale_after" not in changed.meta


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
    bundle.build(repo, day)
    assert log.read_text(encoding="utf-8") == text


def test_index_json_round_trip(repo):
    data = json.loads((repo / "connectors" / "index.json").read_text(encoding="utf-8"))
    assert data["connectors"][0]["name"] == "Demo"
