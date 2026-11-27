---
type: Power Query Connector
title: Actian
description: Connect to Actian X Vector, Avalanche, or Ingres
tags: [usernamepassword, windows]
x-pqkb-publisher: Actian
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m
  title: Actian.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Actian/1.0.1/Actian_1.0.1.pqx
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
| Actian | 1.0.1 | UsernamePassword, Windows |

# Source files

* [Actian.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Actian.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Actian.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Actian. [Actian.m line 244](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L244) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Actian.Contents. [Actian.m line 86](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L86) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Actian.m line 276](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L276) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Actian.m line 281](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L281) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Actian.m line 218](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L218) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Actian.m line 278](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L278) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Actian.m line 117](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L117) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Actian.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Actian.m line 371](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L371) |
