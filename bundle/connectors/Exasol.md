---
type: Power Query Connector
title: Exasol
description: Connect to Exasol
tags: [implicit, usernamepassword, windows]
x-pqkb-publisher: Exasol
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq
  title: Exasol.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Exasol/1.1.1/Exasol_1.1.1.pqx
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
| Exasol | 1.1.1 | Implicit, UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Diagnostics.pqm)
* [Exasol.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Exasol.pq line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Exasol.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Exasol.pq line 51](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L51) |
| Have a TestConnection handler. | MUST | Review | No data source kind found. |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Review | No shared function with a data source kind found. |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Exasol.pq line 241](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L241) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Exasol.pq line 113](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L113) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Exasol.pq line 230](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L230) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Exasol.pq line 85](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L85) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Exasol/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
