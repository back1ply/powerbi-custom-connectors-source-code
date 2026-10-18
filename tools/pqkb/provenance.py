"""Resolve archived source citations and their published GitHub URLs."""

from pathlib import Path
from urllib.parse import quote, unquote, urldefrag

REPO_BLOB = "https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master"


def source_url(connector: str, file: str, line: int | None = None) -> str:
    url = f"{REPO_BLOB}/connectors/{quote(connector)}/{quote(file)}"
    return f"{url}#L{line}" if line else url


def source_path(repo: Path, resource: str) -> Path:
    url, _ = urldefrag(resource)
    prefix = f"{REPO_BLOB}/connectors/"
    if not url.startswith(prefix):
        raise ValueError(f"Citation is outside this source archive: {resource}")
    root = (repo / "connectors").resolve()
    path = (root / unquote(url.removeprefix(prefix))).resolve()
    if not path.is_relative_to(root):
        raise ValueError(f"Citation escapes the source archive: {resource}")
    return path
