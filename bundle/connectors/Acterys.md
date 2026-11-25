---
type: Power Query Connector
title: 'Acterys: Model Automation & Planning'
description: Connect to Acterys
tags: [aad, navigation, packaging]
x-pqkb-publisher: Managility
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq
  title: Acterys.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Acterys/1.0.1/Acterys_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T17:23:17Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Managility | 1.0.1 | Aad |

# Source files

* [Acterys.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Acterys.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L57) — `NavTableFinal = Table.ToNavigationTable(objectsFinal, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),`
    * [Acterys.pq line 198](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L198) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Acterys.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L219) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Acterys.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L139) — `#"Changed Type" = Table.TransformColumnTypes(TableData,{{"Amount", type number}})`
    * [Acterys.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L39) — `#"Grouped Rows" = Table.Group(#"Removed Columns", {"Name"}, {{"Count", each _, type table [ID=number, Name=text, WriteBackTable=text, WriteBackSP=text, Dimensions.ID=number, Dimensions.Name=text]}}),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Acterys.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L12) — `SourceDatabase = Json.Document(Web.Contents("https://app.acterys.com:9998/api/Subscription")),`
