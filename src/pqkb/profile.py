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

from pqkb.checklist import answer_ids, load_checklist, validate_profile
from pqkb.functions import index_connector
from pqkb.match_agent import claude_executable
from pqkb.match_reviews import source_fingerprint
from pqkb.refresh import load_index
from pqkb.reviews import digest

PROFILE_DIR = Path("knowledge") / "profiles"
PROMPT_VERSION = 2
SYSTEM_PROMPT = """You profile one Power Query (M) connector against a fixed checklist.
Input JSON has: checklist (questions with allowed answer ids, `multi`, conditional
`sub` questions with `when`, `free_text` follow-ups, and `definitions` that say what
an answer id means and which Microsoft Learn page it follows), functions (top-level
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
- When a question has `definitions`, an answer id applies only if the code meets its
  definition. Do not add an id because the code is merely related to it.
- "values" is always a JSON list, even for a single answer.
- "other" only when no id fits; explain it in the evidence note.
- If the input has "validation_problems", your earlier "previous_answers" failed the
  checks listed there. Return the full corrected object, changing only what the
  problems require."""


def profile_inputs(
    repo: Path, name: str, files: dict[str, str] | None = None
) -> tuple[dict, dict[str, str]]:
    """Model input for one connector; `files` overrides the archive lookup."""
    from pqkb.bundle import read_sources

    if files is None:
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
    identity = {
        "provider": "claude-code",
        "requested_model": model,
        "models": sorted(envelope.get("modelUsage", {})),
        "cost_usd": envelope.get("total_cost_usd"),
        "duration_ms": envelope.get("duration_ms"),
    }
    return first_json_object(envelope["result"]), identity


def first_json_object(text: str) -> dict:
    """The first JSON object in the reply; code fences and trailing prose are ignored."""
    start = text.find("{")
    if start < 0:
        raise ValueError("model reply contains no JSON object")
    value, _ = json.JSONDecoder().raw_decode(text, start)
    return value


def normalize_answers(answers: dict) -> dict:
    """Wrap bare-string `values` in a list, at both question and sub-question level."""
    for answer in answers.values():
        if not isinstance(answer, dict):
            continue
        for item in [answer, *(answer.get("sub") or {}).values()]:
            if isinstance(item, dict) and "values" in item:
                item["values"] = answer_ids(item["values"])
    return answers


def _merge_identity(first: dict, second: dict) -> dict:
    """Sum cost and duration over the first call and its repair call."""
    merged = {**second, "repair_attempts": 1}
    for key in ("cost_usd", "duration_ms"):
        if first.get(key) is not None or second.get(key) is not None:
            merged[key] = (first.get(key) or 0) + (second.get(key) or 0)
    merged["models"] = sorted(set(first.get("models", [])) | set(second.get("models", [])))
    return merged


def other_models(requested: str, used: list[str]) -> list[str]:
    """Models in the reply that are not the requested one (alias 'haiku' or a full id).

    Claude Code sometimes hands part of a request to a different model; such a profile
    would be scored as the requested model's work, so it is rejected instead.
    """
    return [m for m in used if requested.lower() not in m.lower()]


def profile_connector(repo: Path, name: str, model: str, source_dir: Path | None = None) -> dict:
    """Ask the model once; on validation problems, send them back for one repair.

    `source_dir` profiles a connector folder outside the archive.
    """
    files = None
    if source_dir is not None:
        from pqkb.cli import folder_sources

        name, files = folder_sources(source_dir)
    payload, files = profile_inputs(repo, name, files)
    answer, identity = ask_claude(payload, model)
    profile = {"connector": name, "answers": normalize_answers(answer.get("answers", {}))}
    problems = validate_profile(repo, profile, payload["checklist"], source_dir)
    if problems:
        repair = {
            **payload,
            "previous_answers": profile["answers"],
            "validation_problems": problems,
        }
        answer, second = ask_claude(repair, model)
        identity = _merge_identity(identity, second)
        profile = {"connector": name, "answers": normalize_answers(answer.get("answers", {}))}
        problems = validate_profile(repo, profile, payload["checklist"], source_dir)
    if problems:
        raise ValueError(
            f"{len(problems)} validation problems after one repair, first: {problems[0]}"
        )
    others = other_models(model, identity.get("models", []))
    if others:
        raise ValueError(
            f"answered partly by {', '.join(others)}, not {model}; not saved"
            f" (cost ${identity.get('cost_usd') or 0:.2f})"
        )
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
