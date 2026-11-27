---
type: Power Query Connector
title: Microsoft Teams Personal Analytics
description: Connect to Microsoft Teams Personal Analytics
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq
  title: TeamsAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamsAnalytics/1.1.0/TeamsAnalytics_1.1.0.pqx
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
| Microsoft | 1.1.0 | Aad |

# Source files

* [TeamsAnalytics.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [TeamsAnalytics.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [TeamsAnalytics.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [TeamsAnalytics.pq line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L49) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for TeamsAnalytics. [TeamsAnalytics.pq line 210](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L210) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: TeamsAnalytics.Contents. [TeamsAnalytics.pq line 34](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L34) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [TeamsAnalytics.pq line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L44) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [TeamsAnalytics.pq line 40](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamsAnalytics/TeamsAnalytics.pq#L40) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
