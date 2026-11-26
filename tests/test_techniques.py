from pqkb.techniques import Use, collect, render_pages

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
    }
]


def answers(value, sub=None, file="A.pq"):
    answer = {"values": [value], "evidence": [{"file": file, "lines": "10-12"}]}
    if sub:
        answer["sub"] = {"paging-generator": {"values": [sub]}, "paging-stop": {"text": "x"}}
    return {"paging": answer}


def test_hand_checked_labels_win_and_free_text_is_skipped():
    sources = {
        "Alpha": (answers("next-link-url", "table-generatebypage"), True),
        "Beta": (answers("none", file="B.pq"), False),
    }
    matrix = collect(CHECKLIST, sources)
    assert matrix["paging"]["next-link-url"] == [Use("Alpha", True, "A.pq:10")]
    assert matrix["paging/paging-generator"]["table-generatebypage"][0].connector == "Alpha"
    assert "paging/paging-stop" not in matrix


def test_pages_mark_hand_checked_entries_and_list_unprofiled_connectors():
    matrix = collect(CHECKLIST, {"Alpha": (answers("next-link-url"), True)})
    pages = render_pages(CHECKLIST, matrix, ["Alpha", "Gamma"], "https://learn/")
    assert set(pages) == {"index.md", "paging.md"}
    index_meta, index = pages["index.md"]
    meta, paging = pages["paging.md"]
    assert index_meta is None and meta["type"] == "Power Query Technique Matrix"
    assert "`next-link-url` 1" in index
    assert "[Gamma](../connectors/Gamma.md)" in index
    assert "[Alpha](../connectors/Alpha.md) ✓ `A.pq:10`" in paging
    assert "Follows a next link." in paging
    assert "([Learn](https://learn/handling-paging))" in paging


def test_no_checklist_means_no_pages(tmp_path):
    from pqkb.techniques import techniques_pages

    assert techniques_pages(tmp_path, ["Alpha"]) == {}
