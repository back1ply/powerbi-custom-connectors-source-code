---
type: Power Query Pattern
title: Navigation tables and connection checks
description: Navigation-column mappings and connection-test entry points.
category: Navigation and UI
tags: [navigation-and-ui]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Table\.ToNavigationTable\s*\(|TestConnection\s*=)']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L26
  title: Asana/Asana.m
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L81
  title: Asana/Asana.m
- id: loader
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L243
  title: Asana/Asana.m
- id: pqm
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Table.ToNavigationTable.pqm#L1
  title: Asana/Table.ToNavigationTable.pqm
- id: contrast
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L134
  title: CommonDataService/CommonDataService.pq
- id: json-path
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L347
  title: MarkLogicODBC/MarkLogicODBC.m
- id: split-path
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L218
  title: AmazonAthena/AmazonAthena.m
review:
  content_sha256: 8982946507965c4289154cbfaf4365755654763ef846b0580cf67e8b18a495e4
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    helper: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    loader: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    pqm: acae85d13e9737698632a24472c171dedb9ee19e5f6a15b64d4d300b51435c0b
    contrast: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
    json-path: 2d4e1443df32a7f24853d4afd67afaae87637e5146d5b6f4b08dd3e5bb200b27
    split-path: fe4d2fa4c6e8eb8778bc55737620f3fe827c84146e8a7c82f63b51ffcf6cb0b8
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Navigation tables and connection checks

## Mechanism

`AsanaNavTable` builds a one-row table with the columns `Name`, `Data`, `ItemKind`, `ItemName`, and `IsLeaf`. Its `Data` cell holds `Asana.View(link)`. The view's `GetType` and `GetRows` handlers reach web requests through `AsanaSchema` and `GetTasks`; see [Table.View](table-view.md). The navigation call passes `Name` as the key and maps each role to a column name.[^example]

The name `Table.ToNavigationTable` is bound locally to `Table.ToNavigationTable.pqm` through `Extension.LoadFunction`. That module builds a table key with `Type.AddTableKey(tableType, keyColumns, true)` and stores the supplied column names as navigation metadata. It uses the `ItemName` argument for `Preview.DelayColumn`. Inspect this local implementation when adapting the call; the helper's name alone does not establish its behavior.[^loader][^pqm]

The connector record declares `TestConnection = (dataSourcePath) => {"Asana.Tables", dataSourcePath}` (line 82). That handler names the shared function and passes the stored path as its only argument. It is a separate entry point from the navigation table. It does not build any navigation rows.[^helper]

The same record also declares `Authentication` and `OAuth` handlers, which are not part of navigation. The navigation metadata can instead be declared on a type. `EnvironmentListType` in CommonDataService (lines 134–150) sets `NavigationTable.NameColumn`, `NavigationTable.DataColumn`, and `NavigationTable.SupportsIndirection` directly on the table type, and keys the table on `Name`. It needs no local helper.[^contrast]

## Adaptation and failure paths

Choose the local-helper approach when the navigation table is built at runtime from a `#table` value and you want the mapping in one call. Choose type metadata, as CommonDataService does, when the table shape is fixed and you want no helper file. Choose [schema handling](schema.md) when the question is the declared return type rather than navigation roles.

Column roles are the main risk. If you rename `Data` in the `#table` but not in the call, the mapping points at a column that no longer exists. The local copy stores names as metadata and does not check that they exist in the table. Test the navigation table after any rename.[^pqm][^example]

`TestConnection` assumes that the path is exactly the argument list. Asana passes the path through unchanged, which is correct for its one `link` parameter. A connector with several parameters must parse the stored path. MarkLogic's `TestConnection` parses JSON with `Json.Document` and reads `server` and `port` before returning them (lines 347–353).[^json-path] AmazonAthena splits its path on `;` (`ParseResourcePath`, line 218) and returns the parts as the argument list.[^split-path]

The local copy is loaded with `Extension.Contents` (line 245), so the `.pqm` file must be packaged with the connector. If it is missing from the package, that call fails. Test the packaged output rather than the source tree.[^loader]

