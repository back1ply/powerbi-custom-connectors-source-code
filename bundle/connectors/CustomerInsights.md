---
type: Power Query Connector
title: Dynamics 365 Customer Insights
description: Connect to Dynamics 365 Customer Insights
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.14
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m
  title: CustomerInsights.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CustomerInsights/1.0.14/CustomerInsights_1.0.14.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T22:15:39Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.14 | Aad |

# Source files

* [CustomerInsights.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CustomerInsights.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CustomerInsights.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CustomerInsights.m line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L78) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CustomerInsights. [CustomerInsights.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L45) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CustomerInsights.Contents. [CustomerInsights.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L41) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [CustomerInsights.m line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L63) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CustomerInsights.m line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L67) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [CustomerInsights.m line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L103) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CustomerInsights.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CustomerInsights/CustomerInsights.m#L58) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
