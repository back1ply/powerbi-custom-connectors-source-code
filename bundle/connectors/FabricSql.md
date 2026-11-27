---
type: Power Query Connector
title: SQL database in Fabric
description: Import data from SQL database items in Fabric
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.2.47
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq
  title: FabricSql.pq
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Utils.pqm
  title: Utils.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-7
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FabricSql/1.2.47/FabricSql_1.2.47.pqx
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
| Microsoft | 1.2.47 | Aad |

# Source files

* [FabricEnvironment.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricEnvironment.pqm)
* [FabricSql.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Workspace.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [FabricSql.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [FabricSql.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [FabricSql.pq line 173](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L173) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for FabricSql. [FabricSql.pq line 46](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L46) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: FabricSql.Contents. [FabricSql.pq line 167](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L167) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [FabricSql.pq line 342](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L342) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [FabricSql.pq line 349](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L349) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [FabricSql.pq line 335](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L335) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [FabricSql.pq line 173](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L173) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Utils.pqm line 432](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/Utils.pqm#L432) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [FabricSql.pq line 290](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L290) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [FabricSql.pq line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FabricSql/FabricSql.pq#L10) |
