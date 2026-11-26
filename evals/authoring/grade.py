"""Grade one authoring trial's connector.

Usage: uv run python evals/authoring/grade.py TRIAL_DIR

Runs the static certification checks and a Haiku checklist profile on
TRIAL_DIR/connector/, scores the profile against rubric.yaml, writes
TRIAL_DIR/grade.json, and prints one summary line. Both are source readings: nothing
is executed, so this measures design and form, not whether the M code runs.
"""

from __future__ import annotations

import json
import subprocess
import sys
from collections import Counter
from pathlib import Path

import yaml

REPO = Path(__file__).resolve().parents[2]
RUBRIC = Path(__file__).with_name("rubric.yaml")


def pqkb(*args: str) -> subprocess.CompletedProcess:
    return subprocess.run(
        ["uv", "run", "--project", str(REPO), "pqkb", "--repo", str(REPO), *args],
        text=True,
        encoding="utf-8",
        capture_output=True,
        timeout=1800,
    )


def answer_values(answers: dict, key: str) -> set[str]:
    from pqkb.checklist import answer_ids

    question, _, sub = key.partition("/")
    answer = answers.get(question) or {}
    if sub:
        answer = (answer.get("sub") or {}).get(sub) or {}
    return set(answer_ids(answer.get("values")))


def score(answers: dict, rubric: dict) -> tuple[int, int, list[str]]:
    points, total, misses = 0, 0, []
    for key, rule in rubric.items():
        given = answer_values(answers, key)
        for required in rule.get("require", []):
            total += 1
            if str(required) in given:
                points += 1
            else:
                misses.append(f"{key}: missing {required} (got {sorted(given) or 'nothing'})")
        for forbidden in rule.get("forbid", []):
            total += 1
            if forbidden not in given:
                points += 1
            else:
                misses.append(f"{key}: has forbidden {forbidden}")
    return points, total, misses


def main(argv: list[str] | None = None) -> int:
    argv = sys.argv[1:] if argv is None else argv
    if len(argv) != 1:
        print(__doc__)
        return 2
    trial = Path(argv[0]).resolve()
    connector = trial / "connector"
    if not connector.is_dir():
        print(f"{trial.name}: no connector folder")
        return 1
    cert = pqkb("certification", "--path", str(connector), "--json")
    findings = next(iter(json.loads(cert.stdout).values())) if cert.returncode == 0 else []
    statuses = Counter(f["status"] for f in findings)
    profile_dir = trial / "profile"
    prof = pqkb("profile", "--path", str(connector), "--out-dir", str(profile_dir))
    profiles = sorted(profile_dir.glob("*.json"))
    answers = json.loads(profiles[0].read_text(encoding="utf-8"))["answers"] if profiles else {}
    rubric = yaml.safe_load(RUBRIC.read_text(encoding="utf-8"))
    points, total, misses = score(answers, rubric) if answers else (0, 0, ["no profile"])
    grade = {
        "trial": trial.name,
        "certification": dict(statuses),
        "certification_fails": [f["rule"] for f in findings if f["status"] == "fail"],
        "rubric_points": points,
        "rubric_total": total,
        "rubric_misses": misses,
        "profile_error": None if profiles else (prof.stdout + prof.stderr)[-1000:],
    }
    (trial / "grade.json").write_text(json.dumps(grade, indent=2) + "\n", encoding="utf-8")
    print(
        f"{trial.name}: rubric {points}/{total}, certification "
        + ", ".join(f"{k} {v}" for k, v in sorted(statuses.items()))
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
