"""Read Microsoft's certified connector manifest and pick one package per connector."""

from __future__ import annotations

import json
import urllib.request
from dataclasses import dataclass
from pathlib import PurePosixPath, PureWindowsPath
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


def package_file_name(file_name: str) -> bool:
    bare_name = all(path(file_name).name == file_name for path in (PurePosixPath, PureWindowsPath))
    return bare_name and file_name.lower().endswith(PACKAGE_SUFFIXES)


def _validate(entry: dict) -> Package:
    file_name = entry["fileName"]
    if not package_file_name(file_name):
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


def unique_names(packages: list[Package]) -> None:
    names: set[str] = set()
    for package in packages:
        name = package.name.casefold()
        if name in names:
            raise ValueError(f"Duplicate connector name: {package.name}")
        names.add(name)


def latest_packages(manifest: dict) -> list[Package]:
    """Return the highest version of each connector, sorted by name."""
    latest: dict[str, Package] = {}
    for entry in manifest.get("extensions", []):
        package = _validate(entry)
        key = package.file_name.casefold()
        current = latest.get(key)
        if current is None or version_key(package.version) > version_key(current.version):
            latest[key] = package
    if not latest:
        raise ValueError("The certified connector manifest contains no packages.")
    packages = sorted(latest.values(), key=lambda p: p.name.lower())
    unique_names(packages)
    return packages
