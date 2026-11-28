import json
import zipfile
from datetime import UTC, datetime

import pytest

from pqkb import bundle, frontmatter, reviews
from pqkb.cli import main
from pqkb.provenance import citation
from pqkb.refresh import ConnectorRecord, write_index

DAY = datetime(2026, 10, 18, tzinfo=UTC)


@pytest.fixture
def reviewed_repo(tmp_path):
    (tmp_path / "pyproject.toml").touch()
    source = tmp_path / "connectors" / "Demo" / "Demo.pq"
    source.parent.mkdir(parents=True)
    source.write_text("section Demo;\nshared Demo.Contents = 1;\n", encoding="utf-8", newline="\n")
    write_index(
        tmp_path / "connectors", [ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"])]
    )
    page = tmp_path / "knowledge" / "patterns" / "demo.md"
    page.parent.mkdir(parents=True)
    metadata = {
        "type": "Power Query Pattern",
        "title": "Demo",
        "description": "A source review fixture.",
        "sources": [{"id": "example", "resource": citation("Demo", "Demo.pq", 1)}],
    }
    page.write_text(frontmatter.render(metadata, "Reviewed source explanation."), encoding="utf-8")
    bundle.build(tmp_path, DAY)
    reviews.record_review(tmp_path, page, "codex/gpt-6", DAY)
    return tmp_path, page, source


@pytest.mark.parametrize("change", ["source", "prose", "metadata", "citation"])
def test_changed_review_scope_is_reported_and_marked_stale_without_editing_the_page(
    reviewed_repo, change
):
    repo, page, source = reviewed_repo
    if change == "source":
        source.write_text(source.read_text() + "// Changed source context.\n", encoding="utf-8")
    else:
        document = frontmatter.read(page)
        if change == "prose":
            document.body += "\nAn unreviewed assertion.\n"
        elif change == "metadata":
            document.meta["description"] = "An unreviewed summary."
        else:
            document.meta["sources"][0]["resource"] = citation("Demo", "missing.pq", 1)
        page.write_text(frontmatter.render(document.meta, document.body), encoding="utf-8")
    authored = page.read_bytes()
    assert main(["--repo", str(repo), "verify-reviews"]) == 1
    bundle.build(repo, DAY)
    # The authored page is never rewritten by a build.
    assert page.read_bytes() == authored
    built = frontmatter.read(repo / "bundle" / "patterns" / page.name)
    assert bundle.DRIFT_BANNER in built.body
    assert built.meta["status"] == "stable"
    assert "stale_after" not in built.meta  # No refresh receipt yet: no date is invented.
    assert reviews.check_reviews(repo)


def test_drifted_page_gets_the_refresh_time_as_stale_after_and_rebuilds_identically(
    reviewed_repo,
):
    repo, page, source = reviewed_repo
    source.write_text(source.read_text() + "// Changed source context.\n", encoding="utf-8")
    bundle.confirm_archive(repo, DAY)
    bundle.build(repo, DAY)
    built_path = repo / "bundle" / "patterns" / page.name
    built = frontmatter.read(built_path)
    assert built.meta["stale_after"] == "2026-10-18T00:00:00Z"
    assert built.body.lstrip().startswith(bundle.DRIFT_BANNER)
    first = built_path.read_bytes()
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    assert built_path.read_bytes() == first


def test_refresh_marks_drift_with_its_own_receipt_and_a_later_build_changes_nothing(
    reviewed_repo,
):
    repo, page, _ = reviewed_repo
    bundle.confirm_archive(repo, DAY)  # An earlier refresh whose time must not be reused.
    bundle.build(repo, DAY)
    packages = repo.parent / f"{repo.name}-packages"
    packages.mkdir()
    with zipfile.ZipFile(packages / "Demo.mez", "w") as package:
        package.writestr("Demo.pq", "section Demo;\nshared Demo.Contents = 2;\n")
    assert main(["--repo", str(repo), "refresh", "--source-dir", str(packages)]) == 0
    receipt = json.loads((repo / "knowledge" / "refresh.json").read_text("utf-8"))
    built = frontmatter.read(repo / "bundle" / "patterns" / page.name)
    assert bundle.DRIFT_BANNER in built.body
    assert built.meta["stale_after"] == receipt["verified_at"] != "2026-10-18T00:00:00Z"
    first = {path: path.read_bytes() for path in (repo / "bundle").rglob("*.md")}
    assert main(["--repo", str(repo), "build"]) == 0
    assert {path: path.read_bytes() for path in (repo / "bundle").rglob("*.md")} == first


def test_drift_banner_follows_the_page_title():
    text = '---\ntitle: "Demo"\n---\n\n# Demo\n\nBody text.\n'
    marked = bundle.mark_drift(text, "2026-10-18T00:00:00Z")
    header, body = marked.split("\n---\n", 1)
    assert header.endswith('\nstale_after: "2026-10-18T00:00:00Z"')
    assert body == f"\n# Demo\n\n{bundle.DRIFT_BANNER}\n\nBody text.\n"


def test_drifted_page_with_windows_line_endings_keeps_them_and_rebuilds_identically(
    reviewed_repo,
):
    repo, page, source = reviewed_repo
    document = frontmatter.read(page)
    body = "# Demo\n\nReviewed source explanation."
    page.write_text(frontmatter.render(document.meta, body), encoding="utf-8")
    reviews.record_review(repo, page, "codex/gpt-6", DAY)
    authored = page.read_bytes().decode("utf-8").replace("\r\n", "\n")
    page.write_bytes(authored.replace("\n", "\r\n").encode("utf-8"))
    source.write_text(source.read_text() + "// Changed source context.\n", encoding="utf-8")
    bundle.confirm_archive(repo, DAY)
    bundle.build(repo, DAY)
    built_path = repo / "bundle" / "patterns" / page.name
    first = built_path.read_bytes()
    published = bundle.publish_citations(authored.encode("utf-8")).decode("utf-8")
    expected = bundle.mark_drift(published, "2026-10-18T00:00:00Z").replace("\n", "\r\n")
    assert first == expected.encode("utf-8")
    assert b"resource: https://github.com/" in first
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    assert built_path.read_bytes() == first


def test_new_connectors_preserve_review_of_unchanged_prose_and_sources(reviewed_repo):
    repo, page, _ = reviewed_repo
    original = frontmatter.read(page)
    other = repo / "connectors" / "Other" / "Other.pq"
    other.parent.mkdir()
    other.write_text("section Demo;\n", encoding="utf-8")
    write_index(
        repo / "connectors",
        [
            ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"]),
            ConnectorRecord("Other", "Other", "", "", "1", "", ["Other.pq"]),
        ],
    )
    bundle.build(repo, DAY)
    updated = frontmatter.read(page)
    generated = frontmatter.read(repo / "bundle" / "patterns" / page.name)
    assert generated.body == original.body
    assert reviews.review_reason(repo, generated) == ""
    assert updated.body == original.body
    assert updated.meta["verified"] == original.meta["verified"]
    assert main(["--repo", str(repo), "verify-reviews"]) == 0


def test_windows_line_endings_do_not_expire_a_source_review(reviewed_repo):
    repo, _, source = reviewed_repo
    source.write_bytes(source.read_bytes().replace(b"\n", b"\r\n"))
    bundle.build(repo, DAY)
    assert reviews.check_reviews(repo) == []


@pytest.mark.parametrize("field", ["verified", "status"])
def test_fingerprints_without_a_stable_verification_are_reported(reviewed_repo, field):
    repo, page, _ = reviewed_repo
    document = frontmatter.read(page)
    document.meta.pop(field)
    page.write_text(frontmatter.render(document.meta, document.body), encoding="utf-8")
    assert reviews.check_reviews(repo)


def test_empty_pattern_directory_is_reported(tmp_path):
    assert reviews.check_reviews(tmp_path)
