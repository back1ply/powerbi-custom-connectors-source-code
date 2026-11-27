---
type: Power Query Connector
title: Azure Time Series Insights
description: Connect to Azure Time Series Insights
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.11
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m
  title: TimeSeriesInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TimeSeriesInsights/1.0.11/TimeSeriesInsights_1.0.11.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-27T12:12:40Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.11 | Aad |

# Source files

* [TimeSeriesInsightsConnector.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [TimeSeriesInsightsConnector.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [TimeSeriesInsightsConnector.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [TimeSeriesInsightsConnector.m line 74](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L74) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureTimeSeriesInsights, TimeSeriesInsights. [TimeSeriesInsightsConnector.m line 110](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L110) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: TimeSeriesInsights.Contents, AzureTimeSeriesInsights.Contents. [TimeSeriesInsightsConnector.m line 48](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L48) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [TimeSeriesInsightsConnector.m line 633](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L633) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [TimeSeriesInsightsConnector.m line 26](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L26) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
