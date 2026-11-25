# Copyright 2026 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from __future__ import annotations

import re
from dataclasses import dataclass, field
from datetime import date, datetime, timezone
from typing import Any

import yaml

# OKF v0.3 §4.1: `type` is the only always-required frontmatter key.
REQUIRED_FRONTMATTER_KEYS = ("type",)

_FRONTMATTER_DELIM = "---"

_TIMESTAMP_TAG = "tag:yaml.org,2002:timestamp"
_TIMESTAMP_RE = next(
    regexp
    for resolvers in yaml.SafeLoader.yaml_implicit_resolvers.values()
    for tag, regexp in resolvers
    if tag == _TIMESTAMP_TAG
)
_RESOLVERS_WITHOUT_TIMESTAMP = {
    ch: [(tag, regexp) for tag, regexp in resolvers if tag != _TIMESTAMP_TAG]
    for ch, resolvers in yaml.SafeLoader.yaml_implicit_resolvers.items()
}

# OKF v0.3 §5: the two RFC 3339 forms of a timestamp.
_FULL_DATE_RE = re.compile(r"\d{4}-\d{2}-\d{2}")
_DATE_TIME_RE = re.compile(
    r"\d{4}-\d{2}-\d{2}[Tt]\d{2}:\d{2}:\d{2}(\.\d+)?([Zz]|[+-]\d{2}:\d{2})"
)


class _Loader(yaml.SafeLoader):
    """SafeLoader that leaves timestamps as the text the author wrote.

    PyYAML implements YAML 1.1, whose implicit resolvers turn a value like
    `2026-06-30T14:00:00Z` into a `datetime`. Dumping it back yields
    `2026-06-30 14:00:00+00:00`, so a parse/serialize round-trip silently
    rewrites the author's frontmatter. Dropping the resolver keeps every
    value a string, matching the YAML 1.2 core schema.
    """


_Loader.yaml_implicit_resolvers = _RESOLVERS_WITHOUT_TIMESTAMP


class _Dumper(yaml.SafeDumper):
    """SafeDumper that writes a timestamp-like string the way the file had it.

    SafeDumper quotes every string that looks like a timestamp, so rewriting
    `at: 2026-06-30T14:00:00Z` gives `at: '2026-06-30T14:00:00Z'`: a
    quote-only diff. Values in `plain_timestamps` stay plain; the rest are
    quoted. Both forms read back as the same string.
    """

    plain_timestamps: frozenset[str] = frozenset()


_Dumper.yaml_implicit_resolvers = _RESOLVERS_WITHOUT_TIMESTAMP


def _represent_str(dumper: _Dumper, value: str) -> yaml.ScalarNode:
    style = None
    if _TIMESTAMP_RE.match(value) and value not in dumper.plain_timestamps:
        style = "'"
    return dumper.represent_scalar("tag:yaml.org,2002:str", value, style=style)


_Dumper.add_representer(str, _represent_str)


def _find_plain_timestamps(node: yaml.Node | None) -> set[str]:
    """Timestamp-like scalars that the YAML wrote without quotes."""
    if isinstance(node, yaml.ScalarNode):
        if node.style is None and _TIMESTAMP_RE.match(node.value):
            return {node.value}
        return set()
    found: set[str] = set()
    if isinstance(node, yaml.SequenceNode):
        for item in node.value:
            found |= _find_plain_timestamps(item)
    elif isinstance(node, yaml.MappingNode):
        for key, value in node.value:
            found |= _find_plain_timestamps(key) | _find_plain_timestamps(value)
    return found


class OKFDocumentError(ValueError):
    pass


