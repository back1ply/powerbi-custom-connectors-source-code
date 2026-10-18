---
type: Power Query Connector
title: Azure Time Series Insights
description: Connect to Azure Time Series Insights
tags: [aad, buffering, errors, navigation, packaging, response-metadata, schema]
publisher: Microsoft
version: 1.0.11
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m
  title: TimeSeriesInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TimeSeriesInsights/1.0.11/TimeSeriesInsights_1.0.11.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.11 | Aad |

# Source files

* [TimeSeriesInsightsConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [TimeSeriesInsightsConnector.m line 500](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L500)
* [Navigation tables and connection checks](../patterns/navigation.md): [TimeSeriesInsightsConnector.m line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L56)
* [Resources and modular source loading](../patterns/packaging.md): [TimeSeriesInsightsConnector.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L26)
* [Response and pagination metadata](../patterns/response-metadata.md): [TimeSeriesInsightsConnector.m line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L165)
* [Schema and type enforcement](../patterns/schema.md): [TimeSeriesInsightsConnector.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L49)
* [Structured errors and HTTP status handling](../patterns/errors.md): [TimeSeriesInsightsConnector.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L162)
