"""Download the certified connectors and replace ``connectors/`` with a fresh copy."""

from __future__ import annotations

import json
import shutil
import tempfile
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from dataclasses import asdict, dataclass, field
from pathlib import Path

from pqkb.manifest import PACKAGE_SUFFIXES, Package, fetch_manifest, latest_packages, unique_names
from pqkb.package import extract_package

INDEX_FILE = "index.json"


@dataclass
class ConnectorRecord:
    """Metadata stored for each connector in ``connectors/index.json``."""

    name: str
    title: str
    description: str
    publisher: str
    version: str
    package_url: str
    files: list[str]


@dataclass
class Changes:
    added: list[str] = field(default_factory=list)
    removed: list[str] = field(default_factory=list)
    updated: list[tuple[str, str, str]] = field(default_factory=list)  # name, old, new

    def is_empty(self) -> bool:
        return not (self.added or self.removed or self.updated)


def load_index(connectors_dir: Path) -> dict[str, ConnectorRecord]:
    path = connectors_dir / INDEX_FILE
    if not path.is_file():
        # Archives built before index.json existed: only the names are known.
        folders = [p.name for p in connectors_dir.iterdir()] if connectors_dir.is_dir() else []
        return {
            n: ConnectorRecord(n, n, "", "", "", "", [])
            for n in folders
            if (connectors_dir / n).is_dir()
        }
    data = json.loads(path.read_text(encoding="utf-8"))
    return {item["name"]: ConnectorRecord(**item) for item in data["connectors"]}


def write_index(connectors_dir: Path, records: list[ConnectorRecord]) -> None:
    payload = {"connectors": [asdict(r) for r in sorted(records, key=lambda r: r.name.lower())]}
    text = json.dumps(payload, indent=2, ensure_ascii=False) + "\n"
    (connectors_dir / INDEX_FILE).write_text(text, encoding="utf-8")


def diff(old: dict[str, ConnectorRecord], new: dict[str, ConnectorRecord]) -> Changes:
    changes = Changes(
        added=sorted(set(new) - set(old), key=str.lower),
        removed=sorted(set(old) - set(new), key=str.lower),
    )
    for name in sorted(set(old) & set(new), key=str.lower):
        if old[name].version and old[name].version != new[name].version:
            changes.updated.append((name, old[name].version, new[name].version))
    return changes


def _download(package: Package, folder: Path) -> Path:
    target = folder / package.file_name
    with urllib.request.urlopen(package.url, timeout=120) as response, target.open("wb") as out:
        shutil.copyfileobj(response, out)
    return target


def download_all(packages: list[Package], folder: Path) -> dict[str, Path]:
    with ThreadPoolExecutor(max_workers=8) as pool:
        paths = pool.map(lambda p: _download(p, folder), packages)
        return {p.name: path for p, path in zip(packages, paths, strict=True)}


def _record(package: Package, destination: Path, archive: Path) -> ConnectorRecord:
    extracted = extract_package(archive, destination)
    resources = extracted.resources
    return ConnectorRecord(
        name=package.name,
        title=resources.get("ButtonTitle") or resources.get("DataSourceLabel") or package.name,
        description=resources.get("ButtonHelp") or "",
        publisher=package.publisher,
        version=package.version,
        package_url=package.url,
        files=extracted.source_files,
    )


def _swap(prepared: Path, target: Path, backup: Path) -> None:
    """Install ``prepared`` as ``target``, restoring the old tree if the move fails."""
    if target.exists():
        target.rename(backup)
    try:
        prepared.rename(target)
    except OSError:
        try:
            if backup.exists():
                backup.rename(target)
        except OSError as recovery_error:
            raise OSError(
                f"Archive recovery failed; previous connectors retained at {backup}"
            ) from recovery_error
        raise


def local_source(repo: Path, source_dir: Path) -> Path:
    source = source_dir.resolve()
    if not source.is_dir():
        raise ValueError(f"Package folder not found: {source}")
    if source.is_relative_to((repo / "connectors").resolve()):
        raise ValueError("Source directory must be outside connectors/.")
    return source


def local_package_paths(source: Path) -> list[Path]:
    paths = sorted(
        p for p in source.rglob("*") if p.is_file() and p.suffix.lower() in PACKAGE_SUFFIXES
    )
    if not paths:
        raise ValueError(f"No .mez or .pqx packages found in {source}")
    return paths


def local_archives(repo: Path, source_dir: Path) -> list[tuple[Package, Path]]:
    paths = local_package_paths(local_source(repo, source_dir))
    archives = [(Package(p.name, "", "", ""), p) for p in paths]
    unique_names([package for package, _ in archives])
    return archives


def replace_archive(repo: Path, archives: list[tuple[Package, Path]]) -> Changes:
    target = repo / "connectors"
    old_index = load_index(target)
    stage = Path(tempfile.mkdtemp(prefix=".refresh-", dir=repo)).resolve()
    installed = False
    try:
        prepared = stage / "connectors"
        prepared.mkdir()
        records = [_record(package, prepared / package.name, path) for package, path in archives]
        write_index(prepared, records)
        _swap(prepared, target, stage / "previous")
        installed = True
    finally:
        if installed or not (stage / "previous").exists():
            stage.relative_to(repo.resolve())
            shutil.rmtree(stage)
    return diff(old_index, {r.name: r for r in records})


def refresh(repo: Path, manifest: dict | None = None, *, source_dir: Path | None = None) -> Changes:
    """Replace the archive from the feed or a complete local package set.

    Local packages have unknown publisher, version and package URL metadata.
    Both modes finish extraction and redaction before replacing the archive.
    """
    if source_dir is not None:
        return replace_archive(repo, local_archives(repo, source_dir))
    packages = latest_packages(manifest if manifest is not None else fetch_manifest())
    with tempfile.TemporaryDirectory(prefix=".refresh-", dir=repo) as stage_name:
        downloads = download_all(packages, Path(stage_name))
        return replace_archive(repo, [(package, downloads[package.name]) for package in packages])
