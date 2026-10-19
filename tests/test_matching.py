from dataclasses import replace
from pathlib import Path

import pytest

from pqkb import bundle, frontmatter, match_reviews
from pqkb.match_agent import cache_record, save_cache, verify_matches
from pqkb.scan import Rule, auth_kinds, scan

pytest_plugins = ("test_pipeline",)


@pytest.mark.parametrize(
    "decoy",
    [
        "// Value.NativeQuery(connection, sql)",
        'message = "Value.NativeQuery(connection, sql)";',
        'message = "escaped ""Value.NativeQuery(connection, sql)"" text";',
    ],
)
def test_non_code_mentions_are_ignored_without_shifting_real_line(decoy):
    text = decoy + "\n/* multi\nline */\nresult = Value.NativeQuery\n(connection, sql);"
    hits = scan({"Demo": {"Demo.pq": text}}, [Rule.build("native-query", [])])
    assert [h.line for h in hits["native-query"]] == [4]
    assert hits["native-query"][0].evidence[0].code == "result = Value.NativeQuery"


def test_comment_markers_inside_comments_and_quoted_auth_identifiers():
    source = """/* " */ x = 1; /* // */
Authentication = [#"OAuth" = [StartLogin = Login], #"Key" = []];"""
    assert auth_kinds(source) == {"OAuth", "Key"}


def test_m_block_comments_end_at_the_first_closing_delimiter():
    source = "/* outer /* inner */ result = Value.NativeQuery(connection, sql);"
    hits = scan({"Demo": {"Demo.pq": source}}, [Rule.build("native-query", [])])
    assert len(hits["native-query"]) == 1


def test_unregistered_refresh_and_helper_declarations_are_not_usage():
    source = "Refresh = () => 1;\nTable.GenerateByPage = (next) => null;"
    hits = scan(
        {"Demo": {"Demo.pq": source}},
        [
            Rule.build("oauth2", []),
            Rule.build("pagination", []),
        ],
    )
    assert hits == {"oauth2": [], "pagination": []}


def test_oauth_requires_corroboration_but_keeps_partial_candidates_explicit():
    files = {
        "Main.pq": "Authentication = [OAuth = [StartLogin = Login, FinishLogin = Finish]];",
        "Token.pqm": "Token = () => Web.Contents(url, [Content = [grant_type = grant]]);",
    }
    rule = Rule.build("oauth2", [])
    complete = scan({"Demo": files}, [rule])["oauth2"][0]
    assert complete.confidence == "corroborated"
    assert {e.file for e in complete.evidence} == {"Main.pq", "Token.pqm"}
    assert complete.verdict == "pending"  # Co-occurrence is not an agent review.
    partial = scan({"Demo": {"Main.pq": files["Main.pq"]}}, [rule])["oauth2"][0]
    assert partial.confidence == "partial"


def test_stale_source_or_rule_review_is_not_reused():
    files = {"Demo.pq": "result = OData.Feed(url);"}
    rules = [Rule.build("odata", [])]
    record = cache_record(files, rules, [], {"provider": "test", "models": ["test-agent"]})
    cache = {"Demo": record}
    assert match_reviews.current_review(cache, "Demo", files, rules) == record
    assert not match_reviews.current_review(cache, "Demo", {"Demo.pq": "changed"}, rules)
    assert not match_reviews.current_review(
        cache, "Demo", files, [replace(rules[0], scope_sha256="changed")]
    )


@pytest.mark.parametrize(
    "failure", ["missing", "duplicate", "bad-line", "bad-quote", "bad-quote-type", "no-evidence"]
)
def test_agent_output_cannot_skip_candidates_or_invent_evidence(failure):
    files = {"Demo.pq": "result = OData.Feed(url);"}
    hit = scan({"Demo": files}, [Rule.build("odata", [])])["odata"][0]
    packet = match_reviews.review_packet("Demo", files, {"odata": hit})
    assessment = {
        "pattern_id": "odata",
        "verdict": "supported",
        "confidence": "high",
        "reason": "Direct feed call.",
        "evidence": [{"file": "Demo.pq", "line": 1, "quote": "OData.Feed(url)"}],
    }
    matches = [assessment]
    if failure == "missing":
        matches = []
    elif failure == "duplicate":
        matches *= 2
    elif failure == "bad-line":
        assessment["evidence"][0]["line"] = 99
    elif failure == "bad-quote":
        assessment["evidence"][0]["quote"] = "invented call"
    elif failure == "bad-quote-type":
        assessment["evidence"][0]["quote"] = None
    elif failure == "no-evidence":
        assessment["evidence"] = []
    with pytest.raises(ValueError):
        match_reviews.validate_assessments({"matches": matches}, packet)


