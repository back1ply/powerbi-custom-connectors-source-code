"""Run an isolated, tool-free DeepSeek reviewer through OpenCode."""

import json
import os
import shutil
import subprocess
from pathlib import Path
from tempfile import TemporaryDirectory

from pqkb import match_reviews


def reviewer_environment(folder: Path) -> dict[str, str]:
    env = os.environ.copy()
    for label in ("CONFIG", "DATA", "STATE", "CACHE"):
        target = folder / label.lower()
        target.mkdir()
        env[f"XDG_{label}_HOME"] = str(target)
    for key in ("OPENCODE_CONFIG", "OPENCODE_CONFIG_DIR"):
        env.pop(key, None)
    for suffix in ("DEFAULT_PLUGINS", "AUTOUPDATE", "CLAUDE_CODE"):
        env[f"OPENCODE_DISABLE_{suffix}"] = "true"
    agent = {
        "description": "Source-bound candidate reviewer",
        "mode": "primary",
        "prompt": match_reviews.SYSTEM_PROMPT,
        "tools": dict.fromkeys(match_reviews.OPENCODE_TOOLS, False),
        "permission": {"*": "deny"},
    }
    env["OPENCODE_CONFIG_CONTENT"] = json.dumps(
        {
            "autoupdate": False,
            "permission": {"*": "deny"},
            "mcp": {},
            "provider": {
                "openrouter": {
                    "models": {
                        match_reviews.OPENCODE_MODEL.removeprefix("openrouter/"): {
                            "name": "DeepSeek Flash"
                        }
                    }
                }
            },
            "agent": {"pqkb-reviewer": agent},
        }
    )
    return env


def run_cli(command: list[str], folder: Path, env: dict, prompt: str = "") -> str:
    return subprocess.run(
        command,
        input=prompt,
        cwd=folder,
        env=env,
        text=True,
        encoding="utf-8",
        capture_output=True,
        timeout=600,
        check=True,
    ).stdout


def review_events(output: str) -> list[dict]:
    events = [json.loads(line) for line in output.splitlines() if line.strip()]
    if any(event["type"] in ("error", "tool_use") for event in events):
        raise ValueError("OpenCode review failed or attempted to use a tool")
    return events


def parse_output(output: str) -> tuple[dict, str]:
    events = review_events(output)
    session = next((event["sessionID"] for event in events if "sessionID" in event), None)
    if not session:
        raise ValueError("OpenCode output has no session identity")
    content = "".join(event["part"]["text"] for event in events if event["type"] == "text")
    answer = json.loads(
        content.strip().removeprefix("```json").removeprefix("```").removesuffix("```").strip()
    )
    return answer, session


def reviewer_identity(transcript: str) -> dict:
    messages = json.loads(transcript)["messages"]
    models = {
        message["model"]["providerID"] + "/" + message["model"]["id"]
        for message in messages
        if message["type"] == "assistant"
    }
    if models != {match_reviews.OPENCODE_MODEL}:
        raise ValueError("OpenCode transcript does not confirm the requested reviewer model")
    return {
        "provider": "opencode",
        "models": sorted(models),
        "requested_model": match_reviews.OPENCODE_MODEL,
        "cli_version": match_reviews.OPENCODE_VERSION,
        "context": "source windows and symbol inventory; isolated profile; tools denied",
    }


def opencode_review(packet: dict, definitions: dict, files: dict) -> tuple[list[dict], dict]:
    executable = shutil.which("opencode")
    if not executable:
        raise FileNotFoundError("Install OpenCode and configure OpenRouter before reviewing")
    prompt = json.dumps({"patterns": definitions, "review": packet}, ensure_ascii=False)
    with TemporaryDirectory(prefix="pqkb-opencode-") as temporary:
        folder = Path(temporary)
        env = reviewer_environment(folder)
        version = run_cli([executable, "--version"], folder, env).strip()
        if version != f"opencode v{match_reviews.OPENCODE_VERSION}":
            raise ValueError(f"OpenCode {match_reviews.OPENCODE_VERSION} is required")
        output = run_cli(
            [
                executable,
                "run",
                "--standalone",
                "--agent",
                "pqkb-reviewer",
                "--model",
                match_reviews.OPENCODE_MODEL,
                "--format",
                "json",
            ],
            folder,
            env,
            prompt,
        )
        answer, session = parse_output(output)
        transcript = run_cli(
            [executable, "session", "export", "--standalone", "--sanitize", session],
            folder,
            env,
        )
        identity = reviewer_identity(transcript)
    return match_reviews.validate_assessments(answer, packet, files), identity
