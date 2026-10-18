"""Generate the OKF knowledge bundle from the connector archive and pattern rules."""

from __future__ import annotations

from collections import defaultdict
from dataclasses import dataclass
from datetime import UTC, datetime, timedelta
from pathlib import Path
from urllib.parse import quote

from pqkb import frontmatter
from pqkb.refresh import Changes, ConnectorRecord, load_index
from pqkb.scan import Hit, Rule, auth_kinds, read_source, scan

REPO_BLOB = "https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master"
PRODUCER = "process:pqkb-build"
STALE_AFTER = timedelta(days=14)
SEEN_START, SEEN_END = "<!-- seen-in:start -->", "<!-- seen-in:end -->"
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


def source_url(connector: str, file: str, line: int | None = None) -> str:
    url = f"{REPO_BLOB}/connectors/{quote(connector)}/{quote(file)}"
    return f"{url}#L{line}" if line else url


def load_patterns(folder: Path) -> list[Pattern]:
    paths = sorted(p for p in folder.glob("*.md") if p.name not in ("index.md", "log.md"))
    return [Pattern(p.stem, p, frontmatter.read(p)) for p in paths]


def rules_for(patterns: list[Pattern]) -> list[Rule]:
    return [
        Rule.build(p.pattern_id, p.doc.meta["detect"]) for p in patterns if p.doc.meta.get("detect")
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
    if meta.get("type") == "Power Query Connector":
        full["stale_after"] = iso(now + STALE_AFTER)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(frontmatter.render(full, body), encoding="utf-8", newline="\n")
    return True


def connector_meta(record: ConnectorRecord, auth: set[str], pattern_ids: set[str]) -> dict:
    description = record.description or f"Power BI connector source for {record.title}."
    meta = {
        "type": "Power Query Connector",
        "title": record.title,
        "description": " ".join(description.split()),
        "tags": sorted({a.lower() for a in auth} | pattern_ids),
        "publisher": record.publisher,
        "version": record.version,
        "sources": [
            {"id": f"file-{i}", "resource": source_url(record.name, f), "title": f}
            for i, f in enumerate(record.files, start=1)
        ],
    }
    if record.package_url:
        meta["resource"] = record.package_url
    return meta


def connector_body(
    record: ConnectorRecord,
    auth: set[str],
    used: dict[str, list[Hit]],
    patterns: dict[str, Pattern],
) -> str:
    auth_text = ", ".join(sorted(auth)) or "Not declared"
    lines = [
        "| Publisher | Version | Authentication |",
        "| --- | --- | --- |",
        f"| {record.publisher or 'Unknown'} | {record.version} | {auth_text} |",
        "",
        "# Source files",
        "",
        *[f"* [{f}]({source_url(record.name, f)})" for f in record.files],
        "",
        "# Detected patterns",
        "",
    ]
    if not used:
        lines.append("None of the documented patterns were detected.")
    for pattern_id in sorted(used, key=lambda pid: patterns[pid].title.lower()):
        refs = ", ".join(
            f"[{h.file} line {h.line}]({source_url(h.connector, h.file, h.line)})"
            for h in used[pattern_id]
        )
        lines.append(
            f"* [{link_text(patterns[pattern_id].title)}](../patterns/{pattern_id}.md): {refs}"
        )
    return "\n".join(lines)


def seen_in_section(hits: list[Hit], records: dict[str, ConnectorRecord]) -> str:
    by_connector: dict[str, list[Hit]] = defaultdict(list)
    for hit in hits:
        by_connector[hit.connector].append(hit)
    count = len(by_connector)
    noun = "connector" if count == 1 else "connectors"
    lines = [SEEN_START, "", f"Detected in **{count}** {noun} in this archive.", ""]
    for name in sorted(by_connector, key=str.lower):
        refs = ", ".join(
            f"[{h.file} line {h.line}]({source_url(name, h.file, h.line)})"
            for h in by_connector[name]
        )
        lines.append(
            f"* [{link_text(records[name].title)}](../connectors/{quote(name)}.md): {refs}"
        )
    lines += ["", SEEN_END]
    return "\n".join(lines)


def update_pattern(pattern: Pattern, section: str) -> bool:
    body = pattern.doc.body
    if SEEN_START in body and SEEN_END in body:
        start, end = body.index(SEEN_START), body.index(SEEN_END) + len(SEEN_END)
        new_body = body[:start] + section + body[end:]
    else:
        new_body = body.rstrip() + "\n\n# Seen in\n\n" + section + "\n"
    if new_body == body:
        return False
    pattern.path.write_text(
        frontmatter.render(pattern.doc.meta, new_body), encoding="utf-8", newline="\n"
    )
    pattern.doc.body = new_body
    return True


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


def patterns_index(patterns: list[Pattern], prefix: str = "") -> str:
    lines: list[str] = []
    for category, items in patterns_by_category(patterns).items():
        lines += [f"# {category}", ""]
        for p in sorted(items, key=lambda p: p.title.lower()):
            lines.append(
                index_entry(
                    p.title, f"{prefix}{p.pattern_id}.md", p.doc.meta.get("description", "")
                )
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
                    document.meta["description"],
                )
            )
        lines.append("")
    return "\n".join(lines)


