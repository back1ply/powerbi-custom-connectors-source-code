---
type: Power Query Connector
title: InterSystems IRIS
description: Connect to InterSystems IRIS
tags: [usernamepassword]
x-pqkb-publisher: InterSystems
x-pqkb-version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m
  title: Iris_PowerBI_Connector.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IRIS/1.1.2/IRIS_1.1.2.pqx
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
| InterSystems | 1.1.2 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm)
* [Iris_PowerBI_Connector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Iris_PowerBI_Connector.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Iris_PowerBI_Connector.m line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Iris_PowerBI_Connector.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L36) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for IRIS. [Iris_PowerBI_Connector.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L16) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: IRIS.Database. [Iris_PowerBI_Connector.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L13) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Iris_PowerBI_Connector.m line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L176) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Iris_PowerBI_Connector.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L17) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Iris_PowerBI_Connector.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L81) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Iris_PowerBI_Connector.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Iris_PowerBI_Connector.m line 263](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L263) |
