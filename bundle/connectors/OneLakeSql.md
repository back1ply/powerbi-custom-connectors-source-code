---
type: Power Query Connector
title: OneLakeSql
description: Power BI connector source for OneLakeSql.
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.26
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq
  title: OneLakeSql.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeSql/1.0.26/OneLakeSql_1.0.26.pqx
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
| Microsoft | 1.0.26 | Aad |

# Source files

* [OneLakeSql.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [OneLakeSql.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [OneLakeSql.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [OneLakeSql.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L138) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for OneLakeSql. [OneLakeSql.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L40) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function OneLake.SqlAnalytics (kind OneLakeSql) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [OneLakeSql.pq line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L130) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [OneLakeSql.pq line 338](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L338) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [OneLakeSql.pq line 345](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L345) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [OneLakeSql.pq line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L241) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [OneLakeSql.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L115) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L432) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L68) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [OneLakeSql.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L9) |
