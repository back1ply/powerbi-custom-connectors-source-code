---
type: Power Query Connector
title: MariaDB
description: Connect to MariaDB
tags: [usernamepassword]
x-pqkb-publisher: MariaDB
x-pqkb-version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m
  title: MariaDB.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MariaDB/1.0.7/MariaDB_1.0.7.pqx
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
| MariaDB | 1.0.7 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm)
* [MariaDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MariaDB.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MariaDB.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L30) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MariaDB. [MariaDB.m line 297](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L297) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MariaDB.Contents. [MariaDB.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L18) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [MariaDB.m line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L315) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [MariaDB.m line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L320) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [MariaDB.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L268) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L30) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [MariaDB.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L108) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [MariaDB.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [MariaDB.m line 573](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L573) |
