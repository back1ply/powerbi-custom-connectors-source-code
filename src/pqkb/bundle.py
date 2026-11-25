"""Generate the OKF knowledge bundle from the connector archive and pattern rules."""

from __future__ import annotations

import json
import re
import shutil
from collections import defaultdict
from dataclasses import dataclass, replace
from datetime import UTC, datetime, timedelta
from pathlib import Path
from urllib.parse import quote

from pqkb import frontmatter
from pqkb.provenance import source_url
from pqkb.refresh import Changes, ConnectorRecord, load_index
from pqkb.reviews import authored_digest, digest, review_reason
from pqkb.scan import Rule, auth_kinds, read_source

PRODUCER = "process:pqkb-build"
BUNDLE_DIR = "bundle"  # Generated OKF bundle, committed so agents can browse it.
STALE_AFTER = timedelta(days=14)
VOLATILE = ("generated", "stale_after", "verified")
CATEGORY_ORDER = (
    "Authentication",
    "Data retrieval",
    "Query folding",
    "Schema and errors",
    "Navigation and UI",
    "Packaging",
)


@dataclass
class Pattern:
    pattern_id: str
    path: Path
    doc: frontmatter.Document

    @property
    def title(self) -> str:
        return self.doc.meta.get("title", self.pattern_id)


def iso(moment: datetime) -> str:
    return moment.astimezone(UTC).strftime("%Y-%m-%dT%H:%M:%SZ")


def link_text(text: str) -> str:
    return text.replace("[", "(").replace("]", ")").replace("\n", " ")


def load_patterns(folder: Path) -> list[Pattern]:
    paths = sorted(p for p in folder.glob("*.md") if p.name not in ("index.md", "log.md"))
    return [Pattern(p.stem, p, frontmatter.read(p)) for p in paths]


def pattern_scope(pattern: Pattern) -> dict:
    return {
        "title": pattern.title,
        "description": pattern.doc.meta["description"],
        "scope": re.split(r"(?m)^#{1,2} Examples\b", pattern.doc.body, maxsplit=1)[0],
    }


def rules_for(patterns: list[Pattern]) -> list[Rule]:
    return [
        replace(
            Rule.build(p.pattern_id, p.doc.meta["detect"]),
            scope_sha256=authored_digest(p.doc),
            scope=pattern_scope(p),
        )
        for p in patterns
        if p.doc.meta.get("detect")
    ]


def read_sources(
    connectors_dir: Path, records: dict[str, ConnectorRecord]
) -> dict[str, dict[str, str]]:
    return {
        name: {f: read_source(connectors_dir / name / f) for f in record.files}
        for name, record in records.items()
    }


def write_if_changed(path: Path, meta: dict, body: str, now: datetime) -> bool:
    """Write a generated concept, keeping its old timestamps when nothing else changed."""
    if path.is_file():
        old = frontmatter.read(path)
        same_meta = {k: v for k, v in old.meta.items() if k not in VOLATILE} == meta
        if same_meta and old.body.strip() == body.strip():
            return False
    full: dict = {**meta, "generated": {"by": PRODUCER, "at": iso(now)}}
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(frontmatter.render(full, body), encoding="utf-8", newline="\n")
    return True


def connector_meta(record: ConnectorRecord, auth: set[str]) -> dict:
    description = record.description or f"Power BI connector source for {record.title}."
    meta = {
        "type": "Power Query Connector",
        "title": record.title,
        "description": " ".join(description.split()),
        "tags": sorted({a.lower() for a in auth}),
        # Not OKF fields: extension keys use the x- prefix (OKF 0.3 section 4.1).
        "x-pqkb-publisher": record.publisher,
        "x-pqkb-version": record.version,
        "sources": [
            {"id": f"file-{i}", "resource": source_url(record.name, f), "title": f}
            for i, f in enumerate(record.files, start=1)
        ],
    }
    if record.package_url:
        meta["resource"] = record.package_url
    return meta


