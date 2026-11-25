---
type: Power Query Connector
title: Linkar PICK Style / MultiValue Databases
description: Connect to PICK Style / MultiValue Databases
tags: [navigation, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Kosday Solutions
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq
  title: LinkarConnector.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Linkar/1.0.1/Linkar_1.0.1.pqx
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
| Kosday Solutions | 1.0.1 | UsernamePassword |

# Source files

* [LinkarConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [LinkarConnector.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L80) — `Documentation.FieldCaption = Extension.LoadString("Server"),`
    * [LinkarConnector.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L9) — `shared Linkar.Contents = Value.ReplaceType(LinkarImpl, LinkarType);`
    * [LinkarConnector.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L78) — `LinkarType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [LinkarConnector.pq line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L186) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [LinkarConnector.pq line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L67) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [LinkarConnector.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L32) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [LinkarConnector.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L9) — `shared Linkar.Contents = Value.ReplaceType(LinkarImpl, LinkarType);`
