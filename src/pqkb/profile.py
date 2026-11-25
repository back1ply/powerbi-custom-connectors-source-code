"""Answer the per-connector checklist with an LLM and store source-bound profiles.

The model receives the checklist, the connector's function index, and every source
file with line numbers. Its answers must pass `checklist.validate_profile`, which
checks answer ids, conditional sub-questions, and cited line ranges. Profiles are
cached in `knowledge/profiles/<Name>.json` by source, checklist, and prompt
fingerprints, so unchanged connectors are not asked again.
"""

from __future__ import annotations

import json
import subprocess
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import asdict
from datetime import UTC, datetime
from pathlib import Path

from pqkb.checklist import load_checklist, validate_profile
from pqkb.functions import index_connector
from pqkb.match_agent import claude_executable
from pqkb.match_reviews import source_fingerprint
from pqkb.refresh import load_index
from pqkb.reviews import digest

PROFILE_DIR = Path("knowledge") / "profiles"
PROMPT_VERSION = 1
SYSTEM_PROMPT = """You profile one Power Query (M) connector against a fixed checklist.
Input JSON has: checklist (questions with allowed answer ids, `multi`, conditional
`sub` questions with `when`, and `free_text` follow-ups), functions (top-level
functions with file, line range, and calls), and files (every source file with
1-based line numbers as "<n>| <code>").

Return ONLY a JSON object: {"answers": {<question id>: <answer>, ...}} covering every
top-level question in checklist order. An answer is
{"values": [answer ids], "evidence": [{"file", "lines": "start-end", "function", "note"}],
 "sub": {<sub id>: <answer>}}. A free-text sub-question uses {"text": "...", "evidence": [...]}.

Rules:
- Use only the listed answer ids; several values only when multi is true. Use
  "not-applicable" only when a question's applies_when excludes this connector.
- Answer a sub-question only when one of its `when` answers was given; sub-questions
  without `when` are always answered.
- Count only code that is wired and reachable from the shared entry functions, the
  data source kind record, or Publish. Ignore helpers that are never called.
- Every value other than none/no/default/not-defined needs evidence with the exact
  file and line range from the numbered source.
- "other" only when no id fits; explain it in the evidence note."""


def profile_inputs(repo: Path, name: str) -> tuple[dict, dict[str, str]]:
    from pqkb.bundle import read_sources

    records = load_index(repo / "connectors")
    files = read_sources(repo / "connectors", {name: records[name]})[name]
    numbered = {
        file: "\n".join(f"{n}| {line}" for n, line in enumerate(text.splitlines(), start=1))
        for file, text in files.items()
    }
    functions = [
        {k: v for k, v in asdict(f).items() if k != "connector"}
        for f in index_connector(name, files)
    ]
    payload = {
        "connector": name,
        "checklist": load_checklist(repo),
        "functions": functions,
        "files": numbered,
    }
    return payload, files


def fingerprints(repo: Path, files: dict[str, str]) -> dict:
    checklist = (repo / "knowledge" / "checklist.yaml").read_bytes()
    return {
        "source_sha256": source_fingerprint(files),
        "checklist_sha256": digest(checklist),
        "prompt_sha256": digest(f"{PROMPT_VERSION}\n{SYSTEM_PROMPT}".encode()),
    }


def ask_claude(payload: dict, model: str) -> tuple[dict, dict]:
    command = claude_executable() + [
        "-p",
        "--model",
        model,
        "--tools",
        "",
        "--strict-mcp-config",
        "--mcp-config",
        '{"mcpServers":{}}',
        "--no-session-persistence",
        "--output-format",
        "json",
        "--system-prompt",
        SYSTEM_PROMPT,
    ]
    response = subprocess.run(
        command,
        input=json.dumps(payload, ensure_ascii=False),
        text=True,
        encoding="utf-8",
        capture_output=True,
        timeout=900,
        check=True,
    )
    envelope = json.loads(response.stdout)
    if envelope.get("is_error"):
        raise ValueError(f"Claude profile failed: {envelope.get('subtype', 'provider error')}")
    text = (
        envelope["result"].strip().removeprefix("```json").removeprefix("```").removesuffix("```")
    )
    identity = {
        "provider": "claude-code",
        "requested_model": model,
        "models": sorted(envelope.get("modelUsage", {})),
        "cost_usd": envelope.get("total_cost_usd"),
        "duration_ms": envelope.get("duration_ms"),
    }
    return json.loads(text.strip()), identity


def profile_connector(repo: Path, name: str, model: str) -> dict:
    payload, files = profile_inputs(repo, name)
    answer, identity = ask_claude(payload, model)
    profile = {"connector": name, "answers": answer.get("answers", {})}
    problems = validate_profile(repo, profile, payload["checklist"])
    if problems:
        raise ValueError(f"{len(problems)} validation problems, first: {problems[0]}")
    return {
        **profile,
        "generated": {
            "by": identity["requested_model"],
            "at": datetime.now(UTC).strftime("%Y-%m-%dT%H:%M:%SZ"),
        },
        "reviewer": identity,
        **fingerprints(repo, files),
    }


def is_current(repo: Path, name: str, out_dir: Path) -> bool:
    path = out_dir / f"{name}.json"
    if not path.is_file():
        return False
    from pqkb.bundle import read_sources

    records = load_index(repo / "connectors")
    files = read_sources(repo / "connectors", {name: records[name]})[name]
    stored = json.loads(path.read_text(encoding="utf-8"))
    return all(stored.get(k) == v for k, v in fingerprints(repo, files).items())


def run_profiles(
    repo: Path,
    names: list[str],
    model: str = "haiku",
    out_dir: Path | None = None,
    force: bool = False,
    workers: int = 2,
) -> list[str]:
    """Profile the named connectors; returns failures as 'Name: reason'."""
    out_dir = out_dir or repo / PROFILE_DIR
    out_dir.mkdir(parents=True, exist_ok=True)
    todo = [n for n in names if force or not is_current(repo, n, out_dir)]
    print(f"{len(todo)} of {len(names)} connectors need a profile.", flush=True)
    failures = []
    with ThreadPoolExecutor(max_workers=workers) as pool:
        futures = {pool.submit(profile_connector, repo, n, model): n for n in todo}
        for future in as_completed(futures):
            name = futures[future]
            try:
                profile = future.result()
            except (OSError, subprocess.SubprocessError, ValueError, KeyError, TypeError) as error:
                failures.append(f"{name}: {error}")
                print(f"Profile failed for {name}: {error}", flush=True)
                continue
            (out_dir / f"{name}.json").write_text(
                json.dumps(profile, indent=2, ensure_ascii=False) + "\n",
                encoding="utf-8",
                newline="\n",
            )
            cost = profile["reviewer"].get("cost_usd")
            print(f"Profiled {name}" + (f" (${cost:.4f})" if cost else ""), flush=True)
    return failures
