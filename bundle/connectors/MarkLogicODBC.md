---
type: Power Query Connector
title: MarkLogic
description: MarkLogic
tags: [usernamepassword]
x-pqkb-publisher: MarkLogic
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m
  title: MarkLogicODBC.m
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MarkLogicODBC/1.0.6/MarkLogicODBC_1.0.6.pqx
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
| MarkLogic | 1.0.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm)
* [MarkLogicODBC.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MarkLogicODBC.m line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MarkLogicODBC.m line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L5) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MarkLogicODBC.m line 94](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L94) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MarkLogicODBC. [MarkLogicODBC.m line 339](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L339) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MarkLogicODBC.Contents. [MarkLogicODBC.m line 89](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L89) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [MarkLogicODBC.m line 363](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L363) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [MarkLogicODBC.m line 370](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L370) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [MarkLogicODBC.m line 315](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L315) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MarkLogicODBC.m line 358](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L358) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [MarkLogicODBC.m line 132](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L132) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [MarkLogicODBC.m line 12](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L12) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [MarkLogicODBC.m line 464](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L464) |
