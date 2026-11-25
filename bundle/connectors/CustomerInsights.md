---
type: Power Query Connector
title: Dynamics 365 Customer Insights
description: Connect to Dynamics 365 Customer Insights
tags: [aad, navigation, packaging, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.14
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m
  title: CustomerInsights.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CustomerInsights/1.0.14/CustomerInsights_1.0.14.pqx
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
| Microsoft | 1.0.14 | Aad |

# Source files

* [CustomerInsights.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [CustomerInsights.m line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L103) — `navTable = Table.ToNavigationTable(withIsLeaf, {"instanceId"}, "name", "Data", "ItemKind", "ItemName", "IsLeaf") // Uses nav function to create the table`
    * [CustomerInsights.m line 343](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L343) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CustomerInsights.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L58) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [CustomerInsights.m line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L187) — `responseCode = Value.Metadata(MetadataRawResponse)[Response.Status]`
    * [CustomerInsights.m line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L87) — `JsonResponse = Json.Document(Web.Contents(Text.TrimEnd(url, {"/"}), [Headers = CustomerInsights.SimpleHeaders])),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CustomerInsights.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L42) — `shared CustomerInsights.Contents = Value.ReplaceType(CustomerInsights.ContentsInternal, CustomerInsights.Type);`
    * [CustomerInsights.m line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L175) — `EmptyRelationships = #table(type table [ fromEntityName = Text.Type, toEntityName = Text.Type, fromAttributeName = Text.Type, toAttributeName = Text.Type], {}),`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [CustomerInsights.m line 237](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L237) — `View = (state as record) => Table.View( null, [`
    * [CustomerInsights.m line 238](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L238) — `GetRows = () => CustomerInsights.GetData(state[Url], schema, cIOptions, dataType),  //Fetches tables`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [CustomerInsights.m line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L87) — `JsonResponse = Json.Document(Web.Contents(Text.TrimEnd(url, {"/"}), [Headers = CustomerInsights.SimpleHeaders])),`
