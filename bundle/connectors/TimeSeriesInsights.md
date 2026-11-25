---
type: Power Query Connector
title: Azure Time Series Insights
description: Connect to Azure Time Series Insights
tags: [aad, packaging, parameter-metadata]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.11
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m
  title: TimeSeriesInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TimeSeriesInsights/1.0.11/TimeSeriesInsights_1.0.11.pqx
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
| Microsoft | 1.0.11 | Aad |

# Source files

* [TimeSeriesInsightsConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [TimeSeriesInsightsConnector.m line 500](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L500) — `bufferedResponse = Binary.Buffer(content),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [TimeSeriesInsightsConnector.m line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L74) — `Documentation.FieldCaption = Extension.LoadString("FuncType.JsonPayload.Caption"),`
    * [TimeSeriesInsightsConnector.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L49) — `shared TimeSeriesInsights.Contents = Value.ReplaceType(TimeSeriesInsights.ContentsInternal, TimeSeriesInsights.ContentsType);`
    * [TimeSeriesInsightsConnector.m line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L84) — `t = type function (query as jsonRecord) as table`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [TimeSeriesInsightsConnector.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L26) — `#"x-ms-app" = Extension.LoadString("TsiConnector"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [TimeSeriesInsightsConnector.m line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L165) — `headers = Record.FieldOrDefault(Value.Metadata(response), "Headers", []),`
    * [TimeSeriesInsightsConnector.m line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L161) — `Headers= DefaultRequestHeaders & [ Authorization = "Bearer" ],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [TimeSeriesInsightsConnector.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L49) — `shared TimeSeriesInsights.Contents = Value.ReplaceType(TimeSeriesInsights.ContentsInternal, TimeSeriesInsights.ContentsType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [TimeSeriesInsightsConnector.m line 167](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L167) — `errorResponse = if (wwwAuthenticate = "") then error Error.Record("DataSource.Error", Extension.LoadString("Errors.WwwAuthenticateNotFound")) else null,`
    * [TimeSeriesInsightsConnector.m line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L93) — `else error "Query cannot be empty or null."`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [TimeSeriesInsightsConnector.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L96) — `Web.Contents("https://api.timeseries.azure.com/environments?api-version=2016-12-12")`