@dataclass
class OKFDocument:
    frontmatter: dict[str, Any] = field(default_factory=dict)
    body: str = ""
    # Timestamp-like values that the source file wrote without quotes.
    # `serialize` keeps them plain so a rewrite does not change their quoting.
    plain_timestamps: frozenset[str] = field(
        default_factory=frozenset, compare=False, repr=False
    )

    @classmethod
    def parse(cls, text: str) -> "OKFDocument":
        # Some editors write a UTF-8 BOM. Drop it so that the opening `---`
        # is found. `splitlines` already treats CRLF and LF the same.
        text = text.removeprefix("\ufeff")
        lines = text.splitlines()
        if not lines or lines[0].strip() != _FRONTMATTER_DELIM:
            return cls(frontmatter={}, body=text)

        end_idx = None
        for i in range(1, len(lines)):
            if lines[i].strip() == _FRONTMATTER_DELIM:
                end_idx = i
                break
        if end_idx is None:
            raise OKFDocumentError("Unterminated YAML frontmatter block")

        fm_text = "\n".join(lines[1:end_idx])
        try:
            fm = yaml.load(fm_text, Loader=_Loader) or {}
            plain = _find_plain_timestamps(yaml.compose(fm_text, Loader=_Loader))
        except yaml.YAMLError as e:
            raise OKFDocumentError(f"Invalid YAML in frontmatter: {e}") from e
        if not isinstance(fm, dict):
            raise OKFDocumentError("Frontmatter must be a YAML mapping")

        body = "\n".join(lines[end_idx + 1:])
        if body.startswith("\n"):
            body = body[1:]
        return cls(frontmatter=fm, body=body, plain_timestamps=frozenset(plain))

    def serialize(self) -> str:
        dumper = type("_DocDumper", (_Dumper,), {"plain_timestamps": self.plain_timestamps})
        fm_text = yaml.dump(
            self.frontmatter, Dumper=dumper, sort_keys=False, allow_unicode=True
        ).rstrip()
        body = self.body if self.body.endswith("\n") else self.body + "\n"
        return f"{_FRONTMATTER_DELIM}\n{fm_text}\n{_FRONTMATTER_DELIM}\n\n{body}"

    def validate(self) -> None:
        missing = [k for k in REQUIRED_FRONTMATTER_KEYS if not self.frontmatter.get(k)]
        if missing:
            raise OKFDocumentError(
                f"Missing required frontmatter keys: {', '.join(missing)}"
            )


def normalize_verified(frontmatter: dict[str, Any]) -> list[dict[str, Any]]:
    """Return the `verified` events as a list (OKF v0.3 §5.2).

    A single verifier MAY be written as one `{ by, at }` mapping without the
    list dash; consumers MUST treat a bare mapping as a one-element list.
    """
    verified = frontmatter.get("verified")
    if verified is None:
        return []
    if isinstance(verified, dict):
        return [verified]
    if isinstance(verified, list):
        return [v for v in verified if isinstance(v, dict)]
    return []


def _current_events(frontmatter: dict[str, Any]) -> list[dict[str, Any]]:
    """The verification events that are current (OKF v0.3 §5.3).

    An event is current when its `at` is at or after `generated.at`, or when
    `generated` is absent. Events without both `by` and `at` are ignored. When
    either timestamp cannot be parsed, the event is not current.
    """
    events = [e for e in normalize_verified(frontmatter) if e.get("by") and e.get("at")]
    generated = frontmatter.get("generated")
    if not isinstance(generated, dict) or not generated.get("at"):
        return events
    generated_at = parse_timestamp(generated["at"])
    if generated_at is None:
        return []
    current = []
    for event in events:
        at = parse_timestamp(event["at"])
        if at is not None and at >= generated_at:
            current.append(event)
    return current


def trust_tier(frontmatter: dict[str, Any]) -> str:
    """Derive a concept's trust tier from current `verified` events (OKF v0.3 §5.3).

    - No current event ⇒ "unverified".
    - Current events from non-`human:` actors only ⇒ "machine-confirmed".
    - A current event from a `human:<id>` actor ⇒ "human-reviewed".
    """
    events = _current_events(frontmatter)
    if not events:
        return "unverified"
    for event in events:
        by = str(event.get("by") or "")
        if by.startswith("human:"):
            return "human-reviewed"
    return "machine-confirmed"


def parse_timestamp(value: Any) -> datetime | None:
    """Parse an OKF timestamp (OKF v0.3 §5), or return None if it is malformed.

    A value is an RFC 3339 date-time with an offset, or a date only, which
    means the start of that day in UTC. Quoted strings and YAML-native
    `date`/`datetime` values are both accepted. A date-time without an
    offset is malformed.
    """
    if isinstance(value, datetime):
        return value if value.tzinfo is not None else None
    if isinstance(value, date):
        return datetime(value.year, value.month, value.day, tzinfo=timezone.utc)
    if not isinstance(value, str):
        return None
    try:
        if _FULL_DATE_RE.fullmatch(value):
            d = date.fromisoformat(value)
            return datetime(d.year, d.month, d.day, tzinfo=timezone.utc)
        if _DATE_TIME_RE.fullmatch(value):
            return datetime.fromisoformat(value.upper().replace("Z", "+00:00"))
    except ValueError:
        return None
    return None


def is_stale(frontmatter: dict[str, Any], now: datetime | None = None) -> bool:
    """Whether a concept is stale per `stale_after` (OKF v0.3 §5.5).

    A concept is stale when `now >= stale_after`. An absent, null, or empty
    `stale_after` is never stale. A value that does not parse is treated as
    stale, because a consumer MUST NOT treat it as fresh.
    """
    raw = frontmatter.get("stale_after")
    if raw is None or raw == "":
        return False
    stale_after = parse_timestamp(raw)
    if stale_after is None:
        return True
    return (now or datetime.now(timezone.utc)) >= stale_after