Adaptation checklist:

- Keep the five column roles (key, data, item kind, item name, leaf flag) explicit in both the `#table` and the call.
- Decide whether to use the local helper or type metadata, and document which one the connector uses.
- Test `TestConnection` with the exact path format that the UI stores, including any delimiter.
- Read one `Data` cell to confirm that it returns rows, not only that the navigation list displays.
- Confirm that every `.pqm` helper is packaged. See [packaging](packaging.md).

See [Table.View](table-view.md), [schema metadata](schema.md), and [packaged resources](packaging.md).

## Examples

The first excerpt, copied from `Asana/Asana.m` lines 26–34, builds the navigation row and calls the navigation helper with the column roles.[^example]

<!-- source: example -->
```powerquery
AsanaNavTable = (link as text) as table =>
    let
        source = #table(
            { "Name",      "Data",           "ItemKind", "ItemName", "IsLeaf"}, {
            { "Tasks",      Asana.View(link), "Table",    "Table",     true }            }
        ),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;
```

The second excerpt, copied from `Asana/Asana.m` lines 81–90, is the connector record. It contains the `TestConnection` handler and the authentication fields it sits beside.[^helper]

<!-- source: helper -->
```powerquery
Asana = [
    TestConnection = (dataSourcePath) => {"Asana.Tables", dataSourcePath},
    Authentication = [
        OAuth = [
            StartLogin=StartLogin,
            FinishLogin=FinishLogin,
            Label=Extension.LoadString("AuthenticationLabel")
        ]
    ]
];
```

The third excerpt, copied from `Asana/Asana.m` lines 243–250, is the loader that replaces the built-in name. It is the reason the navigation helper in this connector is not the standard library function.[^loader]

<!-- source: loader -->
```powerquery
Extension.LoadFunction = (name as text) =>
    let
        binary = Extension.Contents(name),
        asText = Text.FromBinary(binary)
    in
        Expression.Evaluate(asText, #shared);

Table.ToNavigationTable = Extension.LoadFunction("Table.ToNavigationTable.pqm");
```

The fourth excerpt, copied from `CommonDataService/CommonDataService.pq` lines 134–150, is the contrasting type-metadata approach. It is a type declaration, not a navigation function.[^contrast]

<!-- source: contrast -->
```powerquery
EnvironmentListType = Type.AddTableKey(
    type table [
        DisplayName = text,
        Name = text,
        Location = text,
        IsDefault = logical,
        Data = (type table meta [
            NavigationTable.ItemKind = "Database",
            Preview.Delay = "Table"
        ])
    ] meta [
        NavigationTable.NameColumn = "DisplayName",
        NavigationTable.DataColumn = "Data",
        NavigationTable.SupportsIndirection = true
    ],
    {"Name"},
    true);
```

[^example]: Asana/Asana.m lines 26–34: `AsanaNavTable` builds the one-row `#table` and calls `Table.ToNavigationTable` with `Name` as the key and the four role columns.
[^loader]: Asana/Asana.m lines 243–250: `Extension.LoadFunction` evaluates a packaged `.pqm` file, and line 250 binds `Table.ToNavigationTable` to it.
[^pqm]: Asana/Table.ToNavigationTable.pqm lines 1–22: the local function applies `Type.AddTableKey` and stores the name, data, item-kind, item-name, and leaf column names as metadata.
[^helper]: Asana/Asana.m lines 81–90: the connector record declares `TestConnection`, which returns the shared function name and the stored path, plus the OAuth fields.
[^contrast]: CommonDataService/CommonDataService.pq lines 134–150: `EnvironmentListType` attaches navigation metadata to a table type and keys it on `Name`.
[^json-path]: MarkLogicODBC/MarkLogicODBC.m lines 347–353: `TestConnection` parses the stored path with `Json.Document` and returns the function name with `server` and `port`.
[^split-path]: AmazonAthena/AmazonAthena.m lines 218–220: `ParseResourcePath` splits the path on `;`, and `TestConnection` prepends the function name to the parts.
