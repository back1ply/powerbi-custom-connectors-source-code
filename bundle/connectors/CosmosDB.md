---
type: Power Query Connector
title: CosmosDB
description: Connect to CosmosDB using ODBC
tags: [aad, key]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m
  title: CosmosDB.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CosmosDB/1.0.9/CosmosDB_1.0.9.pqx
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
| Microsoft | 1.0.9 | Aad, Key |

# Source files

* [CosmosDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CosmosDB.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CosmosDB.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L5) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L135) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CosmosDB. [CosmosDB.m line 438](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L438) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CosmosDB.Contents. [CosmosDB.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L128) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CosmosDB.m line 515](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L515) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [CosmosDB.m line 388](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L388) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L135) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [CosmosDB.m line 470](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L470) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [CosmosDB.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L12) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [CosmosDB.m line 622](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L622) |