def test_supported_uncertain_rejected_and_stale_reviews_render_differently(repo):
    # The fixture's retry call supplies real source and a generated connector page.
    from pqkb.match_agent import review_inputs

    sources, rules, candidates, definitions = review_inputs(repo)
    hit = candidates["Demo"]["retries"]
    evidence = hit.evidence[0]
    decision = {
        "pattern_id": "retries",
        "verdict": "supported",
        "confidence": "medium",
        "reason": "A delayed producer is present.",
        "evidence": [{"file": evidence.file, "line": evidence.line, "quote": evidence.code}],
    }
    cache = {
        "Demo": cache_record(
            sources["Demo"], rules, [decision], {"provider": "test", "models": ["test-agent"]}
        )
    }
    packet = match_reviews.review_packet("Demo", sources["Demo"], candidates["Demo"])
    cache["Demo"]["request_sha256"] = match_reviews.request_fingerprint(packet, definitions)
    save_cache(repo, cache)
    assert verify_matches(repo) == []
    bundle.build(repo)
    page = repo / "build/knowledge/connectors/Demo.md"
    assert "retries" in frontmatter.read(page).meta["tags"]
    assert "Agent-supported" in frontmatter.read(page).body
    decision["verdict"] = "uncertain"
    save_cache(repo, cache)
    bundle.build(repo)
    assert "Uncertain" in frontmatter.read(page).body
    assert "retries" not in frontmatter.read(page).meta["tags"]
    decision["verdict"] = "rejected"
    save_cache(repo, cache)
    bundle.build(repo)
    assert "../patterns/retries.md" not in frontmatter.read(page).body
    source = repo / "connectors/Demo/Demo.pq"
    source.write_text(source.read_text() + "\n// source changed\n")
    bundle.build(repo)
    assert "Awaiting review" in frontmatter.read(page).body
    assert verify_matches(repo) == ["Demo: candidate review missing or stale"]


def test_all_documented_patterns_have_candidates_in_their_cited_connector():
    from pqkb.match_agent import review_inputs
    from pqkb.provenance import source_path

    root = Path(__file__).resolve().parents[1]
    _, _, candidates, _ = review_inputs(root)
    for pattern in bundle.load_patterns(root / "knowledge/patterns"):
        citation = next(s for s in pattern.doc.meta["sources"] if s["id"] == "example")
        connector = (
            source_path(root, citation["resource"]).relative_to(root / "connectors").parts[0]
        )
        assert pattern.pattern_id in candidates[connector], pattern.pattern_id


def test_supported_review_cannot_cite_only_unrelated_visible_code():
    files = {"Demo.pq": "shared Main = OData.Feed(url);\nunrelated = 42;"}
    hit = scan({"Demo": files}, [Rule.build("odata", [])])["odata"][0]
    packet = match_reviews.review_packet("Demo", files, {"odata": hit})
    decision = {
        "pattern_id": "odata",
        "verdict": "supported",
        "confidence": "high",
        "reason": "Incorrectly cited evidence.",
        "evidence": [{"file": "Demo.pq", "line": 2, "quote": "unrelated = 42;"}],
    }
    with pytest.raises(ValueError, match="observed signal"):
        match_reviews.validate_assessments({"matches": [decision]}, packet)


@pytest.mark.parametrize(
    "middle",
    [
        "/*\nresult = OData.Feed(unused);\n*/",
        "result = OData.Feed(actual);",
    ],
)
def test_later_review_citations_are_checked_against_full_lexical_context(middle):
    text = "unused = OData.Feed(first);\n" + middle
    files = {"Demo.pq": text}
    hit = scan({"Demo": files}, [Rule.build("odata", [])])["odata"][0]
    packet = match_reviews.review_packet("Demo", files, {"odata": hit})
    line = 3 if middle.startswith("/*") else 2
    quote = text.split("\n")[line - 1]
    decision = {
        "pattern_id": "odata",
        "verdict": "supported",
        "confidence": "medium",
        "reason": "Candidate citation.",
        "evidence": [{"file": "Demo.pq", "line": line, "quote": quote}],
    }
    if middle.startswith("/*"):
        with pytest.raises(ValueError, match="observed signal"):
            match_reviews.validate_assessments({"matches": [decision]}, packet, files)
    else:
        assert match_reviews.validate_assessments({"matches": [decision]}, packet, files) == [
            decision
        ]
