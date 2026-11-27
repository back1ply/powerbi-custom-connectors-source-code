"""Resolve archived source citations and their published GitHub URLs.

Authored pattern pages cite archive files by repository path, such as
``connectors/Asana/Asana.m#L217``; the bundle publishes them as GitHub URLs for
wherever the repository lives now (see ``pqkb.repo``).
"""

import re
from pathlib import Path
from urllib.parse import quote, unquote, urldefrag

from pqkb import repo

ARCHIVE = "connectors/"
# Recorded review fingerprints hashed citations as URLs under this name, so
# reviews.authored_digest still hashes them in this form; changing it would
# invalidate every recorded review. It is not where the repository lives.
HASHED_REPO_URL = "https://github.com/back1ply/powerbi-custom-connectors-source-code"
HASHED_PAGES_URL = "https://back1ply.github.io/powerbi-custom-connectors-source-code"


def citation(connector: str, file: str, line: int | None = None) -> str:
    """Return the repository-relative form that authored pages use."""
    path = f"{ARCHIVE}{quote(connector)}/{quote(file)}"
    return f"{path}#L{line}" if line else path


def source_url(connector: str, file: str, line: int | None = None) -> str:
    return published(citation(connector, file, line))


def archive_path(resource: str) -> str | None:
    """Return the citation without its repository prefix, or None outside the archive."""
    for prefix in ("", f"{repo.blob_url()}/", f"{HASHED_REPO_URL}/blob/main/"):
        if resource.startswith(prefix + ARCHIVE):
            return resource.removeprefix(prefix)
    return None


def published(resource: str) -> str:
    """Absolute GitHub URL for an archive citation; other resources are unchanged."""
    path = archive_path(resource)
    return f"{repo.blob_url()}/{path}" if path else resource


def hashed(resource: str) -> str:
    """The form review fingerprints hash, independent of where the repository lives."""
    path = archive_path(resource)
    return f"{HASHED_REPO_URL}/blob/main/{path}" if path else resource


def hashed_text(text: str) -> str:
    """Replace links to the current repository and site with the hashed name, for fingerprints."""
    for current, fixed in (
        (repo.github_url(), HASHED_REPO_URL),
        (repo.pages_url().rstrip("/"), HASHED_PAGES_URL),
    ):
        text = re.sub(re.escape(current) + r"(?![\w.-])", fixed, text)
    return text


def source_path(repo_root: Path, resource: str) -> Path:
    path = archive_path(resource)
    if path is None:
        raise ValueError(f"Citation is outside this source archive: {resource}")
    root = (repo_root / ARCHIVE).resolve()
    target = (repo_root / unquote(urldefrag(path).url)).resolve()
    if not target.is_relative_to(root):
        raise ValueError(f"Citation escapes the source archive: {resource}")
    return target
