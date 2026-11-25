---
type: Power Query Connector
title: Azure Database for MySQL
description: Connect to Azure Database for MySQL
tags: [usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq
  title: AzureDatabaseForMySQL.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureDatabaseForMySQL/1.0.4/AzureDatabaseForMySQL_1.0.4.pqx
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
| Microsoft | 1.0.4 | UsernamePassword |

# Source files

* [AzureDatabaseForMySQL.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureDatabaseForMySQL.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureDatabaseForMySQL.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureDatabaseForMySQL.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L35) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureDatabaseForMySQL. [AzureDatabaseForMySQL.pq line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L58) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureDatabaseForMySQL.Database. [AzureDatabaseForMySQL.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureDatabaseForMySQL.pq line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L73) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AzureDatabaseForMySQL.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L12) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureDatabaseForMySQL.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L35) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AzureDatabaseForMySQL.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L12) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
