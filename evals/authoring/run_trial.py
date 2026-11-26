"""Run one authoring trial: an agent writes a connector for spec.md.

Usage: uv run python evals/authoring/run_trial.py --condition repo|baseline --trial-dir DIR

`repo` gives the agent read access to this repository and its pqkb tools; `baseline`
gives it only the spec. Both run the same model with the same tools otherwise, no web
access, and a spending cap. Writes DIR/spec.md, DIR/connector/ (the agent's work) and
DIR/run.json, and prints one summary line.
"""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
SPEC = Path(__file__).with_name("spec.md")
BASE_PROMPT = "Read spec.md in the current folder and do the task it describes."
REPO_PROMPT = (
    " A reference repository about Power Query connectors is at {repo}: start with its"
    " AGENTS.md. You can run its tools with `uv run --project {repo} pqkb <command>`."
)


def command(condition: str, model: str, budget: float) -> list[str]:
    tools = ["Read", "Write", "Edit", "Glob", "Grep"]
    args = [
        "claude", "-p", "--model", model,
        "--permission-mode", "acceptEdits",
        "--disallowedTools", "WebSearch", "WebFetch",
        "--strict-mcp-config", "--mcp-config", '{"mcpServers":{}}',
        "--no-session-persistence", "--output-format", "json",
        "--max-budget-usd", str(budget),
    ]  # fmt: skip
    if condition == "repo":
        tools.append(f"Bash(uv run --project {REPO}:*)")
        args += ["--add-dir", str(REPO)]
    return args + ["--allowedTools", *tools]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description="Run one authoring trial.")
    parser.add_argument("--condition", choices=["repo", "baseline"], required=True)
    parser.add_argument("--trial-dir", type=Path, required=True)
    parser.add_argument("--model", default="sonnet")
    parser.add_argument("--budget", type=float, default=4.0, help="USD cap for the agent")
    args = parser.parse_args(argv)

    trial = args.trial_dir.resolve()
    if trial.exists() and any(trial.iterdir()):
        print(f"{trial} is not empty; use a new trial folder.")
        return 2
    trial.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(SPEC, trial / "spec.md")
    prompt = BASE_PROMPT + (REPO_PROMPT.format(repo=REPO) if args.condition == "repo" else "")
    result = subprocess.run(
        command(args.condition, args.model, args.budget),
        input=prompt,
        text=True,
        encoding="utf-8",
        capture_output=True,
        cwd=trial,
        timeout=3600,
    )
    try:
        envelope = json.loads(result.stdout)
    except json.JSONDecodeError:
        envelope = {
            "is_error": True,
            "result": result.stdout[-2000:],
            "stderr": result.stderr[-2000:],
        }
    record = {
        "condition": args.condition,
        "model": args.model,
        "prompt": prompt,
        "cost_usd": envelope.get("total_cost_usd"),
        "duration_ms": envelope.get("duration_ms"),
        "num_turns": envelope.get("num_turns"),
        "is_error": envelope.get("is_error"),
        "models": sorted(envelope.get("modelUsage", {})),
        "result": envelope.get("result"),
    }
    (trial / "run.json").write_text(json.dumps(record, indent=2) + "\n", encoding="utf-8")
    out = trial / "connector"
    files = sorted(p.name for p in out.glob("*")) if out.is_dir() else []
    print(
        f"{trial.name}: {args.condition}, ${record['cost_usd'] or 0:.2f}, "
        f"{record['num_turns']} turns, files: {', '.join(files) or 'none'}"
    )
    return 0 if files and not record["is_error"] else 1


if __name__ == "__main__":
    sys.exit(main())
