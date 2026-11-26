import json

import yaml

from pqkb import profile as profile_module
from pqkb.cli import main
from pqkb.evaluate import evaluate
from pqkb.refresh import ConnectorRecord, write_index
from test_checklist import negative_profile, repo  # noqa: F401  (shared fixture)


def with_index(root):
    write_index(
        root / "connectors", [ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"])]
    )
    return root


def test_profile_validates_caches_and_reruns_only_when_inputs_change(repo, monkeypatch, capsys):  # noqa: F811
    with_index(repo)
    calls = []

    def fake(payload, model):
        calls.append(payload)
        assert payload["files"]["Demo.pq"].startswith("1| section Demo;")
        assert payload["functions"][0]["name"] == "Demo.Contents"
        return {"answers": negative_profile()["answers"]}, {
            "requested_model": model,
            "models": ["claude-haiku-fake"],
        }

    monkeypatch.setattr(profile_module, "ask_claude", fake)
    assert main(["--repo", str(repo), "profile", "Demo"]) == 0
    stored = json.loads((repo / "knowledge/profiles/Demo.json").read_text(encoding="utf-8"))
    assert stored["generated"]["by"] == "haiku" and stored["source_sha256"]
    assert main(["--repo", str(repo), "profile", "Demo"]) == 0
    assert len(calls) == 1  # Cached: same source, checklist, and prompt.
    (repo / "connectors/Demo/Demo.pq").write_text(
        "section Demo;\nshared Demo.Contents = 2;\n", encoding="utf-8"
    )
    assert main(["--repo", str(repo), "profile", "Demo"]) == 0
    assert len(calls) == 2


def test_invalid_model_answers_are_reported_and_not_saved(repo, monkeypatch):  # noqa: F811
    with_index(repo)
    monkeypatch.setattr(
        profile_module,
        "ask_claude",
        lambda payload, model: ({"answers": {}}, {"requested_model": model}),
    )
    assert main(["--repo", str(repo), "profile", "Demo"]) == 1
    assert not (repo / "knowledge/profiles/Demo.json").exists()


def test_eval_scores_sets_per_question_and_reports_missing(repo, capsys):  # noqa: F811
    gold = repo / "evals/gold"
    gold.mkdir(parents=True)
    truth = negative_profile()
    truth["answers"]["paging"]["values"] = ["offset-limit", "cursor-token"]
    truth["answers"]["paging"]["sub"] = {"paging-generator": {"values": ["list-generate"]}}
    (gold / "Demo.yaml").write_text(yaml.safe_dump(truth), encoding="utf-8")
    (gold / "Other.yaml").write_text(
        yaml.safe_dump({**truth, "connector": "Other"}), encoding="utf-8"
    )
    predicted = negative_profile()
    predicted["answers"]["paging"]["values"] = ["offset-limit", "next-link-url"]
    predicted["answers"]["paging"]["sub"] = {"paging-generator": {"values": ["list-generate"]}}
    profiles = repo / "knowledge/profiles"
    profiles.mkdir(parents=True)
    (profiles / "Demo.json").write_text(json.dumps(predicted), encoding="utf-8")
    result = evaluate(repo, gold, profiles)
    paging = result["per_question"]["paging"]
    assert (paging["precision"], paging["recall"], paging["exact"]) == (0.5, 0.5, 0.0)
    assert result["per_question"]["paging/paging-generator"]["exact"] == 1.0
    assert result["missing"] == ["Other"]
    assert result["mistakes"] == [
        {
            "connector": "Demo",
            "question": "paging",
            "expected": ["cursor-token", "offset-limit"],
            "got": ["next-link-url", "offset-limit"],
        }
    ]
    assert main(["--repo", str(repo), "eval", "--save", "evals/results/test.json"]) == 0
    assert "OVERALL" in capsys.readouterr().out
    assert (repo / "evals/results/test.json").is_file()


def test_bare_string_values_are_read_as_one_answer_and_stored_as_lists(repo, monkeypatch):  # noqa: F811
    with_index(repo)
    answers = negative_profile()["answers"]
    answers["diagnostics"]["values"] = "tracing-always"  # LakeHouse-style bare string.
    monkeypatch.setattr(
        profile_module,
        "ask_claude",
        lambda payload, model: ({"answers": answers}, {"requested_model": model}),
    )
    assert main(["--repo", str(repo), "profile", "Demo"]) == 0
    stored = json.loads((repo / "knowledge/profiles/Demo.json").read_text(encoding="utf-8"))
    assert stored["answers"]["diagnostics"]["values"] == ["tracing-always"]


def test_validation_problems_get_one_repair_and_costs_are_summed(repo, monkeypatch):  # noqa: F811
    with_index(repo)
    good = negative_profile()["answers"]
    broken = {k: v for k, v in good.items() if k != "writes"}
    replies = iter(
        [
            ({"answers": broken}, {"requested_model": "haiku", "cost_usd": 0.25}),
            ({"answers": good}, {"requested_model": "haiku", "cost_usd": 0.5}),
        ]
    )
    sent = []

    def fake(payload, model):
        sent.append(payload)
        return next(replies)

    monkeypatch.setattr(profile_module, "ask_claude", fake)
    assert main(["--repo", str(repo), "profile", "Demo"]) == 0
    assert "validation_problems" not in sent[0]
    assert any("writes: missing" in p for p in sent[1]["validation_problems"])
    stored = json.loads((repo / "knowledge/profiles/Demo.json").read_text(encoding="utf-8"))
    assert stored["reviewer"]["cost_usd"] == 0.75
    assert stored["reviewer"]["repair_attempts"] == 1


def test_first_json_object_ignores_fences_and_trailing_text():
    reply = '```json\n{"answers": {"a": {"values": ["x"]}}}\n```\nNote: {"stray": 1}'
    assert profile_module.first_json_object(reply) == {"answers": {"a": {"values": ["x"]}}}


def test_profiles_answered_partly_by_another_model_are_not_saved(repo, monkeypatch, capsys):  # noqa: F811
    with_index(repo)
    identity = {"requested_model": "haiku", "models": ["claude-haiku-5-5", "claude-opus-5-5"]}
    monkeypatch.setattr(
        profile_module,
        "ask_claude",
        lambda payload, model: ({"answers": negative_profile()["answers"]}, identity),
    )
    assert main(["--repo", str(repo), "profile", "Demo"]) == 1
    assert "answered partly by claude-opus-5-5" in capsys.readouterr().out
    assert not (repo / "knowledge/profiles/Demo.json").exists()
