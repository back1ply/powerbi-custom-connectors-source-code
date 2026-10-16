"""Unpack one connector package into a clean source folder."""

from __future__ import annotations

import zipfile
from dataclasses import dataclass, field
from pathlib import Path
from xml.etree import ElementTree

from pqkb.redact import redact_tree

M_SUFFIXES = {".m", ".pq", ".pqm"}
NOISE_SUFFIXES = (".resx", ".png", ".jpg", ".jpeg", ".svg", ".rels", ".xml", ".psdsxs", ".psdor")
RESOURCE_KEYS = ("ButtonTitle", "ButtonHelp", "DataSourceLabel")


@dataclass
class Extracted:
    """What extraction learned about a connector."""

    resources: dict[str, str] = field(default_factory=dict)
    source_files: list[str] = field(default_factory=list)
    redactions: int = 0


def safe_extract(archive: Path, destination: Path) -> None:
    """Extract a zip archive, refusing entries that would escape ``destination``."""
    root = destination.resolve()
    with zipfile.ZipFile(archive) as zf:
        for member in zf.infolist():
            target = (root / member.filename).resolve()
            if not target.is_relative_to(root):
                raise ValueError(f"Unsafe path {member.filename!r} in {archive.name}")
        zf.extractall(root)


def read_resources(resx: Path) -> dict[str, str]:
    """Read display strings such as ButtonTitle from a .resx file."""
    if not resx.is_file():
        return {}
    values = {}
    for data in ElementTree.parse(resx).getroot().iter("data"):
        name = data.get("name")
        value = data.findtext("value")
        if name in RESOURCE_KEYS and value and value.strip():
            values[name] = " ".join(value.split())
    return values


def remove_noise(root: Path) -> None:
    """Delete images, localization and packaging files, then empty folders."""
    for path in list(root.rglob("*")):
        if path.is_file() and path.name.lower().endswith(NOISE_SUFFIXES):
            path.unlink()
    for folder in sorted((p for p in root.rglob("*") if p.is_dir()), key=lambda p: -len(p.parts)):
        if not any(folder.iterdir()):
            folder.rmdir()


def m_sources(root: Path) -> list[str]:
    return sorted(
        p.relative_to(root).as_posix()
        for p in root.rglob("*")
        if p.is_file() and p.suffix.lower() in M_SUFFIXES
    )


def extract_package(archive: Path, destination: Path) -> Extracted:
    """Unpack, read display strings, strip noise and redact secrets."""
    safe_extract(archive, destination)
    resources = read_resources(destination / "resources.resx")
    remove_noise(destination)
    sources = m_sources(destination)
    if not sources:
        raise ValueError(f"No M source found in {archive.name}")
    return Extracted(resources=resources, source_files=sources, redactions=redact_tree(destination))
