"""Render the topic pages: one per checklist question, in Power Query SDK order.

Each topic page lists the pattern pages that explain it, then every answer to the
question with the connectors whose profile gives it and the first cited source line.
Answers link to the patterns that explain them (`knowledge/topics.yaml`).
Hand-checked labels (`evals/gold/`, `evals/holdout/`) take precedence over
model-generated profiles (`knowledge/profiles/`), and each entry says which kind it
is. Connector counts show what certified connectors do, which is evidence, not a
recommendation.
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
CHECKLIST_FILE = Path("knowledge") / "checklist.yaml"
TOPICS_FILE = Path("knowledge") / "topics.yaml"
TOPICS_DIR = "topics"

INDEX_INTRO = (
    "One topic per question of the connector checklist, in the order of the Power Query "
    "SDK concepts on Microsoft Learn. Each topic lists the pattern pages that explain it "
    "and which archived connectors use each answer."
)
INTRO = (
    "Connector lists come from the connector checklist (`knowledge/checklist.yaml`), "
    "with the first cited source line. **✓** marks hand-checked labels; the rest are "
    "model-generated profiles (about 95% exact against hand labels), so open the cited "
    "line before relying on one. Counts show what certified connectors do, which is "
    "evidence rather than advice: Microsoft's guidance and the `write-connector` skill "
    "say what to do."
)


@dataclass(frozen=True)
class Use:
    connector: str
    hand_checked: bool
    citation: str  # "file:line" of the first evidence item, or ""


@dataclass(frozen=True)
class Guide:
    """A pattern page and the checklist answers it explains."""

    pattern_id: str
    title: str
    description: str
    answers: dict[str, list[str]]  # question id -> answer ids; [] = the whole question

    @property
    def home(self) -> str:
        """The question whose topic holds this pattern in the site menu."""
        return next(iter(self.answers))

    def link(self, prefix: str) -> str:
        return f"[{self.title}]({prefix}patterns/{self.pattern_id}.md)"


@dataclass(frozen=True)
class Topics:
    checklist: list[dict]
    docs_base: str
    titles: dict[str, str]
    guides: list[Guide]

    def related(self, question: str) -> list[Guide]:
        return [g for g in self.guides if question in g.answers]

    def homed(self, question: str) -> list[Guide]:
        return sorted((g for g in self.guides if g.home == question), key=lambda g: g.title.lower())


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


def load_guides(
    config: dict, checklist: list[dict], patterns: dict[str, tuple[str, str]]
) -> tuple[dict[str, str], list[Guide]]:
    """Validate `topics.yaml` against the checklist and the pattern pages.

    `patterns` maps pattern id -> (title, description). Returns (titles, guides).
    """
    questions = {spec["id"]: set(spec["answers"]) for spec in checklist}
    titles = config.get("titles") or {}
    mapping = config.get("patterns") or {}
    problems = _missing("question", "title", set(questions), set(titles))
    problems += _missing("pattern", "topic", set(patterns), set(mapping))
    for pattern_id, answers in mapping.items():
        problems += _mapping_problems(pattern_id, answers, questions)
    if problems:
        raise ValueError(f"{TOPICS_FILE.as_posix()}: " + "; ".join(problems))
    return titles, [_guide(pid, patterns[pid], answers) for pid, answers in mapping.items()]


def _guide(pattern_id: str, summary: tuple[str, str], answers: dict) -> Guide:
    return Guide(pattern_id, *summary, {q: list(ids or []) for q, ids in answers.items()})


def _missing(kind: str, needs: str, known: set[str], mapped: set[str]) -> list[str]:
    """Problems for known ids without a mapping and for mapped ids nobody knows."""
    problems = [f"{kind} {k!r} has no {needs}" for k in sorted(known - mapped)]
    return problems + [f"unknown {kind} {m!r} in {needs}s" for m in sorted(mapped - known)]


def _mapping_problems(pattern_id: str, answers, questions: dict[str, set]) -> list[str]:
    if not isinstance(answers, dict) or not answers:
        return [f"pattern {pattern_id!r} needs at least one question"]
    problems = []
    for question, ids in answers.items():
        if question not in questions:
            problems.append(f"pattern {pattern_id!r}: unknown question {question!r}")
            continue
        unknown = [a for a in ids or [] if a not in questions[question]]
        problems += [f"pattern {pattern_id!r}: unknown {question} answer {a!r}" for a in unknown]
    return problems


def load_topics(repo: Path, patterns: dict[str, tuple[str, str]]) -> Topics | None:
    """The checklist and its topic mapping; None when the repository has no checklist."""
    if not (repo / CHECKLIST_FILE).is_file():
        return None
    data = yaml.safe_load((repo / CHECKLIST_FILE).read_text(encoding="utf-8"))
    topics_path = repo / TOPICS_FILE
    config = (
        yaml.safe_load(topics_path.read_text(encoding="utf-8")) if topics_path.is_file() else {}
    )
    checklist = load_checklist(repo)
    titles, guides = load_guides(config or {}, checklist, patterns)
    return Topics(checklist, data.get("docs_base", ""), titles, guides)


def render_pages(
    topics: Topics, matrix: dict, all_connectors: list[str]
) -> dict[str, tuple[dict | None, str]]:
    """Path under `topics/` -> (frontmatter or None, Markdown body): an index plus one
    `<question>.md` per question. The index has no frontmatter: OKF reserves `index.md`
    for listings."""
    pages: dict[str, tuple[dict | None, str]] = {}
    index = ["# Topics", "", INDEX_INTRO, ""]
    for spec in topics.checklist:
        qid, title = spec["id"], topics.titles[spec["id"]]
        meta = {"type": "Power Query Topic", "title": title, "description": spec["question"]}
        body = _topic_body(topics, spec, matrix)
        pages[f"{qid}.md"] = (meta, body)
        index += _index_entry(spec, title, matrix, topics.homed(qid))
    index += _unprofiled(matrix, all_connectors)
    pages["index.md"] = (None, "\n".join(index).rstrip() + "\n")
    return pages


def _index_entry(spec: dict, title: str, matrix: dict, homed: list[Guide]) -> list[str]:
    counts = ", ".join(f"`{a}` {len(u)}" for a, u in _ordered(spec, matrix.get(spec["id"], {})))
    lines = [f"## [{title}]({spec['id']}.md)", "", f"{spec['question']} {counts}".strip()]
    if homed:
        lines += ["", *(f"* {g.link('../')} - {g.description}" for g in homed)]
    return lines + [""]


def _unprofiled(matrix: dict, all_connectors: list[str]) -> list[str]:
    profiled = {
        u.connector for answers in matrix.values() for uses in answers.values() for u in uses
    }
    missing = [n for n in all_connectors if n not in profiled]
    if not missing:
        return []
    links = ", ".join(f"[{n}](../connectors/{quote(n)}.md)" for n in missing)
    return [
        "## Not profiled",
        "",
        f"No profile yet (too large for the model, or rejected): {links}.",
    ]


def _topic_body(topics: Topics, spec: dict, matrix: dict) -> str:
    related = topics.related(spec["id"])
    docs = f" ([Learn]({topics.docs_base}{spec['docs']}))" if spec.get("docs") else ""
    body = [f"# {topics.titles[spec['id']]}", "", f"{spec['question']}{docs}", ""]
    if related:
        body += [
            "## Patterns",
            "",
            *(f"* {g.link('../')} - {g.description}" for g in related),
            "",
        ]
    body += ["## Connectors by answer", "", INTRO, ""]
    for key, question in _questions([spec]):
        if matrix.get(key):
            body += _question_section(key, question, matrix[key], related)
    return "\n".join(body)


def _ordered(spec: dict, answers: dict) -> list[tuple[str, list]]:
    known = [a for a in spec["answers"] if a in answers]
    extra = sorted(a for a in answers if a not in spec["answers"])
    return [(a, answers[a]) for a in known + extra]


def _question_section(key: str, spec: dict, answers: dict, related: list[Guide]) -> list[str]:
    lines = [f"### {key}: {spec['question']}", ""]
    definitions = spec.get("definitions") or {}
    for answer_id, uses in _ordered(spec, answers):
        uses = sorted(uses, key=lambda u: (not u.hand_checked, u.connector))
        lines += [f"#### `{answer_id}`: {len(uses)} connectors", ""]
        meaning = definitions.get(answer_id, {}).get("means")
        if meaning:
            lines += [meaning, ""]
        explained = [g.link("../") for g in related if answer_id in g.answers.get(key, [])]
        if explained:
            lines += [f"Explained in: {', '.join(explained)}.", ""]
        lines += [", ".join(_entry(u) for u in uses), ""]
    return lines


def _entry(use: Use) -> str:
    mark = " ✓" if use.hand_checked else ""
    cite = f" `{use.citation}`" if use.citation else ""
    return f"[{use.connector}](../connectors/{quote(use.connector)}.md){mark}{cite}"


def topic_pages(
    repo: Path, all_connectors: list[str], patterns: dict[str, tuple[str, str]]
) -> dict[str, tuple[dict | None, str]]:
    """Pages for `bundle/topics/`; empty when the repository has no checklist."""
    topics = load_topics(repo, patterns)
    if topics is None:
        return {}
    matrix = collect(topics.checklist, load_answer_sources(repo))
    return render_pages(topics, matrix, all_connectors)


def topic_menu(topics: Topics | None) -> list:
    """Site menu entries: each topic page, with the patterns it holds nested under it."""
    if topics is None:
        return []
    menu: list = [f"{TOPICS_DIR}/index.md"]
    for spec in topics.checklist:
        page = f"{TOPICS_DIR}/{spec['id']}.md"
        children = [{g.title: f"patterns/{g.pattern_id}.md"} for g in topics.homed(spec["id"])]
        entry = [{"Overview": page}, *children] if children else page
        menu.append({topics.titles[spec["id"]]: entry})
    return [{"Topics": menu}]
