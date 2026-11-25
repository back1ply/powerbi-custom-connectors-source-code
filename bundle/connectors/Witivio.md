---
type: Power Query Connector
title: PQExtension1
description: Connect to PQExtension1
tags: [aad, navigation, packaging, pagination, parameter-metadata, response-metadata, schema]
x-pqkb-publisher: Witivio
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq
  title: Witivio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Witivio/1.0.0/Witivio_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Witivio | 1.0.0 | Aad |

# Source files

* [Witivio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Witivio.pq line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L154) — `Documentation.FieldCaption = "Chatbot ID",`
    * [Witivio.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L150) — `shared Witivio.Contents = Value.ReplaceType(WitivioNavTable, WitivioType);`
    * [Witivio.pq line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L152) — `WitivioType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Witivio.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L175) — `navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Witivio.pq line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L234) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Witivio.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L204) — `Table.GenerateByPage((previous) =>`
    * [Witivio.pq line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L209) — `page = if (nextLink <> null) then GetPage(nextLink, schema) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Witivio.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L55) — `Icon16 = { Extension.Contents("PQExtension116.png"), Extension.Contents("PQExtension120.png"), Extension.Contents("PQExtension124.png"), Extension.Contents("PQExtension132.png") },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Witivio.pq line 207](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L207) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
    * [Witivio.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L191) — `response = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Witivio.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L150) — `shared Witivio.Contents = Value.ReplaceType(WitivioNavTable, WitivioType);`
    * [Witivio.pq line 168](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L168) — `withData = Table.AddColumn(rename, "Data", each GetEntity(botId, [Name]), type table),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Witivio.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L191) — `response = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),`
