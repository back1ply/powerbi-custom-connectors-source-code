"""Read Microsoft's certified connector manifest and pick one package per connector."""

from __future__ import annotations

import json
import urllib.request
from dataclasses import dataclass
from pathlib import PurePosixPath
from urllib.parse import urlparse

MANIFEST_URL = "https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/manifest.json"
PACKAGE_HOST = "content.prod.powerquery.microsoft.com"
PACKAGE_SUFFIXES = (".pqx", ".mez")


@dataclass(frozen=True)
class Package:
    """One downloadable connector package from the manifest."""

    file_name: str
    url: str
    publisher: str
    version: str

    @property
    def name(self) -> str:
        return PurePosixPath(self.file_name).stem


def version_key(version: str) -> tuple[int, ...]:
    """Sort key for dotted versions such as 1.0.10 (non-numeric parts count as 0)."""
    return tuple(int(part) if part.isdigit() else 0 for part in version.split("."))


def fetch_manifest(url: str = MANIFEST_URL) -> dict:
    with urllib.request.urlopen(url, timeout=60) as response:
        return json.load(response)


def _validate(entry: dict) -> Package:
    file_name = entry["fileName"]
    if PurePosixPath(file_name).name != file_name or not file_name.endswith(PACKAGE_SUFFIXES):
        raise ValueError(f"Invalid package file name in manifest: {file_name!r}")
    parsed = urlparse(entry["url"])
    if parsed.scheme != "https" or parsed.hostname != PACKAGE_HOST:
        raise ValueError(f"Unexpected package URL in manifest: {entry['url']!r}")
    return Package(
        file_name=file_name,
        url=entry["url"],
        publisher=entry.get("publisher") or "",
        version=entry["version"],
    )


def latest_packages(manifest: dict) -> list[Package]:
    """Return the highest version of each connector, sorted by name."""
    latest: dict[str, Package] = {}
    for entry in manifest.get("extensions", []):
        package = _validate(entry)
        current = latest.get(package.file_name)
        if current is None or version_key(package.version) > version_key(current.version):
            latest[package.file_name] = package
    if not latest:
        raise ValueError("The certified connector manifest contains no packages.")
    return sorted(latest.values(), key=lambda p: p.name.lower())
