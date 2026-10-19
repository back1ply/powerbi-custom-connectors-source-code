"""Bind source reviews to authored pattern content and complete cited files.

Fingerprints detect drift; they do not perform a prose review or authenticate a
reviewer's identity. Only an actual source review may renew this record.
"""

from __future__ import annotations

import hashlib
import json
import re
from datetime import UTC, datetime
from pathlib import Path

from pqkb import frontmatter
from pqkb.provenance import source_path

REVIEW_METADATA = {"generated", "verified", "review", "review_pending", "status"}
MATCH_LIST = re.compile(
    r"(?:\n# (?:Seen in|Source evidence)\s*)?<!-- seen-in:start -->.*?<!-- seen-in:end -->",
    re.DOTALL,
)


def pattern_paths(repo: Path) -> list[Path]:
    return sorted(
        path
        for path in (repo / "knowledge" / "patterns").glob("*.md")
        if path.name not in ("index.md", "log.md")
    )


def digest(content: bytes) -> str:
    return hashlib.sha256(content.replace(b"\r\n", b"\n")).hexdigest()


def authored_digest(document: frontmatter.Document) -> str:
    metadata = {key: val for key, val in document.meta.items() if key not in REVIEW_METADATA}
    header = json.dumps(metadata, sort_keys=True, ensure_ascii=False)
    body = MATCH_LIST.sub("", document.body).strip()
    return digest(f"{header}\n{body}".encode())


def fingerprint(repo: Path, document: frontmatter.Document) -> dict:
    return {
        "content_sha256": authored_digest(document),
        "sources_sha256": {
            source["id"]: digest(source_path(repo, source["resource"]).read_bytes())
            for source in document.meta["sources"]
        },
    }


def review_reason(repo: Path, document: frontmatter.Document) -> str:
    baseline = document.meta.get("review")
    if not baseline:
        return "No source review recorded"
    try:
        current = fingerprint(repo, document)
    except (OSError, ValueError) as error:
        return f"Cited source unavailable: {error}"
    if baseline.get("content_sha256") != current["content_sha256"]:
        return "Authored content or detection rules changed"
    if baseline.get("sources_sha256") != current["sources_sha256"]:
        return "Cited source content changed"
    if document.meta.get("status") != "stable":
        return "Pattern is not stable"
    if not document.meta.get("verified"):
        return "Review has no verification event"
    return ""


def record_review(repo: Path, path: Path, reviewer: str, now: datetime) -> None:
    """Record a completed source review; never call this as a replacement for reviewing."""
    document = frontmatter.read(path)
    document.meta["status"] = "stable"
    document.meta.pop("review_pending", None)
    document.meta["verified"] = {
        "by": reviewer,
        "at": now.astimezone(UTC).strftime("%Y-%m-%dT%H:%M:%SZ"),
    }
    document.meta["review"] = fingerprint(repo, document)
    path.write_text(
        frontmatter.render(document.meta, document.body), encoding="utf-8", newline="\n"
    )


def invalidate_review(repo: Path, path: Path) -> None:
    document = frontmatter.read(path)
    if not document.meta.get("review"):
        return
    reason = review_reason(repo, document)
    if not reason:
        return
    if document.meta.get("status") == "draft" and "verified" not in document.meta:
        return
    document.meta["status"] = "draft"
    document.meta["review_pending"] = reason
    document.meta.pop("verified", None)
    path.write_text(
        frontmatter.render(document.meta, document.body), encoding="utf-8", newline="\n"
    )


def check_reviews(repo: Path) -> list[str]:
    paths = pattern_paths(repo)
    if not paths:
        return ["No pattern pages found"]
    problems = []
    for path in paths:
        reason = review_reason(repo, frontmatter.read(path))
        if reason:
            problems.append(f"{path.stem}: {reason}")
    return problems
