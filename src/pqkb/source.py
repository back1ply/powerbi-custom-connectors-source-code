"""Read connector source, mask comments and strings, and find authentication kinds."""

from __future__ import annotations

import re
from pathlib import Path

AUTH_KINDS = ("Aad", "Anonymous", "Implicit", "Key", "OAuth", "UsernamePassword", "Windows")
AUTH_START = re.compile(r"\bAuthentication\s*=\s*\[")
FIELD = re.compile(r"\b([A-Za-z_]\w*)\s*=(?!=|>)")
OPEN, CLOSE = "[({", "])}"


def read_source(path: Path) -> str:
    return path.read_text(encoding="utf-8-sig", errors="replace")


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
