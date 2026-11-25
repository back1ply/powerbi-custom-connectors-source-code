---
type: Power Query Connector
title: Kyvos ODBC
description: Kyvos ODBC
tags: [oauth, usernamepassword]
x-pqkb-publisher: Kyvos
x-pqkb-version: 1.0.8
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq
  title: KyvosODBC.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/KyvosODBC/1.0.8/KyvosODBC_1.0.8.pqx
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
| Kyvos | 1.0.8 | OAuth, UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm)
* [KyvosODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [KyvosODBC.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [KyvosODBC.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L5) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [KyvosODBC.pq line 348](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L348) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for KyvosODBC. [KyvosODBC.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L279) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: KyvosODBC.Databases. [KyvosODBC.pq line 275](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L275) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [KyvosODBC.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L314) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [KyvosODBC.pq line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L320) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [KyvosODBC.pq line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L517) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [KyvosODBC.pq line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L309) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [KyvosODBC.pq line 399](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L399) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [KyvosODBC.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L12) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [KyvosODBC.pq line 639](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L639) |
