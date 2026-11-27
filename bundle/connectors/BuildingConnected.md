---
type: Power Query Connector
title: BuildingConnected & TradeTapp
description: Connect to BuildingConnected & TradeTapp
tags: [oauth]
x-pqkb-publisher: Autodesk
x-pqkb-version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq
  title: BuildingConnected.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Schemas.pqm
  title: Schemas.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BuildingConnected/1.0.7/BuildingConnected_1.0.7.pqx
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
| Autodesk | 1.0.7 | OAuth |

# Source files

* [BuildingConnected.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm)
* [Schemas.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Schemas.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [BuildingConnected.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [BuildingConnected.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [BuildingConnected.pq line 181](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L181) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for BuildingConnected. [BuildingConnected.pq line 98](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L98) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: BuildingConnected.Contents. [BuildingConnected.pq line 175](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L175) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [BuildingConnected.pq line 541](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L541) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [BuildingConnected.pq line 545](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L545) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [BuildingConnected.pq line 223](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L223) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [BuildingConnected.pq line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L6) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [BuildingConnected.pq line 145](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L145) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [BuildingConnected.pq line 533](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L533) |
