"""Run a tool-free Claude Haiku reviewer and cache validated source citations."""

from __future__ import annotations

import json
import shutil
import subprocess
from concurrent.futures import FIRST_COMPLETED, ThreadPoolExecutor, wait
from dataclasses import dataclass
from datetime import UTC, datetime
from pathlib import Path

from pqkb import match_reviews
from pqkb.bundle import load_patterns, read_sources, rules_for
from pqkb.refresh import load_index
from pqkb.scan import scan

SYSTEM_PROMPT = match_reviews.SYSTEM_PROMPT


def claude_executable() -> list[str]:
    executable = shutil.which("claude")
    if not executable:
        raise FileNotFoundError("Install Claude Code and sign in before reviewing candidates")
    if Path(executable).suffix.lower() == ".cmd":
        native = Path(executable).parent / "node_modules/@anthropic-ai/claude-code/bin/claude.exe"
        if not native.is_file():
            raise FileNotFoundError("Pinned Claude npm installation is incomplete")
        return [str(native)]
    return [executable]


def claude_review(packet: dict, definitions: dict, files: dict) -> tuple[list[dict], dict]:
    prompt = json.dumps({"patterns": definitions, "review": packet}, ensure_ascii=False)
    command = claude_executable() + [
        "-p",
        "--model",
        match_reviews.REQUESTED_MODEL,
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
        input=prompt,
        text=True,
        encoding="utf-8",
        capture_output=True,
        timeout=600,
        check=True,
    )
    envelope = json.loads(response.stdout)
    if envelope.get("is_error"):
        raise ValueError(f"Claude review failed: {envelope.get('subtype', 'provider error')}")
    answer = envelope.get("structured_output")
    if answer is None:
        answer = json.loads(
            envelope["result"]
            .removeprefix("```json")
            .removeprefix("```")
            .removesuffix("```")
            .strip()
        )
    usage = envelope.get("modelUsage", {})
    identity = {
        "provider": "claude-code",
        "models": sorted(usage),
        "requested_model": "haiku",
        "context": "source windows and symbol inventory",
    }
    return match_reviews.validate_assessments(answer, packet, files), identity


def review_inputs(repo: Path) -> tuple[dict, list, dict, dict]:
    patterns = load_patterns(repo / "knowledge" / "patterns")
    rules = rules_for(patterns)
    sources = read_sources(repo / "connectors", load_index(repo / "connectors"))
    hits = scan(sources, rules)
    candidates = {
        name: {pid: hit for pid, items in hits.items() for hit in items if hit.connector == name}
        for name in sources
    }
    definitions = {rule.pattern_id: rule.scope for rule in rules}
    return sources, rules, candidates, definitions


@dataclass(frozen=True)
class ReviewTask:
    name: str
    files: dict
    matches: dict
    definitions: dict
    rules: list


def review_connector(task: ReviewTask) -> tuple[str, dict]:
    packet = match_reviews.review_packet(task.name, task.files, task.matches)
    selected = {pid: task.definitions[pid] for pid in task.matches}
    assessments, identity = claude_review(packet, selected, task.files)
    record = cache_record(task.files, task.rules, assessments, identity)
    record["request_sha256"] = match_reviews.request_fingerprint(packet, selected)
    return task.name, record


def save_cache(repo: Path, cache: dict) -> None:
    path = repo / match_reviews.CACHE_FILE
    temporary = repo / "build" / "match-reviews.tmp"
    temporary.parent.mkdir(exist_ok=True)
    temporary.write_text(
        json.dumps(cache, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8"
    )
    temporary.replace(path)


def review_matches(repo: Path, workers: int = 2) -> None:
    sources, rules, candidates, definitions = review_inputs(repo)
    cache = match_reviews.load_cache(repo)
    prune_removed(repo, cache, sources)
    tasks = [
        ReviewTask(name, files, candidates[name], definitions, rules)
        for name, files in sources.items()
        if candidates[name]
    ]
    tasks = [task for task in tasks if not task_review_current(cache, task)]
    print(f"{len(tasks)} connectors need review; unchanged reviews are reused.", flush=True)
    failures = [
        name
        for name, future in completed_reviews(tasks, workers)
        if not store_result(repo, cache, name, future)
    ]
    if failures:
        raise ValueError(f"Reviews failed (completed reviews saved): {', '.join(failures)}")


def task_review_current(cache: dict, task: ReviewTask) -> bool:
    review = match_reviews.current_review(cache, task.name, task.files, task.rules)
    if not review:
        return False
    packet = match_reviews.review_packet(task.name, task.files, task.matches)
    return match_reviews.review_is_usable(review, packet, task.definitions, task.files)


def completed_reviews(tasks: list[ReviewTask], workers: int):
    queue = iter(tasks)
    with ThreadPoolExecutor(max_workers=workers) as pool:
        active = {}
        for _ in range(workers):
            submit_next(pool, queue, active)
        while active:
            completed, _ = wait(active, return_when=FIRST_COMPLETED)
            for future in completed:
                name = active.pop(future)
                yield name, future
                submit_next(pool, queue, active)


def submit_next(pool, queue, active) -> None:
    task = next(queue, None)
    if task is not None:
        active[pool.submit(review_connector, task)] = task.name


def store_result(repo: Path, cache: dict, name: str, future) -> bool:
    try:
        _, record = future.result()
    except (OSError, subprocess.SubprocessError, ValueError, KeyError, TypeError) as error:
        print(f"Review failed for {name}: {type(error).__name__}", flush=True)
        return False
    cache[name] = record
    save_cache(repo, cache)
    print(f"Reviewed {name}: {len(record['matches'])} candidates.", flush=True)
    return True


def cache_record(files: dict, rules: list, assessments: list, identity: dict) -> dict:
    return {
        "source_sha256": match_reviews.source_fingerprint(files),
        "rules_sha256": match_reviews.rule_fingerprint(rules),
        "protocol_sha256": match_reviews.protocol_fingerprint(),
        "reviewer": identity,
        "reviewed_at": datetime.now(UTC).isoformat(),
        "matches": assessments,
    }


def verify_matches(repo: Path) -> list[str]:
    sources, rules, candidates, definitions = review_inputs(repo)
    cache = match_reviews.load_cache(repo)
    problems = []
    for name, files in sources.items():
        review = match_reviews.current_review(cache, name, files, rules)
        if not candidates[name]:
            continue
        if not review:
            problems.append(f"{name}: candidate review missing or stale")
            continue
        packet = match_reviews.review_packet(name, files, candidates[name])
        try:
            match_reviews.validate_record(review, packet, definitions, files)
        except (ValueError, KeyError, TypeError) as error:
            problems.append(f"{name}: invalid candidate review: {error}")
    return problems


def prune_removed(repo: Path, cache: dict, sources: dict) -> None:
    removed = cache.keys() - sources.keys()
    if not removed:
        return
    for connector in removed:
        del cache[connector]
    save_cache(repo, cache)
