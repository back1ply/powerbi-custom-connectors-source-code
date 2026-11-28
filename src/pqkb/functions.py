"""Index the top-level functions of each connector: name, file, line range, and calls.

Section documents (`.pq`, `.m`) are split into members at `;` outside brackets,
after masking comments and string literals. A `.pqm` module holds one expression
and is indexed as a single member named after the file. Calls are references to
other members of the same connector, plus `.pqm` files named in a member's body.
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field, replace

from pqkb.source import _strip_strings_and_comments

IDENTIFIER = re.compile(r'#"(?:[^"]|"")*"|[A-Za-z_][\w.]*')
SECTION = re.compile(r"\bsection\s+[^;]+;")
OPEN, CLOSE = "([{", ")]}"


@dataclass(frozen=True)
class Function:
    connector: str
    file: str
    name: str
    start: int  # 1-based, inclusive
    end: int
    shared: bool = False
    calls: tuple[str, ...] = field(default=())


QUOTED = re.compile(r'#"(?:[^"]|"")*"')


def _mask(text: str) -> str:
    """Mask comments and string literals, keeping quoted identifiers such as #"A b"."""
    masked = list(_strip_strings_and_comments(text))
    for match in QUOTED.finditer(text):
        start, end = match.span()
        # Masking rewrites a quoted identifier as two spaces, its name, and a space;
        # restore it only where that rewrite happened (not inside comments or strings).
        if "".join(masked[start:end]) == "  " + match.group()[2:-1] + " ":
            masked[start:end] = match.group()
    return "".join(masked)


def _line(text: str, offset: int) -> int:
    return text.count("\n", 0, offset) + 1


def _members(masked: str) -> list[tuple[int, int]]:
    """Offsets of section members: text between top-level semicolons after `section X;`."""
    header = SECTION.search(masked)
    if not header:
        return []
    spans, depth, start = [], 0, header.end()
    for index in range(header.end(), len(masked)):
        char = masked[index]
        if char in OPEN:
            depth += 1
        elif char in CLOSE:
            depth = max(0, depth - 1)
        elif char == ";" and depth == 0:
            spans.append((start, index + 1))
            start = index + 1
    return spans


def _definition(masked: str, start: int, end: int) -> tuple[str, bool, int] | None:
    """Name, shared flag, and offset where the member's own text begins."""
    body = masked[start:end]
    lead = len(body) - len(body.lstrip())
    cursor = start + lead
    if masked.startswith("[", cursor):  # Attribute record such as [DataSource.Kind=...].
        depth = 0
        for index in range(cursor, end):
            depth += masked[index] in OPEN
            depth -= masked[index] in CLOSE
            if depth == 0:
                cursor = index + 1
                break
    match = re.match(
        r'\s*(shared\s+)?(#"(?:[^"]|"")*"|[A-Za-z_][\w.]*)\s*=(?!=)', masked[cursor:end]
    )
    if not match:
        return None
    return match.group(2), bool(match.group(1)), start + lead


def _end_line(text: str, start: int, end: int) -> int:
    return _line(text, start + len(text[start:end].rstrip()) - 1)


def index_file(connector: str, file: str, text: str) -> list[Function]:
    if file.lower().endswith(".pqm"):
        module = file.rsplit("/", 1)[-1]  # Named by file: a section member may share the stem.
        lines = text.rstrip().count("\n") + 1
        return [Function(connector, file, module, 1, lines)]
    masked = _mask(text)
    functions = []
    for start, end in _members(masked):
        definition = _definition(masked, start, end)
        if definition is None:
            continue
        name, shared, begin = definition
        functions.append(
            Function(connector, file, name, _line(text, begin), _end_line(text, begin, end), shared)
        )
    return functions


def index_connector(connector: str, files: dict[str, str]) -> list[Function]:
    """All members of a connector, with calls resolved to other members' names."""
    functions = [f for name, text in files.items() for f in index_file(connector, name, text)]
    names = {f.name for f in functions}
    modules = {f.name for f in functions if f.file.lower().endswith(".pqm")}
    result = []
    for function in functions:
        text = files[function.file]
        lines = text.splitlines()[function.start - 1 : function.end]
        source = "\n".join(lines)
        masked = _mask(source)
        called = {token for token in IDENTIFIER.findall(masked) if token in names}
        called |= {module for module in modules if f'"{module}"' in source}
        called.discard(function.name)
        result.append(replace(function, calls=tuple(sorted(called))))
    return result
