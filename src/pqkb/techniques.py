"""Render the technique matrix: which connectors use each checklist answer.

One page lists, for every checklist question and answer id, the connectors whose
profile gives that answer, with the first cited source line. Hand-checked labels
(`evals/gold/`, `evals/holdout/`) take precedence over model-generated profiles
(`knowledge/profiles/`), and each entry says which kind it is. The page shows what
certified connectors do, which is evidence, not a recommendation.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import quote

import yaml

from pqkb.checklist import answer_ids, load_checklist

HAND_DIRS = (Path("evals") / "gold", Path("evals") / "holdout")
PROFILE_DIR = Path("knowledge") / "profiles"


@dataclass(frozen=True)
class Use:
    connector: str
    hand_checked: bool
    citation: str  # "file:line" of the first evidence item, or ""


def load_answer_sources(repo: Path) -> dict[str, tuple[dict, bool]]:
    """Connector -> (answers, hand_checked); hand-checked labels win."""
    sources: dict[str, tuple[dict, bool]] = {}
    profiles = repo / PROFILE_DIR
    for path in sorted(profiles.glob("*.json")) if profiles.is_dir() else []:
        sources[path.stem] = (
            json.loads(path.read_text(encoding="utf-8")).get("answers", {}),
            False,
        )
    for folder in HAND_DIRS:
        for path in sorted((repo / folder).glob("*.yaml")):
            data = yaml.safe_load(path.read_text(encoding="utf-8")) or {}
            sources[path.stem] = (data.get("answers", {}), True)
    return sources


def _citation(answer: dict) -> str:
    evidence = answer.get("evidence") or []
    if not evidence or not isinstance(evidence[0], dict):
        return ""
    first = evidence[0]
    line = str(first.get("lines", "")).split("-")[0].split(",")[0].strip()
    return f"{first.get('file', '')}:{line}" if first.get("file") else ""


def collect(checklist: list[dict], sources: dict[str, tuple[dict, bool]]) -> dict:
    """Question key -> answer id -> list of Use, for every choice question."""
    matrix: dict[str, dict[str, list[Use]]] = {}
    for name, (answers, hand) in sorted(sources.items()):
        for spec in checklist:
            answer = answers.get(spec["id"]) or {}
            _add(matrix, spec["id"], answer, name, hand)
            for sub in spec.get("sub", []):
                if sub.get("free_text"):
                    continue
                sub_answer = (answer.get("sub") or {}).get(sub["id"])
                if isinstance(sub_answer, dict):
                    _add(matrix, f"{spec['id']}/{sub['id']}", sub_answer, name, hand)
    return matrix


def _add(matrix: dict, key: str, answer: dict, name: str, hand: bool) -> None:
    if not isinstance(answer, dict):
        return
    for value in answer_ids(answer.get("values")):
        matrix.setdefault(key, {}).setdefault(value, []).append(Use(name, hand, _citation(answer)))


def _questions(checklist: list[dict]):
    for spec in checklist:
        yield spec["id"], spec
        for sub in spec.get("sub", []):
            if not sub.get("free_text"):
                yield f"{spec['id']}/{sub['id']}", sub


INTRO = (
    "Which archived connectors use each answer of the connector checklist "
    "(`knowledge/checklist.yaml`), with the first cited source line. "
    "**✓** marks hand-checked labels; the rest are model-generated profiles "
    "(about 95% exact against hand labels), so open the cited line before relying "
    "on one. This shows what certified connectors do, which is evidence rather than "
    "advice: Microsoft's guidance and the `write-connector` skill say what to do."
)


def render_pages(
    checklist: list[dict], matrix: dict, all_connectors: list[str], docs_base: str
) -> dict[str, tuple[dict | None, str]]:
    """File name -> (frontmatter or None, Markdown body): an index plus one page per
    top-level question. The index has no frontmatter, like the other bundle indexes."""
    profiled = {
        u.connector for answers in matrix.values() for uses in answers.values() for u in uses
    }
    missing = [n for n in all_connectors if n not in profiled]
    pages: dict[str, tuple[dict | None, str]] = {}
    index = ["# Techniques", "", INTRO, ""]
    for spec in checklist:
        keys = [k for k, _ in _questions([spec]) if matrix.get(k)]
        if not keys:
            continue
        meta = {
            "type": "Power Query Technique Matrix",
            "title": f"Techniques: {spec['id']}",
            "description": f"Archived connectors by answer to: {spec['question']}",
        }
        body = [f"# {spec['id']}", "", INTRO, ""]
        for key, question in _questions([spec]):
            if matrix.get(key):
                body += _question_section(key, question, matrix[key], docs_base)
        pages[f"{spec['id']}.md"] = (meta, "\n".join(body))
        counts = ", ".join(f"`{a}` {len(u)}" for a, u in _ordered(spec, matrix.get(spec["id"], {})))
        index.append(f"* [{spec['id']}]({spec['id']}.md): {spec['question']} {counts}")
    if missing:
        index += [
            "",
            "## Not profiled",
            "",
            "No profile yet (too large for the model, or rejected): "
            + ", ".join(f"[{n}](../connectors/{quote(n)}.md)" for n in missing)
            + ".",
        ]
    pages["index.md"] = (None, "\n".join(index) + "\n")
    return pages


def _ordered(spec: dict, answers: dict) -> list[tuple[str, list]]:
    known = [a for a in spec["answers"] if a in answers]
    extra = sorted(a for a in answers if a not in spec["answers"])
    return [(a, answers[a]) for a in known + extra]


def _question_section(key: str, spec: dict, answers: dict, docs_base: str) -> list[str]:
    docs = f" ([Learn]({docs_base}{spec['docs']}))" if spec.get("docs") else ""
    lines = [f"## {key}: {spec['question']}{docs}", ""]
    definitions = spec.get("definitions") or {}
    for answer_id, uses in _ordered(spec, answers):
        uses = sorted(uses, key=lambda u: (not u.hand_checked, u.connector))
        lines += [f"### `{answer_id}`: {len(uses)} connectors", ""]
        meaning = definitions.get(answer_id, {}).get("means")
        if meaning:
            lines += [meaning, ""]
        lines += [", ".join(_entry(u) for u in uses), ""]
    return lines


def _entry(use: Use) -> str:
    mark = " ✓" if use.hand_checked else ""
    cite = f" `{use.citation}`" if use.citation else ""
    return f"[{use.connector}](../connectors/{quote(use.connector)}.md){mark}{cite}"


def techniques_pages(repo: Path, all_connectors: list[str]) -> dict[str, tuple[dict | None, str]]:
    """Pages for `bundle/techniques/`; empty when the repository has no checklist."""
    path = repo / "knowledge" / "checklist.yaml"
    if not path.is_file():
        return {}
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    checklist = load_checklist(repo)
    matrix = collect(checklist, load_answer_sources(repo))
    return render_pages(checklist, matrix, all_connectors, data.get("docs_base", ""))
