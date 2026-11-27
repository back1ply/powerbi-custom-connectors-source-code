import pytest

from pqkb.topics import Topics, Use, collect, load_guides, render_pages, topic_menu, topic_pages

CHECKLIST = [
    {
        "id": "paging",
        "question": "How does it page?",
        "docs": "handling-paging",
        "answers": ["none", "next-link-url"],
        "definitions": {"next-link-url": {"means": "Follows a next link.", "source": "x"}},
        "sub": [
            {"id": "paging-generator", "answers": ["table-generatebypage"], "question": "How?"},
            {"id": "paging-stop", "free_text": True, "question": "Stop?"},
        ],
    },
    {"id": "auth", "question": "How does it authenticate?", "answers": ["oauth"]},
]
TITLES = {"paging": "Paging", "auth": "Authentication"}
PATTERNS = {"pagination": ("Page generation", "Cursor paging."), "oauth2": ("OAuth2", "Login.")}
CONFIG = {
    "titles": TITLES,
    "patterns": {"pagination": {"paging": ["next-link-url"], "auth": []}, "oauth2": {"auth": []}},
}


def answers(value, sub=None, file="A.pq"):
    answer = {"values": [value], "evidence": [{"file": file, "lines": "10-12"}]}
    if sub:
        answer["sub"] = {"paging-generator": {"values": [sub]}, "paging-stop": {"text": "x"}}
    return {"paging": answer}


def topics() -> Topics:
    titles, guides = load_guides(CONFIG, CHECKLIST, PATTERNS)
    return Topics(CHECKLIST, "https://learn/", titles, guides)


def test_hand_checked_labels_win_and_free_text_is_skipped():
    sources = {
        "Alpha": (answers("next-link-url", "table-generatebypage"), True),
        "Beta": (answers("none", file="B.pq"), False),
    }
    matrix = collect(CHECKLIST, sources)
    assert matrix["paging"]["next-link-url"] == [Use("Alpha", True, "A.pq:10")]
    assert matrix["paging/paging-generator"]["table-generatebypage"][0].connector == "Alpha"
    assert "paging/paging-stop" not in matrix


def test_topic_pages_link_patterns_and_connectors_from_their_folder():
    matrix = collect(CHECKLIST, {"Alpha": (answers("next-link-url"), True)})
    pages = render_pages(topics(), matrix, ["Alpha", "Gamma"])
    assert set(pages) == {"index.md", "paging.md", "auth.md"}
    index_meta, index = pages["index.md"]
    meta, paging = pages["paging.md"]
    assert index_meta is None and meta == {
        "type": "Power Query Topic",
        "title": "Paging",
        "description": "How does it page?",
    }
    assert "## [Paging](paging.md)" in index and "`next-link-url` 1" in index
    assert "[Gamma](../connectors/Gamma.md)" in index
    assert "[Alpha](../connectors/Alpha.md) ✓ `A.pq:10`" in paging
    assert "Follows a next link." in paging
    assert "([Learn](https://learn/handling-paging))" in paging
    assert "Explained in: [Page generation](../patterns/pagination.md)." in paging


def test_index_lists_each_pattern_under_its_first_topic_only():
    index = render_pages(topics(), {}, [])["index.md"][1]
    assert index.count("(../patterns/pagination.md)") == 1
    paging, auth = index.split("## [Authentication]")
    assert "pagination.md" in paging and "oauth2.md" in auth
    _, auth_page = render_pages(topics(), {}, [])["auth.md"]
    assert "(../patterns/pagination.md)" in auth_page  # Still linked from other topics.


def test_menu_nests_patterns_under_their_first_topic():
    assert topic_menu(topics()) == [
        {
            "Topics": [
                "topics/index.md",
                {
                    "Paging": [
                        {"Overview": "topics/paging.md"},
                        {"Page generation": "patterns/pagination.md"},
                    ]
                },
                {
                    "Authentication": [
                        {"Overview": "topics/auth.md"},
                        {"OAuth2": "patterns/oauth2.md"},
                    ]
                },
            ]
        }
    ]
    assert topic_menu(None) == []


@pytest.mark.parametrize(
    ("config", "problem"),
    [
        ({**CONFIG, "titles": {"paging": "Paging"}}, "question 'auth' has no title"),
        ({**CONFIG, "patterns": {"oauth2": {"auth": []}}}, "pattern 'pagination' has no topic"),
        (
            {**CONFIG, "patterns": {**CONFIG["patterns"], "oauth2": {"auth": ["saml"]}}},
            "unknown auth answer 'saml'",
        ),
        (
            {**CONFIG, "patterns": {**CONFIG["patterns"], "oauth2": {"folding": []}}},
            "unknown question 'folding'",
        ),
        (
            {**CONFIG, "patterns": {**CONFIG["patterns"], "ghost": {"auth": []}}},
            "unknown pattern 'ghost'",
        ),
    ],
)
def test_mapping_errors_fail_the_build(config, problem):
    with pytest.raises(ValueError, match=problem):
        load_guides(config, CHECKLIST, PATTERNS)


def test_no_checklist_means_no_pages(tmp_path):
    assert topic_pages(tmp_path, ["Alpha"], {}) == {}
