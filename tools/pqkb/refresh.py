"""Download the certified connectors and replace ``connectors/`` with a fresh copy."""

from __future__ import annotations

import json
import shutil
import tempfile
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from dataclasses import asdict, dataclass, field
from pathlib import Path

from pqkb.manifest import Package, fetch_manifest, latest_packages
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
        if backup.exists():
            backup.rename(target)
        raise


def refresh(repo: Path, manifest: dict | None = None) -> Changes:
    """Rebuild ``connectors/`` from the latest certified packages and report what changed."""
    target = repo / "connectors"
    packages = latest_packages(manifest or fetch_manifest())
    old_index = load_index(target)
    with tempfile.TemporaryDirectory(prefix=".refresh-", dir=repo) as stage_name:
        stage = Path(stage_name)
        downloads = stage / "downloads"
        prepared = stage / "connectors"
        downloads.mkdir()
        prepared.mkdir()
        archives = download_all(packages, downloads)
        records = [_record(p, prepared / p.name, archives[p.name]) for p in packages]
        write_index(prepared, records)
        _swap(prepared, target, stage / "previous")
    return diff(old_index, {r.name: r for r in records})