def connector_body(record: ConnectorRecord, auth: set[str]) -> str:
    auth_text = ", ".join(sorted(auth)) or "Not declared"
    lines = [
        "| Publisher | Version | Authentication |",
        "| --- | --- | --- |",
        f"| {record.publisher or 'Unknown'} | {record.version} | {auth_text} |",
        "",
        "# Source files",
        "",
        *[f"* [{f}]({source_url(record.name, f)})" for f in record.files],
    ]
    return "\n".join(lines)


def index_entry(title: str, href: str, description: str) -> str:
    return f"* [{link_text(title)}]({href}) - {' '.join(description.split())}".rstrip(" -")


def write_text_if_changed(path: Path, text: str) -> bool:
    if path.is_file() and path.read_text(encoding="utf-8") == text:
        return False
    path.write_text(text, encoding="utf-8", newline="\n")
    return True


def connectors_index(records: dict[str, ConnectorRecord]) -> str:
    lines = ["# Connectors", ""]
    for name in sorted(records, key=lambda n: records[n].title.lower()):
        r = records[name]
        lines.append(
            index_entry(r.title, f"{quote(name)}.md", f"{r.publisher}. {r.description}".strip())
        )
    return "\n".join(lines) + "\n"


def patterns_by_category(patterns: list[Pattern]) -> dict[str, list[Pattern]]:
    groups: dict[str, list[Pattern]] = defaultdict(list)
    for p in patterns:
        groups[p.doc.meta.get("category", "Other")].append(p)
    order = {c: i for i, c in enumerate(CATEGORY_ORDER)}
    return dict(sorted(groups.items(), key=lambda kv: (order.get(kv[0], len(order)), kv[0])))


def patterns_index(patterns: list[Pattern]) -> str:
    lines: list[str] = []
    for category, items in patterns_by_category(patterns).items():
        lines += [f"# {category}", ""]
        for p in sorted(items, key=lambda p: p.title.lower()):
            lines.append(
                index_entry(p.title, f"{p.pattern_id}.md", p.doc.meta.get("description", ""))
            )
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def tag_groups(pages: Path) -> dict[str, list[tuple[Path, frontmatter.Document]]]:
    groups: dict[str, list[tuple[Path, frontmatter.Document]]] = defaultdict(list)
    for page in sorted(pages.glob("*.md")):
        if page.name == "index.md":
            continue
        document = frontmatter.read(page)
        for tag in document.meta["tags"]:
            groups[tag].append((page, document))
    return groups


def tags_index(pages: Path) -> str:
    lines: list[str] = []
    for tag, documents in sorted(tag_groups(pages).items()):
        lines += [f"# {tag}", ""]
        for page, document in documents:
            lines.append(
                index_entry(
                    document.meta["title"],
                    f"../connectors/{quote(page.name)}",
                    "",
                )
            )
        lines.append("")
    return "\n".join(lines)


def root_index(patterns: list[Pattern], connector_count: int) -> str:
    return (
        '---\nokf_version: "0.3"\n'
        "title: Power Query Connector Source Reference\n"
        "description: >-\n"
        "  Source of Microsoft's certified Power BI and Excel Power Query connectors, with\n"
        "  pattern guides that cite it. Use it to see how real connectors implement\n"
        "  authentication, paging, navigation, query folding, and error handling.\n"
        "  Original text and tools are MIT; extracted connector source keeps its owners'\n"
        "  rights.\n"
        "---\n\n"
        + "# Power Query Connector Source Reference\n\n"
        + "Browse extracted connector implementations and source-reviewed patterns.\n\n"
        + "Examples describe archived source and have not been runtime-tested. "
        + "Uncertain and unreviewed matches are labelled.\n\n"
        + "[Download the OKF bundle](https://back1ply.github.io/"
        + "powerbi-custom-connectors-source-code/knowledge.zip).\n\n"
        + index_entry(
            "Patterns",
            "patterns/index.md",
            f"{len(patterns)} implementation patterns, grouped by topic.",
        )
        + "\n"
        + index_entry(
            "Connectors",
            "connectors/index.md",
            f"All {connector_count} connectors in the archive, and their source files.",
        )
        + "\n"
        + index_entry(
            "Connector tags", "tags/index.md", "Browse connectors by authentication kind."
        )
        + "\n"
        + index_entry(
            "Refresh log",
            "log.md",
            "Successful refreshes, verification checks, and package changes.",
        )
        + "\n"
    )


