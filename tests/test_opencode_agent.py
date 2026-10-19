import json
import subprocess

import pytest

from pqkb import match_reviews
from pqkb.match_agent import cache_record
from pqkb.opencode_agent import opencode_review
from pqkb.scan import Rule, scan


def process_stub(events, model, packet, failure):
    version = "wrong" if failure == "version" else match_reviews.OPENCODE_VERSION
    provider, identifier = model.split("/", 1) if "/" in model else ("other", model)
    transcript = json.dumps(
        {
            "messages": [
                {
                    "type": "assistant",
                    "model": {
                        "providerID": provider,
                        "id": identifier,
                    },
                }
            ]
        }
    )
    responses = iter(
        [
            "opencode v" + version,
            "\n".join(json.dumps(event) for event in events),
            transcript,
        ]
    )

    def run(command, **kwargs):
        config = json.loads(kwargs["env"]["OPENCODE_CONFIG_CONTENT"])
        assert config["permission"] == {"*": "deny"}
        assert not any(config["agent"]["pqkb-reviewer"]["tools"].values())
        assert config["mcp"] == {}
        assert str(kwargs["cwd"]) in kwargs["env"]["XDG_CONFIG_HOME"]
        if command[1] == "run":
            assert json.loads(kwargs["input"])["review"] == packet
            assert "--standalone" in command
        return subprocess.CompletedProcess(command, 0, next(responses), "")

    return run


@pytest.mark.parametrize("failure", [None, "quote", "model", "tool", "session", "version"])
def test_opencode_review_binds_source_and_reported_model_with_tools_denied(monkeypatch, failure):
    files = {"Demo.pq": "shared Demo.Contents = () => OData.Feed(url);"}
    rule = Rule.build("odata", [])
    hit = scan({"Demo": files}, [rule])["odata"][0]
    packet = match_reviews.review_packet("Demo", files, {"odata": hit})
    decision = {
        "pattern_id": "odata",
        "verdict": "supported",
        "confidence": "high",
        "reason": "Exported function invokes the feed.",
        "evidence": [{"file": "Demo.pq", "line": 1, "quote": "OData.Feed(url)"}],
    }
    if failure == "quote":
        decision["evidence"][0]["quote"] = "invented call"
    events = [
        {"type": "step_start", "sessionID": "review-session"},
        {"type": "text", "part": {"text": json.dumps({"matches": [decision]})}},
    ]
    if failure == "tool":
        events.append({"type": "tool_use"})
    if failure == "session":
        events.pop(0)
    model = "unexpected-model" if failure == "model" else match_reviews.OPENCODE_MODEL

    monkeypatch.setattr("pqkb.opencode_agent.shutil.which", lambda _: "opencode")
    monkeypatch.setattr(
        "pqkb.opencode_agent.subprocess.run", process_stub(events, model, packet, failure)
    )
    if failure:
        with pytest.raises(ValueError):
            opencode_review(packet, {}, files)
    else:
        matches, identity = opencode_review(packet, {}, files)
        assert matches == [decision]
        assert identity["provider"] == "opencode"
        assert identity["models"] == [match_reviews.OPENCODE_MODEL]


@pytest.mark.parametrize("provider", ["claude-code", "opencode"])
def test_review_protocol_is_bound_to_its_actual_provider(provider):
    files = {"Demo.pq": "shared Demo.Contents = () => OData.Feed(url);"}
    rules = [Rule.build("odata", [])]
    record = cache_record(files, rules, [], {"provider": provider, "models": ["reviewer"]})
    assert match_reviews.current_review({"Demo": record}, "Demo", files, rules) == record
    record["reviewer"]["provider"] = "opencode" if provider == "claude-code" else "claude-code"
    assert not match_reviews.current_review({"Demo": record}, "Demo", files, rules)
