---
type: Power Query Connector
title: SumTotal
description: Connect to SumTotal
tags: [oauth]
x-pqkb-publisher: SumTotal
x-pqkb-version: 3.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq
  title: SumTotal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SumTotal/3.0.0/SumTotal_3.0.0.pqx
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
| SumTotal | 3.0.0 | OAuth |

# Source files

* [SumTotal.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SumTotal.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SumTotal.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SumTotal.pq line 25](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L25) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SumTotal. [SumTotal.pq line 179](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L179) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SumTotal.ODataFeed. [SumTotal.pq line 20](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L20) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [SumTotal.pq line 250](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L250) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SumTotal.pq line 254](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L254) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [SumTotal.pq line 117](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L117) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
