"""Read and write markdown files with YAML frontmatter."""

from __future__ import annotations

import re
from dataclasses import dataclass
from pathlib import Path

import yaml

_BLOCK = re.compile(r"\A---\r?\n(.*?)\r?\n---\r?\n?(.*)\Z", re.DOTALL)


@dataclass
class Document:
    meta: dict
    body: str


def parse(text: str) -> Document:
    match = _BLOCK.match(text)
    if not match:
        return Document({}, text)
    return Document(yaml.safe_load(match.group(1)) or {}, match.group(2))


def read(path: Path) -> Document:
    return parse(path.read_text(encoding="utf-8"))


class _Dumper(yaml.SafeDumper):
    """Write short lists inline (``tags: [a, b]``) and keep key order."""


def _represent_list(dumper: yaml.SafeDumper, data: list) -> yaml.Node:
    flow = all(isinstance(item, str | int | float) for item in data)
    return dumper.represent_sequence("tag:yaml.org,2002:seq", data, flow_style=flow)


_Dumper.add_representer(list, _represent_list)


def render(meta: dict, body: str) -> str:
    header = yaml.dump(meta, Dumper=_Dumper, sort_keys=False, allow_unicode=True, width=1000)
    return f"---\n{header}---\n\n{body.strip()}\n"
