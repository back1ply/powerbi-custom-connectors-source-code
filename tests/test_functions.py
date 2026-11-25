import json

from pqkb.cli import main
from pqkb.functions import index_connector
from pqkb.refresh import ConnectorRecord, write_index

SECTION = """[Version = "1.0.0"]
section Demo;

// A comment with brackets ( [ { and a ; semicolon.
[DataSource.Kind = "Demo", Publish = "Demo.Publish"]
shared Demo.Contents = (url as text) =>
    let
        text = "a ; b ) ] }",
        page = GetPage(url)
    in
        Helper(page);

GetPage = (url) => Web.Contents(url);

Helper = (page) => #"Odd name"(page);

#"Odd name" = (x) => x;

Loader = Extension.LoadFunction("Table.Thing.pqm");
"""

MODULE = "(table as table) as table =>\n    table\n"


def test_members_get_line_ranges_attributes_and_calls():
    functions = {
        f.name: f for f in index_connector("Demo", {"Demo.pq": SECTION, "Table.Thing.pqm": MODULE})
    }
    entry = functions["Demo.Contents"]
    assert (entry.start, entry.end, entry.shared) == (5, 11, True)  # Attribute line included.
    assert entry.calls == ("GetPage", "Helper")  # Masked string brackets do not split members.
    assert (functions["GetPage"].start, functions["GetPage"].end) == (13, 13)
    assert functions["Helper"].calls == ('#"Odd name"',)
    assert functions["Loader"].calls == ("Table.Thing.pqm",)
    module = functions["Table.Thing.pqm"]
    assert (module.file, module.start, module.end) == ("Table.Thing.pqm", 1, 2)


def test_functions_command_prints_json_and_rejects_unknown_connectors(tmp_path, capsys):
    (tmp_path / "pyproject.toml").touch()
    folder = tmp_path / "connectors" / "Demo"
    folder.mkdir(parents=True)
    (folder / "Demo.pq").write_text(SECTION, encoding="utf-8")
    write_index(
        tmp_path / "connectors", [ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"])]
    )
    assert main(["--repo", str(tmp_path), "functions", "Demo", "--json"]) == 0
    names = [f["name"] for f in json.loads(capsys.readouterr().out)]
    assert names == ["Demo.Contents", "GetPage", "Helper", '#"Odd name"', "Loader"]
    assert main(["--repo", str(tmp_path), "functions", "Missing"]) == 2
