import pytest

from pqkb.certification import RULES, check_connector
from pqkb.cli import main
from pqkb.refresh import ConnectorRecord, write_index

GOOD = """// header comment
[Version = "1.0.0"]
section Demo;

[DataSource.Kind = "Demo", Publish = "Demo.Publish"]
shared Demo.Contents = Value.ReplaceType(Impl, ImplType);

ImplType = type function (url as (type text meta [Documentation.FieldCaption = "URL"])) as table;

Impl = (url as text) =>
    let
        checked = if Uri.Parts(url)[Scheme] <> "https" then error "https required" else url,
        headers = [Authorization = Extension.CurrentCredential()[Key]],
        response = Web.Contents(checked, [Headers = headers]),
        nav = Table.ToNavigationTable(#table({"Name"}, {}), {"Name"}, "Name", "Data", "K", "N", "L")
    in
        nav;

Demo = [
    TestConnection = (path) => {"Demo.Contents", path},
    Authentication = [Key = []],
    Label = Extension.LoadString("Label")
];

Demo.Publish = [Beta = true, SourceImage = Demo.Icons];

Load = (name) => Expression.Evaluate(Text.FromBinary(Extension.Contents(name)), #shared);
"""


def statuses(text):
    return {f.rule: f.status for f in check_connector("Demo", {"Demo.pq": text})}


def test_compliant_connector_passes_every_rule():
    result = statuses(GOOD)
    assert set(result) == {rule.id for rule in RULES}
    assert result.pop("beta-flag") == "info"
    assert result.pop("diagnostics-gated") == "n/a"
    assert set(result.values()) == {"pass"}


@pytest.mark.parametrize(
    "old, new, rule, status",
    [
        ('[Version = "1.0.0"]\n', "", "version-header", "fail"),
        ("Documentation.FieldCaption", "Other.FieldCaption", "function-documentation", "fail"),
        (
            '    TestConnection = (path) => {"Demo.Contents", path},\n',
            "",
            "test-connection",
            "fail",
        ),
        ("shared Demo.Contents", "shared DemoConnector.Contents", "naming", "fail"),
        ("SourceImage = Demo.Icons", "Other = 1", "icons", "fail"),
        ("Table.ToNavigationTable", "Table.FromRecords", "navigation-table", "fail"),
        ('Extension.LoadString("Label")', '"Label"', "resource-strings", "fail"),
        (
            'if Uri.Parts(url)[Scheme] <> "https" then error "https required" else url',
            "url",
            "https-credentials",
            "review",
        ),
        (
            "[Headers = headers]",
            "[Query = [key = Extension.CurrentCredential()[Key]]]",
            "credential-query-string",
            "fail",
        ),
        (
            "Text.FromBinary(Extension.Contents(name))",
            "Web.Contents(name)",
            "expression-evaluate",
            "review",
        ),
    ],
)
def test_each_rule_reports_violations(old, new, rule, status):
    assert old in GOOD
    assert statuses(GOOD.replace(old, new))[rule] == status


def test_tracing_needs_a_flag_and_alternative_test_handlers_count():
    traced = GOOD.replace("nav;\n", 'Diagnostics.Trace(TraceLevel.Information, "x", nav);\n')
    assert statuses(traced)["diagnostics-gated"] == "review"
    gated = traced.replace("Demo.Publish = [", "EnableTraceOutput = false;\n\nDemo.Publish = [")
    assert statuses(gated)["diagnostics-gated"] == "pass"
    view = GOOD.replace('    TestConnection = (path) => {"Demo.Contents", path},\n', "").replace(
        "nav;\n", "Table.View(nav, [OnTestConnection = () => true]);\n"
    )
    assert statuses(view)["test-connection"] == "pass"


def test_certification_command(tmp_path, capsys):
    (tmp_path / "pyproject.toml").touch()
    folder = tmp_path / "connectors" / "Demo"
    folder.mkdir(parents=True)
    (folder / "Demo.pq").write_text(GOOD, encoding="utf-8")
    write_index(
        tmp_path / "connectors", [ConnectorRecord("Demo", "Demo", "", "", "1", "", ["Demo.pq"])]
    )
    assert main(["--repo", str(tmp_path), "certification", "Demo"]) == 0
    assert "pass    test-connection" in capsys.readouterr().out
    assert main(["--repo", str(tmp_path), "certification"]) == 0
    assert "1 connectors checked." in capsys.readouterr().out
    assert main(["--repo", str(tmp_path), "certification", "Nope"]) == 2
