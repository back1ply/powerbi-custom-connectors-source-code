"""Remove embedded credentials from extracted connector files.

Client secrets, API keys and passwords are replaced with ``<redacted>``.
Client IDs are kept: in OAuth they are public identifiers, not secrets.
"""

from __future__ import annotations

import codecs
import re
from pathlib import Path

REDACTED = "<redacted>"

# Files that packages load with Extension.Contents("<name>") and that hold secrets.
SECRET_FILE_NAMES = re.compile(r"(secret|password|api_?key|auth_parameter)", re.IGNORECASE)

_SECRET_NAME = r"\w*(?:secret|api_?key|apikey|password|passwd)\w*"
# A credential-looking value: no whitespace, no URL, at least 8 characters.
_SECRET_VALUE = r"(?![^\"]*://)[^\"\s]{8,}"

M_ASSIGNMENT = re.compile(
    rf"(?P<prefix>\b{_SECRET_NAME}\s*=\s*\")(?P<value>{_SECRET_VALUE})\"",
    re.IGNORECASE,
)
JSON_PROPERTY = re.compile(
    rf"(?P<prefix>\"{_SECRET_NAME}\"\s*:\s*\")(?P<value>{_SECRET_VALUE})\"",
    re.IGNORECASE,
)

TEXT_RULES = {
    ".m": M_ASSIGNMENT,
    ".pq": M_ASSIGNMENT,
    ".pqm": M_ASSIGNMENT,
    ".json": JSON_PROPERTY,
}


def redact_text(text: str, pattern: re.Pattern[str]) -> tuple[str, int]:
    """Replace secret values matched by ``pattern``. Returns the new text and match count."""
    return pattern.subn(lambda m: f'{m["prefix"]}{REDACTED}"', text)


def _is_secret_file(path: Path) -> bool:
    return path.suffix == "" and bool(SECRET_FILE_NAMES.search(path.name))


def redact_file(path: Path) -> int:
    """Redact one file in place. Returns the number of values removed."""
    if _is_secret_file(path):
        if path.read_bytes().strip() in (b"", REDACTED.encode()):
            return 0
        path.write_text(REDACTED + "\n", encoding="utf-8")
        return 1
    pattern = TEXT_RULES.get(path.suffix.lower())
    if pattern is None:
        return 0
    raw = path.read_bytes()
    bom = codecs.BOM_UTF8 if raw.startswith(codecs.BOM_UTF8) else b""
    text = raw[len(bom) :].decode("utf-8", errors="surrogateescape")
    new_text, count = redact_text(text, pattern)
    if count:
        path.write_bytes(bom + new_text.encode("utf-8", errors="surrogateescape"))
    return count


def redact_tree(root: Path) -> int:
    """Redact every file under ``root``. Returns the total number of values removed."""
    return sum(redact_file(path) for path in sorted(root.rglob("*")) if path.is_file())