def log_entry(changes: Changes, records: dict[str, ConnectorRecord]) -> list[str]:
    def title(name: str) -> str:
        return records[name].title if name in records else name

    bullets = [
        f"* **Creation**: Added [{link_text(title(n))}](connectors/{quote(n)}.md)."
        for n in changes.added
    ]
    bullets += [
        f"* **Update**: [{link_text(title(n))}](connectors/{quote(n)}.md) {old} → {new}."
        for n, old, new in changes.updated
    ]
    bullets += [
        f"* **Deletion**: Removed {n} (absent from the selected package set)."
        for n in changes.removed
    ]
    return bullets


def append_log(
    path: Path, changes: Changes, records: dict[str, ConnectorRecord], now: datetime
) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    bullets = log_entry(changes, records)
    if not bullets:
        bullets = ["* **Verification**: Checked the connector archive; no package version changes."]
    heading = f"## {now.astimezone(UTC):%Y-%m-%d}"
    text = path.read_text(encoding="utf-8") if path.is_file() else "# Refresh log\n"
    head, _, rest = text.partition("\n")
    rest = rest.lstrip("\n")
    if rest.startswith(heading):
        rest = rest[len(heading) :].lstrip("\n")
    new = f"{head}\n\n{heading}\n\n" + "\n".join(bullets) + ("\n\n" + rest if rest else "\n")
    path.write_text(new.rstrip("\n") + "\n", encoding="utf-8", newline="\n")


def remove_stale_pages(folder: Path, names: set[str]) -> None:
    for page in folder.glob("*.md"):
        if page.name != "index.md" and page.stem not in names:
            page.unlink()


def write_connector_pages(repo: Path, now: datetime) -> None:
    records = load_index(repo / "connectors")
    sources = read_sources(repo / "connectors", records)
    pages = repo / BUNDLE_DIR / "connectors"
    for name, record in records.items():
        auth = set().union(*(auth_kinds(text) for text in sources[name].values()))
        write_if_changed(
            pages / f"{name}.md",
            connector_meta(record, auth),
            connector_body(record, auth),
            now,
        )
    remove_stale_pages(pages, set(records))


def archive_records(connectors_dir: Path) -> dict[str, ConnectorRecord]:
    records = load_index(connectors_dir)
    if not records or not any(record.files for record in records.values()):
        raise ValueError("connectors/index.json is missing. Run `pqkb refresh` first.")
    return records


def write_receipt(repo: Path, now: datetime) -> None:
    """Record a successful refresh of ``connectors/``; ``build`` applies it to the bundle."""
    receipt = {"verified_at": iso(now), "archive_sha256": archive_digest(repo)}
    (repo / "knowledge" / "refresh.json").write_text(json.dumps(receipt) + "\n", encoding="utf-8")


def confirm_archive(repo: Path, now: datetime) -> None:
    """Record a successful refresh without changing the content-generation timestamp."""
    write_receipt(repo, now)
    apply_confirmation(repo)


def apply_confirmation(repo: Path) -> None:
    confirmation = confirmation_metadata(repo)
    for name in load_index(repo / "connectors"):
        path = repo / BUNDLE_DIR / "connectors" / f"{name}.md"
        document = frontmatter.read(path)
        document.meta.pop("verified", None)
        document.meta.pop("stale_after", None)
        document.meta.update(confirmation)
        write_text_if_changed(path, frontmatter.render(document.meta, document.body))


def confirmation_metadata(repo: Path) -> dict:
    receipt = repo / "knowledge" / "refresh.json"
    if not receipt.is_file():
        return {}
    record = json.loads(receipt.read_text(encoding="utf-8"))
    if record["archive_sha256"] != archive_digest(repo):
        return {}
    now = datetime.fromisoformat(record["verified_at"])
    return {
        "verified": {"by": "process:pqkb-refresh", "at": iso(now)},
        "stale_after": iso(now + STALE_AFTER),
    }


