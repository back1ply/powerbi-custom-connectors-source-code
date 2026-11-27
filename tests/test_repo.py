import re
from pathlib import Path

import pytest

from pqkb import bundle, frontmatter, provenance, repo, reviews

ROOT = Path(__file__).resolve().parents[1]
# Files that must hold literal URLs (manifests, settings, prose); everything else derives them.
STATIC_FILES = [
    "README.md",
    ".claude/settings.json",
    ".claude-plugin/marketplace.json",
    "skills/.claude-plugin/plugin.json",
    "skills/.codex-plugin/plugin.json",
    *sorted(str(p.relative_to(ROOT)) for p in (ROOT / "knowledge" / "patterns").glob("*.md")),
]


@pytest.fixture
def renamed(monkeypatch):
    monkeypatch.setattr(repo, "slug", lambda: "back1ply/renamed-repo")


@pytest.mark.parametrize(
    "url",
    [
        "https://github.com/owner/some-repo.git",
        "https://github.com/owner/some-repo",
        "git@github.com:owner/some-repo.git",
    ],
)
def test_remote_url_forms_give_the_slug(url):
    assert repo.parse_remote(url + "\n") == "owner/some-repo"


def test_non_github_remote_is_rejected():
    with pytest.raises(ValueError, match="not a GitHub repository"):
        repo.parse_remote("https://gitlab.com/owner/some-repo.git")


def test_github_repository_variable_wins_over_the_remote(monkeypatch):
    repo.slug.cache_clear()
    monkeypatch.setenv("GITHUB_REPOSITORY", "Owner/from-ci")
    try:
        assert repo.slug() == "Owner/from-ci"
        assert repo.pages_url() == "https://owner.github.io/from-ci/"
    finally:
        repo.slug.cache_clear()


def test_citations_publish_under_the_current_name(renamed):
    path = "connectors/Demo/Demo.pq#L3"
    blob = "https://github.com/back1ply/renamed-repo/blob/main/"
    assert provenance.published(path) == blob + path
    assert provenance.source_url("Demo", "Demo.pq", 3) == blob + path
    assert provenance.published("https://example.com/doc") == "https://example.com/doc"
    legacy = f"{provenance.HASHED_REPO_URL}/blob/main/{path}"
    for form in (path, blob + path, legacy):
        assert provenance.source_path(ROOT, form) == ROOT / "connectors" / "Demo" / "Demo.pq"


def test_citation_outside_the_archive_is_rejected():
    with pytest.raises(ValueError, match="outside this source archive"):
        provenance.source_path(ROOT, "src/pqkb/repo.py")
    with pytest.raises(ValueError, match="escapes"):
        provenance.source_path(ROOT, "connectors/../pyproject.toml")


def test_bundle_rewrites_only_citation_lines_and_keeps_line_endings(renamed):
    authored = b"sources:\r\n- id: a\r\n  resource: connectors/Demo/Demo.pq#L1\r\nresource: x\r\n"
    published = bundle.publish_citations(authored)
    assert published == authored.replace(
        b"connectors/Demo", b"https://github.com/back1ply/renamed-repo/blob/main/connectors/Demo"
    )


def test_renaming_keeps_every_recorded_review_valid(renamed):
    reviewed = 0
    for path in reviews.pattern_paths(ROOT):
        document = frontmatter.read(path)
        if review := document.meta.get("review"):
            assert reviews.fingerprint(ROOT, document) == {
                "content_sha256": review["content_sha256"],
                "sources_sha256": review["sources_sha256"],
            }, path.name
            reviewed += 1
    assert reviewed


def test_static_files_name_the_current_repository():
    owner, name = repo.slug().split("/")
    o = re.escape(owner)
    references = [  # Each captures the repository name after this owner.
        rf"github\.com/{o}/([\w.-]+)",
        rf"{o}\.github\.io/([\w.-]+)",
        rf"\"repo\":\s*\"{o}/([\w.-]+)\"",
    ]
    found = [
        (file, match)
        for file in STATIC_FILES
        for pattern in references
        for match in re.findall(pattern, (ROOT / file).read_text(encoding="utf-8"), re.I)
    ]
    assert found
    assert [(file, match) for file, match in found if match != name] == []
