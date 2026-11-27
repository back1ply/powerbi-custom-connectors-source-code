---
type: Power Query Connector
title: ProductInsightsConnector
description: Connect to ProductInsightsConnector
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m
  title: ProductInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ProductInsights/1.0.2/ProductInsights_1.0.2.pqx
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
| Microsoft | 1.0.2 | Aad |

# Source files

* [ProductInsightsConnector.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ProductInsightsConnector.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ProductInsightsConnector.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ProductInsights. [ProductInsightsConnector.m line 161](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L161) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ProductInsights.Contents, ProductInsights.QueryMetric. [ProductInsightsConnector.m line 152](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L152) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [ProductInsightsConnector.m line 185](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L185) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ProductInsightsConnector.m line 187](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L187) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [ProductInsightsConnector.m line 209](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L209) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ProductInsightsConnector.m line 178](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ProductInsights/ProductInsightsConnector.m#L178) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
