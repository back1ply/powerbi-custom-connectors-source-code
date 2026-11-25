---
type: Power Query Connector
title: InformationGrid
description: Access BI services from InformationGrid
tags: [credentials, date-filters, key, navigation, packaging, parameter-metadata, schema, web-requests]
x-pqkb-publisher: Luminis
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq
  title: InformationGrid.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/InformationGrid/1.0.5/InformationGrid_1.0.5.pqx
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
| Luminis | 1.0.5 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm)
* [InformationGrid.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L35) — `token = "Bearer " & Extension.CurrentCredential()[Key],`
    * [InformationGrid.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L35) — `token = "Bearer " & Extension.CurrentCredential()[Key],`
* [Date-range request filters](../patterns/date-filters.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L72) — `(optional RangeStart as nullable datetime, optional RangeEnd as nullable datetime) as table =>`
    * [InformationGrid.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L72) — `(optional RangeStart as nullable datetime, optional RangeEnd as nullable datetime) as table =>`
    * [InformationGrid.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L80) — `rangeStartStr = DateTime.ToText(RangeStart, "yyyy-MM-ddTHH:mm:ss") & "Z",`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L11) — `Documentation.FieldCaption = Extension.LoadString("ServerFieldCaption"),`
    * [InformationGrid.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L7) — `shared InformationGrid.Contents = Value.ReplaceType(InformationGridImpl, InformationGridType);`
    * [InformationGrid.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L9) — `InformationGridType = type function (`
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L65) — `servicesNavTable = Table.ToNavigationTable(servicesTable6, {"Service"}, "Service", "Data", "ItemKind", "Data", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L11) — `Documentation.FieldCaption = Extension.LoadString("ServerFieldCaption"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 189](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm#L189) — `if base = type table then "table" else`
    * [InformationGrid.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L7) — `shared InformationGrid.Contents = Value.ReplaceType(InformationGridImpl, InformationGridType);`
    * [InformationGrid.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L132) — `topTableType = type table topType`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm#L44) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [InformationGrid.pq line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L37) — `serviceListSource = Web.Contents(serviceListUrl, options),`
