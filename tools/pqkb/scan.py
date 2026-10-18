"""Find pattern usages and authentication kinds in connector source code."""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

AUTH_KINDS = ("Aad", "Anonymous", "Implicit", "Key", "OAuth", "UsernamePassword", "Windows")
AUTH_START = re.compile(r"\bAuthentication\s*=\s*\[")
FIELD = re.compile(r"\b([A-Za-z_]\w*)\s*=(?!=|>)")
OPEN, CLOSE = "[({", "])}"


@dataclass(frozen=True)
class Rule:
    """A pattern and the regexes that detect it."""

    pattern_id: str
    regexes: tuple[re.Pattern[str], ...]

    @classmethod
    def build(cls, pattern_id: str, expressions: list[str]) -> Rule:
        return cls(pattern_id, tuple(re.compile(e) for e in expressions))


@dataclass(frozen=True)
class Hit:
    connector: str
    file: str
    line: int


def read_source(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig", errors="replace")


def first_hits(rule: Rule, connector: str, file: str, text: str) -> list[Hit]:
    """Return the first matching line of ``text`` for ``rule`` (one hit per file)."""
    for number, line in enumerate(text.splitlines(), start=1):
        if any(regex.search(line) for regex in rule.regexes):
            return [Hit(connector, file, number)]
    return []


def scan(sources: dict[str, dict[str, str]], rules: list[Rule]) -> dict[str, list[Hit]]:
    """Map each pattern id to its hits. ``sources`` is connector -> file -> text."""
    hits: dict[str, list[Hit]] = {rule.pattern_id: [] for rule in rules}
    for connector, files in sources.items():
        for file, text in files.items():
            for rule in rules:
                hits[rule.pattern_id].extend(first_hits(rule, connector, file, text))
    return hits


def _strip_strings_and_comments(text: str) -> str:
    """Blank out string literals and comments so brackets inside them are ignored."""
    pattern = re.compile(r'"(?:[^"]|"")*"|//[^\n]*|/\*.*?\*/', re.DOTALL)
    return pattern.sub(lambda m: " " * len(m.group()), text)


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
