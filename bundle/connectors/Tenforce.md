---
type: Power Query Connector
title: Tenforce (Smart)List
description: Connect to Tenforce
tags: [buffering, diagnostics, navigation, packaging, parameter-metadata, schema, usernamepassword, web-requests, windows]
x-pqkb-publisher: TenForce
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m
  title: Tenforce.m
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/TypeMappingTable.pqm
  title: TypeMappingTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Tenforce/1.0.4/Tenforce_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-02T11:27:27Z'
stale_after: '2026-11-16T11:27:27Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| TenForce | 1.0.4 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm)
* [Tenforce.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m)
* [TypeMappingTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/TypeMappingTable.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Tenforce.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L80) — `Items = Table.Buffer(Tenforce.ItemsTable(ApplicationUrl, ListId, DataType)),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm#L68) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Tenforce.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L57) — `Documentation.FieldCaption = Extension.LoadString("ApplicationUrl"),`
    * [Tenforce.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L9) — `shared Tenforce.Contents = Value.ReplaceType(Tenforce.NavTable, SelectionData.Parameters);`
    * [Tenforce.m line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L55) — `SelectionData.Parameters = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
    * [Tenforce.m line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L87) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Tenforce.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L25) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [Table.ChangeType.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm#L46) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Tenforce.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L9) — `shared Tenforce.Contents = Value.ReplaceType(Tenforce.NavTable, SelectionData.Parameters);`
    * [Tenforce.m line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L156) — `#"Selected Schema" = jsonData[Schema],`
    * [TypeMappingTable.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/TypeMappingTable.pqm#L1) — `#table(type table[Tenforce field type= text, Power Bi column type= any],`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Tenforce.m line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L124) — `source = Web.Contents(_url, [Headers = DefaultRequestHeaders, Timeout=#duration(0,0,30,0)]),`
