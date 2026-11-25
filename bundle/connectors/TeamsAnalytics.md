---
type: Power Query Connector
title: Microsoft Teams Personal Analytics
description: Connect to Microsoft Teams Personal Analytics
tags: [aad, navigation, packaging, pagination, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq
  title: TeamsAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamsAnalytics/1.1.0/TeamsAnalytics_1.1.0.pqx
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
| Microsoft | 1.1.0 | Aad |

# Source files

* [TeamsAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [TeamsAnalytics.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L44) — `navTable = Table.ToNavigationTable(source, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [TeamsAnalytics.pq line 232](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L232) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [TeamsAnalytics.pq line 120](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L120) — `listOfPages = List.Generate(`
    * [TeamsAnalytics.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L113) — `page = if (nextLink <> null) then CrossTeamAnalyticsSummarySinglePage(nextLink) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [TeamsAnalytics.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L40) — `{ Extension.LoadString("UserActivityLabel"), "Teams user activity", UserAnalytics(), "Table", "Table", true },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [TeamsAnalytics.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L112) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [TeamsAnalytics.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L35) — `shared TeamsAnalytics.Contents = Value.ReplaceType(Navigation, NavigationType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [TeamsAnalytics.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L60) — `Request= Web.Contents( Endpoint,`