def archive_digest(repo: Path) -> str:
    root = repo / "connectors"
    fingerprints = {"index.json": digest((root / "index.json").read_bytes())}
    for name, record in load_index(root).items():
        for file in record.files:
            fingerprints[f"{name}/{file}"] = digest((root / name / file).read_bytes())
    return digest(json.dumps(fingerprints, sort_keys=True).encode())


def build(repo: Path, now: datetime | None = None) -> None:
    """Render authored knowledge and archive metadata into ``bundle/``."""
    now = now or datetime.now(UTC)
    knowledge, connectors_dir = repo / BUNDLE_DIR, repo / "connectors"
    records = archive_records(connectors_dir)
    patterns = render_patterns(repo, knowledge)
    write_connector_pages(repo, now)
    apply_confirmation(repo)

    write_text_if_changed(knowledge / "connectors" / "index.md", connectors_index(records))
    write_text_if_changed(knowledge / "patterns" / "index.md", patterns_index(patterns))
    write_text_if_changed(knowledge / "index.md", root_index(patterns, len(records)))
    (knowledge / "tags").mkdir(exist_ok=True)
    write_text_if_changed(knowledge / "tags" / "index.md", tags_index(knowledge / "connectors"))
    log = repo / "knowledge" / "log.md"
    if not log.exists():
        heading = f"## {now.astimezone(UTC):%Y-%m-%d}"
        write_text_if_changed(
            log,
            f"# Refresh log\n\n{heading}\n\n"
            "* **Initialization**: Created the knowledge bundle from the connector archive.\n",
        )
    shutil.copyfile(log, knowledge / "log.md")


DRIFT_BANNER = (
    "**Changed since review:** this page or the source it cites has changed since it "
    "was last reviewed. Quoted lines and line numbers may be out of date."
)


def receipt_time(repo: Path) -> str | None:
    """Time of the last successful refresh, or None when no receipt exists."""
    receipt = repo / "knowledge" / "refresh.json"
    if not receipt.is_file():
        return None
    return iso(datetime.fromisoformat(json.loads(receipt.read_text("utf-8"))["verified_at"]))


def mark_drift(text: str, stale_after: str | None) -> str:
    """Flag a drifted page in its built copy without re-serializing its frontmatter.

    OKF marks content to check again with ``stale_after`` (spec section 5.5). The
    refresh receipt time keeps rebuilds byte-identical; without a receipt no date
    is invented and only the banner is added.
    """
    header_end = text.index("\n---", 3)
    header, body = text[:header_end], text[header_end + 4 :].lstrip("\n")
    if stale_after:
        header += f'\nstale_after: "{stale_after}"'
    # Keep the page's H1 first so the title still renders as the heading.
    if body.startswith("# "):
        title, _, rest = body.partition("\n")
        body = f"{title}\n\n{DRIFT_BANNER}\n\n{rest.lstrip()}"
    else:
        body = f"{DRIFT_BANNER}\n\n{body}"
    return f"{header}\n---\n\n{body}"


def render_patterns(repo: Path, destination: Path) -> list[Pattern]:
    """Copy authored patterns into the bundle; authored files are never modified."""
    folder = destination / "patterns"
    folder.mkdir(parents=True, exist_ok=True)
    sources = load_patterns(repo / "knowledge" / "patterns")
    remove_stale_pages(folder, {pattern.pattern_id for pattern in sources})
    stale_after = receipt_time(repo)
    for pattern in sources:
        content = pattern.path.read_bytes()  # Byte copy keeps the author's line endings.
        if pattern.doc.meta.get("review") and review_reason(repo, pattern.doc):
            crlf = b"\r\n" in content
            text = mark_drift(content.decode("utf-8").replace("\r\n", "\n"), stale_after)
            content = (text.replace("\n", "\r\n") if crlf else text).encode("utf-8")
        target = folder / pattern.path.name
        if not target.is_file() or target.read_bytes() != content:
            target.write_bytes(content)
    return load_patterns(folder)
