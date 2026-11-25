---
type: Power Query Connector
title: Siteimprove
description: Connect to Siteimprove
tags: [navigation, packaging, usernamepassword, web-requests]
x-pqkb-publisher: SiteImprove
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq
  title: Siteimprove.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SiteImprove/1.1.0/SiteImprove_1.1.0.pqx
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
| SiteImprove | 1.1.0 | UsernamePassword |

# Source files

* [Siteimprove.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Uncertain match (older review)**
    * [Siteimprove.pq line 780](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L780) — `Documentation.FieldCaption = "site_id",`
    * [Siteimprove.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L6) — `shared Siteimprove.Contents = Value.ReplaceType(SiteimproveImpl, SiteimproveType);`
    * [Siteimprove.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L32) — `SiteimproveType = type function ()`
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Siteimprove.pq line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L58) — `navTable = Table.ToNavigationTable(addedAdvanced, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Siteimprove.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L192) — `NavigationTable.NameColumn = nameColumn,`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Siteimprove.pq line 770](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L770) — `Table.GenerateByPage((previous) =>`
    * [Siteimprove.pq line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L152) — `next = if links = null then null else Record.FieldOrDefault(links, "next"),`
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Siteimprove.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L14) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Siteimprove.pq line 772](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L772) — `nextLink = if (previous = null) then requestUrl else Value.Metadata(previous)[NextLink]?,`
    * [Siteimprove.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L39) — `Headers = [`
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Siteimprove.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L6) — `shared Siteimprove.Contents = Value.ReplaceType(SiteimproveImpl, SiteimproveType);`
    * [Siteimprove.pq line 787](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L787) — `AdvancedAnalyticsUrl_shortenerShortened_urlsResultType = type table [`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm#L44) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Siteimprove.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L46) — `source = Json.Document(Web.Contents("https://api.siteimprove.com/v2/sites?page_size=1000", SiteimproveRequestOptions)),`
