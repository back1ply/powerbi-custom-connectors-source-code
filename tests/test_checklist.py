import copy

import pytest
import yaml

from pqkb.checklist import load_checklist, validate_profile
from pqkb.cli import main

ROOT_CHECKLIST = load_checklist(__import__("pathlib").Path(__file__).resolve().parents[1])


def negative_profile() -> dict:
    """A well-formed profile: every question answered with its first negative-style answer."""
    answers = {}
    for spec in ROOT_CHECKLIST:
        first = "none" if "none" in spec["answers"] else spec["answers"][0]
        answer = {"values": [first], "evidence": [{"file": "Demo.pq", "lines": "1-2"}], "sub": {}}
        for sub in spec.get("sub", []):
            if "when" in sub and first not in sub["when"]:
                continue
            if sub.get("free_text"):
                answer["sub"][sub["id"]] = {"text": "x"}
            else:
                answer["sub"][sub["id"]] = {
                    "values": [sub["answers"][0]],
                    "evidence": [{"file": "Demo.pq", "lines": "2"}],
                }
        answers[spec["id"]] = answer
    return {"connector": "Demo", "answers": answers}


@pytest.fixture
def repo(tmp_path):
    (tmp_path / "pyproject.toml").touch()
    (tmp_path / "knowledge").mkdir()
    root = __import__("pathlib").Path(__file__).resolve().parents[1]
    (tmp_path / "knowledge" / "checklist.yaml").write_bytes(
        (root / "knowledge" / "checklist.yaml").read_bytes()
    )
    source = tmp_path / "connectors" / "Demo"
    source.mkdir(parents=True)
    (source / "Demo.pq").write_text("section Demo;\nshared Demo.Contents = 1;\n", encoding="utf-8")
    return tmp_path


def test_well_formed_profile_passes_and_yaml_booleans_count_as_yes_no(repo):
    profile = negative_profile()
    profile["answers"]["auth"] = {
        "values": ["oauth"],
        "evidence": [{"file": "Demo.pq", "lines": "2"}],
        "sub": {"oauth-pkce": {"values": [True]}, "oauth-refresh": {"values": [False]}},
    }
    profile["answers"]["auth"]["sub"]["oauth-pkce"]["evidence"] = [
        {"file": "Demo.pq", "lines": "2"}
    ]
    assert validate_profile(repo, profile) == []


@pytest.mark.parametrize(
    "mutate, expected",
    [
        (lambda a: a.pop("paging"), "Demo/paging: missing"),
        (lambda a: a["paging"].update(values=["sideways"]), "unknown answer 'sideways'"),
        (lambda a: a["diagnostics"].update(values=["none", "tracing-gated"]), "single-answer"),
        (lambda a: a["paging"].update(values=["cursor-token"], evidence=[]), "has no evidence"),
        (
            lambda a: a["paging"].update(evidence=[{"file": "Demo.pq", "lines": "1-9"}]),
            "outside Demo.pq",
        ),
        (
            lambda a: a["paging"].update(evidence=[{"file": "Nope.pq", "lines": "1"}]),
            "does not exist",
        ),
        (
            lambda a: a["auth"]["sub"].update({"oauth-pkce": {"values": ["yes"]}}),
            "condition is not met",
        ),
    ],
)
def test_malformed_answers_are_reported(repo, mutate, expected):
    profile = copy.deepcopy(negative_profile())
    mutate(profile["answers"])
    assert any(expected in problem for problem in validate_profile(repo, profile))


def test_check_profiles_command(repo, capsys):
    folder = repo / "evals" / "gold"
    folder.mkdir(parents=True)
    (folder / "Demo.yaml").write_text(yaml.safe_dump(negative_profile()), encoding="utf-8")
    assert main(["--repo", str(repo), "check-profiles"]) == 0
    assert "1 profiles checked: 0 problems." in capsys.readouterr().out
    (folder / "Other.yaml").write_text(yaml.safe_dump(negative_profile()), encoding="utf-8")
    assert main(["--repo", str(repo), "check-profiles"]) == 1
