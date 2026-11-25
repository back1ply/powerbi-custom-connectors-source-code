from datetime import UTC, datetime

from pqkb import bundle
from pqkb.cli import main
from pqkb.site_hooks import llms_txt

pytest_plugins = ("test_pipeline",)

SITE = "https://example.test/site/"
REPO = "https://github.com/owner/name"


def test_llms_txt_lists_raw_bundle_pages_under_standard_sections(repo):
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    text = llms_txt(repo / bundle.BUNDLE_DIR, SITE, REPO)
    lines = text.splitlines()
    assert lines[0] == "# Power Query Connector Source Reference"
    assert lines[2].startswith("> Source of Microsoft's certified")
    for heading in ("## Patterns", "## Connectors", "## Optional"):
        assert heading in lines
    raw = "https://raw.githubusercontent.com/owner/name/main/bundle"
    assert f"({raw}/connectors/Demo.md)" in text
    assert f"({raw}/patterns/retries.md)" in text
    assert "viz.html" not in text  # The graph is not published until phase 2.
    assert "index.md):" not in text.split("## Optional")[0]  # Indexes only under Optional.


def test_viz_command_writes_a_self_contained_graph_of_the_bundle(repo, capsys):
    bundle.build(repo, datetime(2026, 11, 1, tzinfo=UTC))
    assert main(["--repo", str(repo), "viz", "--out", "out/viz.html"]) == 0
    html = (repo / "out" / "viz.html").read_text(encoding="utf-8")
    assert "connectors/Demo" in html
    assert "patterns/retries" in html
    assert "Wrote" in capsys.readouterr().out
