---
type: Power Query Connector
title: AtScale cubes
description: Import/DirectQuery cube data from AtScale.
tags: [usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq
  title: AtScale.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AtScale/3.0.4/AtScale_3.0.4.pqx
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
| Microsoft | 3.0.4 | UsernamePassword |

# Source files

* [AtScale.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AtScale.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AtScale.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AtScale.pq line 34](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L34) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AtScale. [AtScale.pq line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L10) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AtScale.Cubes. [AtScale.pq line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AtScale.pq line 61](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L61) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AtScale.pq line 27](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L27) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AtScale.pq line 15](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L15) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AtScale.pq line 24](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L24) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
