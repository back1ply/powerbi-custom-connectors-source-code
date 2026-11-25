"""Load the per-connector checklist and validate answer sets against it and the source.

Used for hand-labelled gold profiles (`evals/gold/`) and, later, generated profiles.
Validation is structural and source-bound: allowed answer ids, required questions,
conditional sub-questions, and citations that point at real line ranges. It does not
judge whether an answer is correct; evals do that against the gold set.
"""

from __future__ import annotations

from pathlib import Path

import yaml

NOT_APPLICABLE = "not-applicable"
NEGATIVE = {"none", "no", "not-defined", "default", NOT_APPLICABLE}


def answer_ids(values) -> list[str]:
    """Answer ids as text; YAML 1.1 reads unquoted yes/no as booleans."""
    return ["yes" if v is True else "no" if v is False else str(v) for v in values or []]


def load_checklist(repo: Path) -> list[dict]:
    data = yaml.safe_load((repo / "knowledge" / "checklist.yaml").read_text(encoding="utf-8"))
    return data["questions"]


def _line_count(repo: Path, connector: str, file: str) -> int | None:
    path = repo / "connectors" / connector / file
    if not path.is_file():
        return None
    return len(path.read_text(encoding="utf-8-sig").splitlines())


def _check_evidence(repo: Path, connector: str, where: str, answer: dict) -> list[str]:
    problems = []
    for item in answer.get("evidence") or []:
        file, lines = item.get("file", ""), str(item.get("lines", ""))
        total = _line_count(repo, connector, file)
        if total is None:
            problems.append(f"{where}: cited file {file!r} does not exist")
            continue
        first, _, last = lines.partition("-")
        try:
            start, end = int(first), int(last or first)
        except ValueError:
            problems.append(f"{where}: bad line range {lines!r}")
            continue
        if not 1 <= start <= end <= total:
            problems.append(f"{where}: lines {lines} outside {file} (1-{total})")
    return problems


def _check_answer(
    repo: Path, connector: str, where: str, spec: dict, answer: dict | None
) -> list[str]:
    if not isinstance(answer, dict):
        return [f"{where}: missing"]
    if spec.get("free_text"):
        problems = [] if answer.get("text") else [f"{where}: free-text answer is empty"]
        return problems + _check_evidence(repo, connector, where, answer)
    values = answer_ids(answer.get("values"))
    allowed = set(spec["answers"]) | {NOT_APPLICABLE}
    problems = [f"{where}: unknown answer {v!r}" for v in values if v not in allowed]
    if not values:
        problems.append(f"{where}: no answer")
    if len(values) > 1 and not spec.get("multi"):
        problems.append(f"{where}: several answers to a single-answer question")
    if set(values) - NEGATIVE and not answer.get("evidence"):
        problems.append(f"{where}: answer {values} has no evidence")
    return problems + _check_evidence(repo, connector, where, answer)


def validate_profile(repo: Path, profile: dict, checklist: list[dict] | None = None) -> list[str]:
    """Problems with one connector's answer set; an empty list means it is well formed."""
    checklist = checklist or load_checklist(repo)
    connector = profile.get("connector", "")
    if not (repo / "connectors" / connector).is_dir():
        return [f"unknown connector {connector!r}"]
    answers = profile.get("answers") or {}
    problems = [
        f"{connector}: unknown question {q!r}"
        for q in answers
        if q not in {s["id"] for s in checklist}
    ]
    for spec in checklist:
        where = f"{connector}/{spec['id']}"
        answer = answers.get(spec["id"])
        problems += _check_answer(repo, connector, where, spec, answer)
        if not isinstance(answer, dict):
            continue
        given = set(answer_ids(answer.get("values")))
        subs = answer.get("sub") or {}
        for sub in spec.get("sub", []):
            required = "when" not in sub or bool(given & set(sub["when"]))
            if required:
                problems += _check_answer(
                    repo, connector, f"{where}/{sub['id']}", sub, subs.get(sub["id"])
                )
            elif sub["id"] in subs:
                problems.append(f"{where}/{sub['id']}: answered but its condition is not met")
    return problems


def load_profiles(folder: Path) -> dict[str, dict]:
    return {
        path.stem: yaml.safe_load(path.read_text(encoding="utf-8"))
        for path in sorted(folder.glob("*.yaml"))
    }
