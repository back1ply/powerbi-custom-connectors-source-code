---
type: Power Query Connector
title: WebtrendsAnalytics
description: Power BI connector source for WebtrendsAnalytics.
tags: [usernamepassword]
x-pqkb-publisher: Webtrends
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq
  title: WebtrendsAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WebtrendsAnalytics/1.0.0/WebtrendsAnalytics_1.0.0.pqx
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
| Webtrends | 1.0.0 | UsernamePassword |

# Source files

* [WebtrendsAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [WebtrendsAnalytics.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [WebtrendsAnalytics.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [WebtrendsAnalytics.pq line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L153) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for WebtrendsAnalytics. [WebtrendsAnalytics.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L8) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: WebtrendsAnalytics.Tables. [WebtrendsAnalytics.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [WebtrendsAnalytics.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L20) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [WebtrendsAnalytics.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L22) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [WebtrendsAnalytics.pq line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L58) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [WebtrendsAnalytics.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L21) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
