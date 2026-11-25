---
type: Power Query Connector
title: JethroDataConnector
description: Connect to JethroDataConnector
tags: [usernamepassword]
x-pqkb-publisher: Jethro
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m
  title: JethroODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JethroData/1.0.2/JethroData_1.0.2.pqx
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
| Jethro | 1.0.2 | UsernamePassword |

# Source files

* [JethroODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [JethroODBC.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [JethroODBC.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for JethroODBC. [JethroODBC.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L105) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: JethroODBC.Database. [JethroODBC.m line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L10) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [JethroODBC.m line 120](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L120) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [JethroODBC.m line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L125) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [JethroODBC.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L38) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [JethroODBC.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L122) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [JethroODBC.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L27) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
