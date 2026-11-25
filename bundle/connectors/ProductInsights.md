---
type: Power Query Connector
title: ProductInsightsConnector
description: Connect to ProductInsightsConnector
tags: [aad, graphql, navigation, packaging, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m
  title: ProductInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ProductInsights/1.0.2/ProductInsights_1.0.2.pqx
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
| Microsoft | 1.0.2 | Aad |

# Source files

* [ProductInsightsConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m)

# Pattern evidence

* [GraphQL requests](../patterns/graphql.md)
  * **Match from a review of older source**
    * [ProductInsightsConnector.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L15) — `GetProjectsQuery = [query =`
    * [ProductInsightsConnector.m line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L46) — `GetProjectsQueryJson = Text.FromBinary(Json.FromValue(GetProjectsQuery));`
    * [ProductInsightsConnector.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L215) — `content = Web.Contents(ValidateUrlScheme(url),`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [ProductInsightsConnector.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L209) — `nav = Table.ToNavigationTable(keyCol, {"Key"}, "name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [ProductInsightsConnector.m line 576](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L576) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ProductInsightsConnector.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L4) — `client_id = Text.FromBinary(Extension.Contents("client_id"));`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [ProductInsightsConnector.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L153) — `shared ProductInsights.Contents = Value.ReplaceType(ProductInsights.NavTable, type function () as table);`
    * [ProductInsightsConnector.m line 360](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L360) — `addData = Table.AddColumn(projectIdsTable, "Data", each NestedDashboardsTable(_[ProjectId], dashboardTables), type table)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [ProductInsightsConnector.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L215) — `content = Web.Contents(ValidateUrlScheme(url),`
