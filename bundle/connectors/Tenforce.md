---
type: Power Query Connector
title: Tenforce (Smart)List
description: Connect to Tenforce
tags: [usernamepassword, windows]
x-pqkb-publisher: TenForce
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m
  title: Tenforce.m
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/TypeMappingTable.pqm
  title: TypeMappingTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Tenforce/1.0.4/Tenforce_1.0.4.pqx
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
| TenForce | 1.0.4 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ChangeType.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm)
* [Tenforce.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m)
* [TypeMappingTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/TypeMappingTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Tenforce.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Tenforce.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Tenforce.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L57) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Tenforce. [Tenforce.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L12) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Tenforce.Contents. [Tenforce.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Tenforce.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L33) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Tenforce.m line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L37) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Table.ToNavigationTable.pqm#L14) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Tenforce.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L25) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Tenforce.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L6) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Tenforce.m line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Tenforce/Tenforce.m#L314) |
