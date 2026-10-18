from datetime import UTC, datetime

import pytest

from pqkb import bundle, frontmatter, reviews
from pqkb.cli import main
from pqkb.provenance import source_url
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
        "detect": [r"\bDemo\b"],
        "sources": [{"id": "example", "resource": source_url("Demo", "Demo.pq", 1)}],
    }
    page.write_text(frontmatter.render(metadata, "Reviewed source explanation."), encoding="utf-8")
    bundle.build(tmp_path, DAY)
    reviews.record_review(tmp_path, page, "codex/gpt-6", DAY)
    return tmp_path, page, source


@pytest.mark.parametrize("change", ["source", "prose", "detect", "citation"])
def test_changed_review_scope_returns_to_draft_and_blocks_publication(reviewed_repo, change):
    repo, page, source = reviewed_repo
    if change == "source":
        source.write_text(source.read_text() + "// Changed source context.\n", encoding="utf-8")
    else:
        document = frontmatter.read(page)
        if change == "prose":
            document.body += "\nAn unreviewed assertion.\n"
        elif change == "detect":
            document.meta["detect"] = ["unreviewed-rule"]
        else:
            document.meta["sources"][0]["resource"] = source_url("Demo", "missing.pq", 1)
        page.write_text(frontmatter.render(document.meta, document.body), encoding="utf-8")
    assert main(["--repo", str(repo), "verify-reviews"]) == 1
    bundle.build(repo, DAY)
    metadata = frontmatter.read(page).meta
    assert metadata["status"] == "draft"
    assert "verified" not in metadata
    assert metadata["review_pending"]
    assert reviews.check_reviews(repo)


def test_new_detector_matches_preserve_review_of_unchanged_prose_and_sources(reviewed_repo):
    repo, page, _ = reviewed_repo
    original = frontmatter.read(page)
    other = repo / "connectors" / "Other" / "Other.pq"
    other.parent.mkdir()
    other.write_text("// Demo pattern match\n", encoding="utf-8")
    write_index(
        repo / "connectors",
        [
            ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"]),
            ConnectorRecord("Other", "Other", "", "", "1", "", ["Other.pq"]),
        ],
    )
    bundle.build(repo, DAY)
    updated = frontmatter.read(page)
    assert "Detected in **2** connectors" in updated.body
    assert updated.meta["verified"] == original.meta["verified"]
    assert main(["--repo", str(repo), "verify-reviews"]) == 0


def test_windows_line_endings_do_not_expire_a_source_review(reviewed_repo):
    repo, _, source = reviewed_repo
    source.write_bytes(source.read_bytes().replace(b"\n", b"\r\n"))
    bundle.build(repo, DAY)
    assert reviews.check_reviews(repo) == []


@pytest.mark.parametrize("field", ["verified", "status"])
def test_fingerprints_without_a_stable_verification_cannot_publish(reviewed_repo, field):
    repo, page, _ = reviewed_repo
    document = frontmatter.read(page)
    document.meta.pop(field)
    page.write_text(frontmatter.render(document.meta, document.body), encoding="utf-8")
    assert reviews.check_reviews(repo)


def test_empty_pattern_directory_cannot_pass_publication_checks(tmp_path):
    assert reviews.check_reviews(tmp_path)
