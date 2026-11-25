---
type: Power Query Connector
title: Warehouse
description: Import Warehouse
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.2.48
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm
  title: OutputInterceptor.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm
  title: Utils.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq
  title: Warehouse.pq
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm
  title: WarehouseOutputInterceptor.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Warehouse/1.2.48/Warehouse_1.2.48.pqx
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
| Microsoft | 1.2.48 | Aad |

# Source files

* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/FabricEnvironment.pqm)
* [OutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm)
* [Warehouse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq)
* [WarehouseOutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Warehouse.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Warehouse.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Warehouse.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L213) |
| Have a TestConnection handler. | MUST | Pass | No TestConnection in Warehouse; tests through a Table.View OnTestConnection handler. [Warehouse.pq line 286](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L286) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function Fabric.Warehouse (kind Warehouse) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [Warehouse.pq line 193](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L193) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Warehouse.pq line 419](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L419) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Warehouse.pq line 356](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L356) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L47) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L432) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L68) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Warehouse.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L4) |
