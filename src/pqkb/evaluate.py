"""Score generated checklist profiles against the hand-labelled gold set.

For every gold connector and every choice question (top-level and sub-question),
answers are compared as sets: precision, recall, and exact-match rate per question,
plus micro-averaged totals. Free-text answers are not scored. A connector without
a profile counts as missing, not as a wrong answer.
"""

from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path

import yaml

from pqkb.checklist import answer_ids, load_checklist


def load_answer_sets(folder: Path) -> dict[str, dict]:
    profiles = {}
    for path in sorted(folder.iterdir()) if folder.is_dir() else []:
        if path.suffix == ".json":
            profiles[path.stem] = json.loads(path.read_text(encoding="utf-8"))
        elif path.suffix in (".yaml", ".yml"):
            profiles[path.stem] = yaml.safe_load(path.read_text(encoding="utf-8"))
    return profiles


def choice_answers(profile: dict, checklist: list[dict]) -> dict[str, set[str]]:
    """Map 'question' and 'question/sub' ids to answer-id sets (free text excluded)."""
    result = {}
    answers = profile.get("answers") or {}
    for spec in checklist:
        answer = answers.get(spec["id"]) or {}
        result[spec["id"]] = set(answer_ids(answer.get("values")))
        for sub in spec.get("sub", []):
            if sub.get("free_text"):
                continue
            sub_answer = (answer.get("sub") or {}).get(sub["id"])
            if sub_answer is not None:
                result[f"{spec['id']}/{sub['id']}"] = set(answer_ids(sub_answer.get("values")))
    return result


def score(gold: dict[str, dict], predicted: dict[str, dict], checklist: list[dict]) -> dict:
    counts = defaultdict(lambda: {"tp": 0, "fp": 0, "fn": 0, "exact": 0, "n": 0})
    missing, mistakes = [], []
    for name, gold_profile in sorted(gold.items()):
        if name not in predicted:
            missing.append(name)
            continue
        expected = choice_answers(gold_profile, checklist)
        got = choice_answers(predicted[name], checklist)
        for question, truth in expected.items():
            answer = got.get(question, set())
            row = counts[question]
            row["tp"] += len(answer & truth)
            row["fp"] += len(answer - truth)
            row["fn"] += len(truth - answer)
            row["n"] += 1
            row["exact"] += answer == truth
            if answer != truth:
                mistakes.append(
                    {
                        "connector": name,
                        "question": question,
                        "expected": sorted(truth),
                        "got": sorted(answer),
                    }
                )
    per_question = {q: _rates(c) for q, c in counts.items()}
    total = {k: sum(c[k] for c in counts.values()) for k in ("tp", "fp", "fn", "exact", "n")}
    return {
        "connectors_scored": len(gold) - len(missing),
        "missing": missing,
        "overall": _rates(total),
        "per_question": per_question,
        "mistakes": mistakes,
    }


def _rates(c: dict) -> dict:
    precision = c["tp"] / (c["tp"] + c["fp"]) if c["tp"] + c["fp"] else 1.0
    recall = c["tp"] / (c["tp"] + c["fn"]) if c["tp"] + c["fn"] else 1.0
    return {
        "precision": round(precision, 3),
        "recall": round(recall, 3),
        "exact": round(c["exact"] / c["n"], 3) if c["n"] else 0.0,
        "n": c["n"],
    }


def evaluate(repo: Path, gold_dir: Path, profile_dir: Path) -> dict:
    checklist = load_checklist(repo)
    return score(load_answer_sets(gold_dir), load_answer_sets(profile_dir), checklist)


def report_lines(result: dict) -> list[str]:
    lines = [f"{'question':34} {'prec':>5} {'rec':>5} {'exact':>5} {'n':>3}"]
    for question, r in sorted(result["per_question"].items(), key=lambda kv: kv[1]["exact"]):
        lines.append(
            f"{question:34} {r['precision']:5.2f} {r['recall']:5.2f} {r['exact']:5.2f} {r['n']:3}"
        )
    o = result["overall"]
    lines.append(
        f"{'OVERALL':34} {o['precision']:5.2f} {o['recall']:5.2f} {o['exact']:5.2f} {o['n']:3}"
    )
    missing = ", ".join(result["missing"]) or "none"
    lines.append(f"Scored {result['connectors_scored']} connectors; missing: {missing}.")
    return lines
