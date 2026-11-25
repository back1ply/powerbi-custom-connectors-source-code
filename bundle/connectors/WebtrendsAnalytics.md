---
type: Power Query Connector
title: WebtrendsAnalytics
description: Power BI connector source for WebtrendsAnalytics.
tags: [navigation, packaging, parameter-metadata, schema, usernamepassword]
x-pqkb-publisher: Webtrends
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq
  title: WebtrendsAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WebtrendsAnalytics/1.0.0/WebtrendsAnalytics_1.0.0.pqx
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
| Webtrends | 1.0.0 | UsernamePassword |

# Source files

* [WebtrendsAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [WebtrendsAnalytics.pq line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L153) — `Documentation.FieldCaption = Extension.LoadString("Tables.Parameter.ProfileId.FieldCaption"),`
    * [WebtrendsAnalytics.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L5) — `shared WebtrendsAnalytics.Tables = Value.ReplaceType(WebtrendsAnalytics.TablesInternal, WebtrendsAnalytics.TablesTypes);`
    * [WebtrendsAnalytics.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L187) — `t = type function (ProfileId as ProfileId, Period as Period, reportType as reportType, optional startDate as startDate, optional endDate as endDate, optional startPeriod as startPeriod, optional endPeriod as endPeriod) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [WebtrendsAnalytics.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L146) — `navTable = Table.ToNavigationTable(withIsLeafCol, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [WebtrendsAnalytics.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L62) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [WebtrendsAnalytics.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L21) — `ButtonText = {Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp")},`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [WebtrendsAnalytics.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L5) — `shared WebtrendsAnalytics.Tables = Value.ReplaceType(WebtrendsAnalytics.TablesInternal, WebtrendsAnalytics.TablesTypes);`
    * [WebtrendsAnalytics.pq line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L130) — `fixedTypes = Value.ReplaceType(objects, type table [ID=text, Name=text]),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [WebtrendsAnalytics.pq line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L91) — `Web.Contents(`
