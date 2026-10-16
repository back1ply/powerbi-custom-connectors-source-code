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
VOLATILE = ("generated", "stale_after")
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


def connector_meta(record: ConnectorRecord, auth: set[str]) -> dict:
    description = (
        record.description or f"Certified Power BI connector published by {record.publisher}."
    )
    return {
        "type": "Power Query Connector",
        "title": record.title,
        "description": " ".join(description.split()),
        "resource": record.package_url,
        "tags": sorted(a.lower() for a in auth),
        "publisher": record.publisher,
        "version": record.version,
        "sources": [
            {"id": f"file-{i}", "resource": source_url(record.name, f), "title": f}
            for i, f in enumerate(record.files, start=1)
        ],
    }


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
        "# Patterns used",
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


def root_index(patterns: list[Pattern], connector_count: int) -> str:
    return (
        patterns_index(patterns, prefix="patterns/")
        + "\n# Archive\n\n"
        + index_entry(
            "Connectors",
            "connectors/index.md",
            f"All {connector_count} certified connectors, their files and detected patterns.",
        )
        + "\n"
        + index_entry(
            "Refresh log", "log.md", "Connectors added, updated and removed by each refresh."
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
        f"* **Deletion**: Removed {n} (no longer in Microsoft's certified list)."
        for n in changes.removed
    ]
    return bullets


def append_log(
    path: Path, changes: Changes, records: dict[str, ConnectorRecord], now: datetime
) -> None:
    bullets = log_entry(changes, records)
    if not bullets:
        return
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


def build(repo: Path, now: datetime | None = None) -> None:
    """Regenerate every generated part of ``knowledge/`` from ``connectors/``."""
    now = now or datetime.now(UTC)
    knowledge, connectors_dir = repo / "knowledge", repo / "connectors"
    records = load_index(connectors_dir)
    if not records or not any(r.files for r in records.values()):
        raise ValueError("connectors/index.json is missing. Run `pqkb refresh` first.")
    patterns = load_patterns(knowledge / "patterns")
    by_id = {p.pattern_id: p for p in patterns}
    sources = read_sources(connectors_dir, records)
    hits = scan(sources, rules_for(patterns))

    used: dict[str, dict[str, list[Hit]]] = defaultdict(lambda: defaultdict(list))
    for pattern_id, pattern_hits in hits.items():
        for hit in pattern_hits:
            used[hit.connector][pattern_id].append(hit)

    pages = knowledge / "connectors"
    for name, record in records.items():
        auth = set().union(*(auth_kinds(text) for text in sources[name].values()))
        write_if_changed(
            pages / f"{name}.md",
            connector_meta(record, auth),
            connector_body(record, auth, used[name], by_id),
            now,
        )
    remove_stale_connector_pages(pages, set(records))
    for pattern_id, pattern_hits in hits.items():
        update_pattern(by_id[pattern_id], seen_in_section(pattern_hits, records))

    write_text_if_changed(pages / "index.md", connectors_index(records))
    write_text_if_changed(knowledge / "patterns" / "index.md", patterns_index(patterns))
    write_text_if_changed(knowledge / "index.md", root_index(patterns, len(records)))
