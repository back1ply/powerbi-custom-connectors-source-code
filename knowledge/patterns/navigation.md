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
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: ce390e86ce33ce7f8cd1d1a4a157e3c9651f916859c10c200189edde8ac772d2
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana builds a one-row navigation table with `Name`, `Data`, `ItemKind`, `ItemName`, and `IsLeaf` columns. The `Data` cell contains `Asana.View(link)`. `Table.ToNavigationTable` receives `Name` as the key and maps each navigation role to the corresponding column name.[^example]

The connector record separately declares `TestConnection = (dataSourcePath) => {"Asana.Tables", dataSourcePath}`. That handler names the shared function and supplies its argument. The connection check and the navigation-table construction are related entry points, but they are not the same function.[^example]

# Adaptation and failure paths

Keep column roles explicit when changing a navigation schema. A renamed key, data, or leaf column also needs an updated mapping. Trace what the `Data` cell evaluates to and how its function obtains the original URL; a visually correct list of names does not establish correct parameter routing.

Review the connection-test handler against the shared function's signature and its serialized data-source path. Asana passes the path directly, while the displayed navigation data comes from a view. Test the entry-point path separately from downstream row retrieval when adapting the connector, especially if the source path contains multiple parameters.[^example]

See [Table.View](table-view.md), [schema metadata](schema.md), and [packaged resources](packaging.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 26–34.[^example] It is a partial excerpt; follow the source link for the complete implementation.

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

[^example]: Asana/Asana.m; see the matching `sources` entry.
