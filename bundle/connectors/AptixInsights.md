---
type: Power Query Connector
title: Topcon Aptix Insights
description: Get Help
tags: [key]
x-pqkb-publisher: AptixInsights
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq
  title: AptixInsights.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AptixInsights/1.0.2/AptixInsights_1.0.2.pqx
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
| AptixInsights | 1.0.2 | Key |

# Source files

* [AptixInsights.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AptixInsights.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AptixInsights.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AptixInsights.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L20) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AptixInsights. [AptixInsights.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L55) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AptixInsights.Feed. [AptixInsights.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AptixInsights.pq line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L66) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AptixInsights.pq line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L70) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AptixInsights.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L50) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AptixInsights.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L20) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [AptixInsights.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L11) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
