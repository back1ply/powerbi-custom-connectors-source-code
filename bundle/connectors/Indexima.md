---
type: Power Query Connector
title: Indexima
description: Connect to Indexima Data Hub
tags: [usernamepassword]
x-pqkb-publisher: Indexima
x-pqkb-version: 1.7.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m
  title: Indexima.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Indexima/1.7.6/Indexima_1.7.6.pqx
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
| Indexima | 1.7.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm)
* [Indexima.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Indexima.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L23) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Indexima.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L22) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L39) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Indexima. [Indexima.m line 275](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L275) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Indexima.Database. [Indexima.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L33) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Indexima.m line 257](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L257) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Indexima.m line 261](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L261) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Indexima.m line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L250) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L39) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Indexima.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L105) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Indexima.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L30) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Indexima.m line 300](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L300) |
