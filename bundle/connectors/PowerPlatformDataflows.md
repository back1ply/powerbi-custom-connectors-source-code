---
type: Power Query Connector
title: Dataflows
description: Import data from a dataflow
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.1.35
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm
  title: Cdsa.Workspace.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm
  title: Fabric.GetClusterUrl.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq
  title: PowerPlatformDataflows.pq
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm
  title: Utils.pqm
- id: file-8
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-9
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PowerPlatformDataflows/3.1.35/PowerPlatformDataflows_3.1.35.pqx
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
| Microsoft | 3.1.35 | Aad |

# Source files

* [Cdsa.Workspace.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm)
* [Fabric.GetClusterUrl.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm)
* [PowerPlatformDataflows.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm)
* [Utils.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [PowerPlatformDataflows.pq line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L13) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [PowerPlatformDataflows.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [PowerPlatformDataflows.pq line 150](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L150) |
| Have a TestConnection handler. | MUST | Pass | No TestConnection in PowerPlatformDataflows; tests through a Table.View OnTestConnection handler. [PowerPlatformDataflows.pq line 1774](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1774) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function PowerPlatform.Dataflows (kind PowerPlatformDataflows) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [PowerPlatformDataflows.pq line 143](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L143) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [PowerPlatformDataflows.pq line 1783](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1783) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Cdsa.Workspace.pqm line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L5) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [PowerPlatformDataflows.pq line 150](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L150) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Fabric.GetClusterUrl.pqm line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L13) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Cdsa.Workspace.pqm line 28](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L28) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Review | GetEntityFromAccessor evaluates an expression not loaded from the package. [PowerPlatformDataflows.pq line 1247](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1247) |
