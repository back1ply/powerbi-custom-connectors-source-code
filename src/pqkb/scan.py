"""Find pattern usages and authentication kinds in connector source code."""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

from pqkb.signals import SIGNALS, Signal

AUTH_KINDS = ("Aad", "Anonymous", "Implicit", "Key", "OAuth", "UsernamePassword", "Windows")
AUTH_START = re.compile(r"\bAuthentication\s*=\s*\[")
FIELD = re.compile(r"\b([A-Za-z_]\w*)\s*=(?!=|>)")
OPEN, CLOSE = "[({", "])}"


@dataclass(frozen=True)
class Rule:
    """A pattern and the regexes that detect it."""

    pattern_id: str
    regexes: tuple[re.Pattern[str], ...]
    labels: tuple[str, ...] = ()
    scope_sha256: str = ""
    scope: dict = field(default_factory=dict)

    @classmethod
    def build(cls, pattern_id: str, expressions: list[str]) -> Rule:
        signals = SIGNALS.get(
            pattern_id, tuple(Signal("pattern expression", e) for e in expressions)
        )
        return cls(
            pattern_id,
            tuple(re.compile(s.expression) for s in signals),
            tuple(s.label for s in signals),
        )


@dataclass(frozen=True)
class Evidence:
    file: str
    line: int
    label: str
    code: str


@dataclass(frozen=True)
class Hit:
    connector: str
    file: str
    line: int
    evidence: tuple[Evidence, ...] = ()
    confidence: str = "partial"
    verdict: str = "pending"
    reason: str = ""
    reviewer: str = ""
    certainty: str = ""
    review_evidence: tuple[Evidence, ...] = ()


def read_source(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig", errors="replace")


def file_evidence(rule: Rule, file: str, text: str, clean: str) -> list[Evidence]:
    lines = text.split("\n")
    evidence = []
    for label, regex in zip(rule.labels, rule.regexes, strict=True):
        match = regex.search(clean)
        if match:
            line = clean.count("\n", 0, match.start()) + 1
            evidence.append(Evidence(file, line, label, lines[line - 1].strip()))
    return evidence


def candidate_hit(connector: str, rule: Rule, files: dict, cleaned: dict) -> Hit | None:
    evidence = [
        e for file, text in files.items() for e in file_evidence(rule, file, text, cleaned[file])
    ]
    primary = next((e for e in evidence if e.label == rule.labels[0]), None)
    if primary is None:
        return None
    confidence = "corroborated" if set(rule.labels) <= {e.label for e in evidence} else "partial"
    return Hit(connector, primary.file, primary.line, tuple(evidence), confidence)


def scan(sources: dict[str, dict[str, str]], rules: list[Rule]) -> dict[str, list[Hit]]:
    """Collect candidates; corroboration is co-occurrence, not data-flow proof."""
    hits: dict[str, list[Hit]] = {rule.pattern_id: [] for rule in rules}
    for connector, files in sources.items():
        cleaned = {file: _strip_strings_and_comments(text) for file, text in files.items()}
        for rule in rules:
            hit = candidate_hit(connector, rule, files, cleaned)
            if hit is not None:
                hits[rule.pattern_id].append(hit)
    return hits


def _blank(text: str) -> str:
    return "".join("\n" if char == "\n" else " " for char in text)


def _block_end(text: str, start: int) -> int:
    # M comments do not nest: https://learn.microsoft.com/powerquery-m/m-spec-lexical-structure
    end = text.find("*/", start + 2)
    return len(text) if end == -1 else end + 2


def _strip_strings_and_comments(text: str) -> str:
    """Preserve offsets/newlines and quoted M identifiers; mask literals/comments."""
    tokens = re.compile(r'#?"(?:[^"]|"")*"|//[^\r\n\u0085\u2028\u2029]*|/\*', re.DOTALL)
    result = list(text)
    offset = 0
    while match := tokens.search(text, offset):
        token = match.group()
        end = _block_end(text, match.start()) if token == "/*" else match.end()
        replacement = _blank(text[match.start() : end])
        if token.startswith('#"'):
            replacement = "  " + token[2:-1] + " "
        result[match.start() : end] = replacement
        offset = end
    return "".join(result)


def _record_fields(text: str, start: int) -> set[str]:
    """Field names at the top level of the record that opens at ``text[start]``."""
    depth, names, segment_start = 0, set(), start + 1
    for index in range(start, len(text)):
        char = text[index]
        if char in OPEN and depth == 1:
            names.update(_names_at_top(text[segment_start:index]))
        if char in OPEN:
            depth += 1
            continue
        if char not in CLOSE:
            continue
        depth -= 1
        if depth == 1:
            segment_start = index + 1
        if depth == 0:
            names.update(_names_at_top(text[segment_start:index]))
            return names
    return names


def _names_at_top(segment: str) -> set[str]:
    return {match.group(1) for match in FIELD.finditer(segment)}


def auth_kinds(text: str) -> set[str]:
    """Authentication kinds declared in ``Authentication = [ ... ]`` records."""
    clean = _strip_strings_and_comments(text)
    found: set[str] = set()
    for match in AUTH_START.finditer(clean):
        found |= _record_fields(clean, match.end() - 1) & set(AUTH_KINDS)
    return found
