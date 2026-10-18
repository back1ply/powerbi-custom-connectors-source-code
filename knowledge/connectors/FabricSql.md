---
type: Power Query Connector
title: SQL database
description: Import data from SQL database instances in Fabric
tags: [aad, buffering, credentials, diagnostics, errors, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 1.2.43
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq
  title: FabricSql.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm
  title: Utils.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FabricSql/1.2.43/FabricSql_1.2.43.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.2.43 | Aad |

# Source files

* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricEnvironment.pqm)
* [FabricSql.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L295)
* [Credential access](../patterns/credentials.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L131)
* [Diagnostic tracing](../patterns/diagnostics.md): [FabricSql.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L290), [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [FabricSql.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L50)
* [Resources and modular source loading](../patterns/packaging.md): [FabricSql.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L12), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L24)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L4)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L231)
* [Schema and type enforcement](../patterns/schema.md): [FabricSql.pq line 168](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L168)
* [Structured errors and HTTP status handling](../patterns/errors.md): [FabricSql.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L242), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L124)
* [Table.View handlers](../patterns/table-view.md): [FabricSql.pq line 272](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L272), [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L57)
