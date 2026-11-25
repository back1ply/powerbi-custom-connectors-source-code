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
            "models": ["fake"],
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
