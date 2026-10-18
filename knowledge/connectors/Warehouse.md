---
type: Power Query Connector
title: Warehouse
description: Import Warehouse
tags: [aad, actions, buffering, credentials, diagnostics, errors, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 1.2.45
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm
  title: OutputInterceptor.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm
  title: Utils.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq
  title: Warehouse.pq
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm
  title: WarehouseOutputInterceptor.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Warehouse/1.2.45/Warehouse_1.2.45.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.2.45 | Aad |

# Source files

* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/FabricEnvironment.pqm)
* [OutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm)
* [Warehouse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq)
* [WarehouseOutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm)

# Detected patterns

* [Actions and table mutation handlers](../patterns/actions.md): [OutputInterceptor.pqm line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L128), [WarehouseOutputInterceptor.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L28)
* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L295), [WarehouseOutputInterceptor.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L69)
* [Credential access](../patterns/credentials.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L131)
* [Diagnostic tracing](../patterns/diagnostics.md): [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L56), [Warehouse.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L49), [WarehouseOutputInterceptor.pqm line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L119), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [Warehouse.pq line 379](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L379)
* [Resources and modular source loading](../patterns/packaging.md): [OutputInterceptor.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L46), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L47), [Warehouse.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L6), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L24)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L4)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L231)
* [Schema and type enforcement](../patterns/schema.md): [Warehouse.pq line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L194)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OutputInterceptor.pqm line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L110), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L66), [Warehouse.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L314), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L124)
* [Table.View handlers](../patterns/table-view.md): [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L57), [Warehouse.pq line 344](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L344), [WarehouseOutputInterceptor.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L54)
