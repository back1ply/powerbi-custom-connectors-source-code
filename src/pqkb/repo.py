"""Where this repository lives on GitHub, derived instead of written into files.

CI sets GITHUB_REPOSITORY; a local checkout reads its origin remote. Renaming the
repository therefore changes every generated URL with no source edit.
"""

from __future__ import annotations

import os
import re
import subprocess
from functools import cache
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SLUG = re.compile(r"^[\w.-]+/[\w.-]+$")
REMOTE = re.compile(
    r"^(?:https://(?:[^@/\s]+@)?github\.com/|git@github\.com:|ssh://git@github\.com/)"
    r"([\w.-]+/[\w.-]+?)(?:\.git)?/?$"
)


def parse_remote(url: str) -> str:
    match = REMOTE.match(url.strip())
    if not match:
        # The URL is left out: remotes can embed credentials.
        raise ValueError("Origin remote is not a GitHub repository")
    return match.group(1)


@cache
def slug() -> str:
    """Return ``owner/name``: GITHUB_REPOSITORY in CI, else the origin remote."""
    env = os.environ.get("GITHUB_REPOSITORY", "")
    if SLUG.match(env):
        return env
    try:
        url = subprocess.run(
            ["git", "-C", str(ROOT), "remote", "get-url", "origin"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout
    except (OSError, subprocess.CalledProcessError) as error:
        raise RuntimeError(
            "Cannot tell which GitHub repository this is: set GITHUB_REPOSITORY=owner/name "
            "or add an origin remote"
        ) from error
    return parse_remote(url)


def github_url() -> str:
    return f"https://github.com/{slug()}"


def blob_url() -> str:
    return f"{github_url()}/blob/main"


def pages_url() -> str:
    owner, name = slug().split("/")
    return f"https://{owner.lower()}.github.io/{name}/"
