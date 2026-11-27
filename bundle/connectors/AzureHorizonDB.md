---
type: Power Query Connector
title: Azure HorizonDB Database
description: Import or connect to an Azure HorizonDB Database
tags: [aad, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq
  title: AzureHorizonDB.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureHorizonDB/1.0.3/AzureHorizonDB_1.0.3.pqx
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
| Microsoft | 1.0.3 | Aad, UsernamePassword |

# Source files

* [AzureHorizonDB.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureHorizonDB.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureHorizonDB.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureHorizonDB.pq line 109](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L109) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureHorizonDB. [AzureHorizonDB.pq line 146](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L146) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureHorizonDB.Database. [AzureHorizonDB.pq line 21](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L21) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureHorizonDB.pq line 171](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L171) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AzureHorizonDB.pq line 33](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L33) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureHorizonDB.pq line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L47) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AzureHorizonDB.pq line 33](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L33) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
