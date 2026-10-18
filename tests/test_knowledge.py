import re
from datetime import datetime
from pathlib import Path
from urllib.parse import unquote, urlsplit

import pytest

from pqkb import frontmatter

ROOT = Path(__file__).resolve().parents[1]
PATTERNS = sorted((ROOT / "knowledge" / "patterns").glob("*.md"))


def cited_source(resource):
    source = urlsplit(resource)
    relative = unquote(source.path.split("/blob/master/", 1)[1])
    path = (ROOT / relative).resolve()
    assert path.is_relative_to((ROOT / "connectors").resolve())
    start = int(source.fragment.removeprefix("L")) - 1
    return path.read_text(encoding="utf-8-sig").splitlines(), start


@pytest.mark.parametrize(
    "page", [p for p in PATTERNS if p.name != "index.md"], ids=lambda p: p.stem
)
def test_pattern_excerpt_matches_its_cited_source(page):
    document = frontmatter.read(page)
    sources = {source["id"]: source["resource"] for source in document.meta["sources"]}
    assert len(sources) == len(document.meta["sources"])
    assert set(re.findall(r"\[\^([^\]]+)\]", document.body)) <= sources.keys()
    citations = {label: cited_source(resource) for label, resource in sources.items()}
    for lines, start in citations.values():
        assert 0 <= start < len(lines)
    lines, start = citations["example"]
    excerpt = re.search(r"```powerquery\n(.*?)\n```", document.body, re.DOTALL).group(1)
    assert excerpt.splitlines() == lines[start : start + len(excerpt.splitlines())]


def test_bundle_provenance_timestamps_have_explicit_offsets():
    for page in (ROOT / "knowledge").rglob("*.md"):
        metadata = frontmatter.read(page).meta
        if "type" not in metadata:
            continue
        generated = metadata["generated"]
        assert generated["by"], page
        assert datetime.fromisoformat(generated["at"]).utcoffset() is not None, page
        if "stale_after" in metadata:
            assert datetime.fromisoformat(metadata["stale_after"]).utcoffset() is not None, page
        verifications = metadata.get("verified", [])
        if isinstance(verifications, dict):
            verifications = [verifications]
        for verification in verifications:
            assert datetime.fromisoformat(verification["at"]).utcoffset() is not None, page
