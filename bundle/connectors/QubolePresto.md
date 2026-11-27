---
type: Power Query Connector
title: QubolePresto
description: Connect to QubolePresto
tags: [implicit]
x-pqkb-publisher: Qubole
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m
  title: QubolePresto.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QubolePresto/1.0.1/QubolePresto_1.0.1.pqx
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
| Qubole | 1.0.1 | Implicit |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/OdbcConstants.pqm)
* [QubolePresto.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [QubolePresto.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [QubolePresto.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for QubolePresto. [QubolePresto.m line 209](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L209) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: QubolePresto.Contents. [QubolePresto.m line 74](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L74) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [QubolePresto.m line 226](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L226) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [QubolePresto.m line 231](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L231) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [QubolePresto.m line 190](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L190) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [QubolePresto.m line 221](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L221) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [QubolePresto.m line 92](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L92) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [QubolePresto.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [QubolePresto.m line 324](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L324) |