def root_index(patterns: list[Pattern], connector_count: int) -> str:
    return (
        '---\nokf_version: "0.2"\n---\n\n'
        + patterns_index(patterns, prefix="patterns/")
        + "\n# Archive\n\n"
        + index_entry(
            "Connectors",
            "connectors/index.md",
            f"All {connector_count} connectors in the archive, their files and detected patterns.",
        )
        + "\n"
        + index_entry(
            "Connector tags", "tags/index.md", "Browse authentication kinds and detected patterns."
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


def remove_stale_connector_pages(folder: Path, names: set[str]) -> None:
    for page in folder.glob("*.md"):
        if page.name != "index.md" and page.stem not in names:
            page.unlink()


def hits_by_connector(hits: dict[str, list[Hit]]) -> dict[str, dict[str, list[Hit]]]:
    used: dict[str, dict[str, list[Hit]]] = defaultdict(lambda: defaultdict(list))
    for pattern_id, pattern_hits in hits.items():
        for hit in pattern_hits:
            used[hit.connector][pattern_id].append(hit)
    return used


def write_connector_pages(
    repo: Path, patterns: list[Pattern], hits: dict[str, list[Hit]], now: datetime
) -> None:
    records = load_index(repo / "connectors")
    sources = read_sources(repo / "connectors", records)
    by_id = {p.pattern_id: p for p in patterns}
    used = hits_by_connector(hits)
    pages = repo / "knowledge" / "connectors"
    for name, record in records.items():
        auth = set().union(*(auth_kinds(text) for text in sources[name].values()))
        write_if_changed(
            pages / f"{name}.md",
            connector_meta(record, auth, set(used[name])),
            connector_body(record, auth, used[name], by_id),
            now,
        )
    remove_stale_connector_pages(pages, set(records))


def archive_records(connectors_dir: Path) -> dict[str, ConnectorRecord]:
    records = load_index(connectors_dir)
    if not records or not any(record.files for record in records.values()):
        raise ValueError("connectors/index.json is missing. Run `pqkb refresh` first.")
    return records


def confirm_archive(repo: Path, now: datetime) -> None:
    """Record a successful refresh without changing the content-generation timestamp."""
    for name in load_index(repo / "connectors"):
        path = repo / "knowledge" / "connectors" / f"{name}.md"
        document = frontmatter.read(path)
        document.meta["verified"] = {"by": "process:pqkb-refresh", "at": iso(now)}
        document.meta["stale_after"] = iso(now + STALE_AFTER)
        path.write_text(
            frontmatter.render(document.meta, document.body), encoding="utf-8", newline="\n"
        )


def build(repo: Path, now: datetime | None = None) -> None:
    """Regenerate every generated part of ``knowledge/`` from ``connectors/``."""
    now = now or datetime.now(UTC)
    knowledge, connectors_dir = repo / "knowledge", repo / "connectors"
    records = archive_records(connectors_dir)
    patterns = load_patterns(knowledge / "patterns")
    by_id = {p.pattern_id: p for p in patterns}
    sources = read_sources(connectors_dir, records)
    hits = scan(sources, rules_for(patterns))

    write_connector_pages(repo, patterns, hits, now)
    for pattern_id, pattern_hits in hits.items():
        update_pattern(by_id[pattern_id], seen_in_section(pattern_hits, records))

    write_text_if_changed(knowledge / "connectors" / "index.md", connectors_index(records))
    write_text_if_changed(knowledge / "patterns" / "index.md", patterns_index(patterns))
    write_text_if_changed(knowledge / "index.md", root_index(patterns, len(records)))
    (knowledge / "tags").mkdir(exist_ok=True)
    write_text_if_changed(knowledge / "tags" / "index.md", tags_index(knowledge / "connectors"))
    log = knowledge / "log.md"
    if not log.exists():
        heading = f"## {now.astimezone(UTC):%Y-%m-%d}"
        write_text_if_changed(
            log,
            f"# Refresh log\n\n{heading}\n\n"
            "* **Initialization**: Created the knowledge bundle from the connector archive.\n",
        )
