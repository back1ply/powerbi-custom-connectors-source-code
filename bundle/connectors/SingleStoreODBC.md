---
type: Power Query Connector
title: SingleStore Direct Query Connector
description: SingleStoreDirectQueryConnector
tags: [usernamepassword, windows]
x-pqkb-publisher: SingleStore
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m
  title: SingleStoreODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SingleStoreODBC/1.1.1/SingleStoreODBC_1.1.1.pqx
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
| SingleStore | 1.1.1 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/OdbcConstants.pqm)
* [SingleStoreODBC.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SingleStoreODBC.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SingleStoreODBC.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SingleStoreODBC.m line 81](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L81) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SingleStoreODBC. [SingleStoreODBC.m line 438](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L438) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SingleStoreODBC.Contents, SingleStoreODBC.DataSource, SingleStoreODBC.Database, SingleStoreODBC.Query. [SingleStoreODBC.m line 399](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L399) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [SingleStoreODBC.m line 467](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L467) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SingleStoreODBC.m line 474](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L474) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [SingleStoreODBC.m line 308](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L308) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SingleStoreODBC.m line 16](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L16) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [SingleStoreODBC.m line 153](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L153) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [SingleStoreODBC.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [SingleStoreODBC.m line 562](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L562) |
