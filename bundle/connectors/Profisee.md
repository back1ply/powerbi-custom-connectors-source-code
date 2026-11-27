---
type: Power Query Connector
title: Profisee
description: Connect to Profisee, and get the data from Profisee data source
tags: [oauth]
x-pqkb-publisher: Profisee
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m
  title: Profisee.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm
  title: SchemaTransformTable.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Profisee/2.0.0/Profisee_2.0.0.pqx
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
| Profisee | 2.0.0 | OAuth |

# Source files

* [Profisee.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m)
* [SchemaTransformTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Profisee.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Profisee.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Profisee.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L8) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Profisee. [Profisee.m line 240](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L240) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Profisee.Tables. [Profisee.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Profisee.m line 255](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L255) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Profisee.m line 259](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L259) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Profisee.m line 64](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L64) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Profisee.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L8) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Profisee.m line 270](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L270) |
