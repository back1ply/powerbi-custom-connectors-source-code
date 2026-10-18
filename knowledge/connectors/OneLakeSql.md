---
type: Power Query Connector
title: OneLakeSql
description: Power BI connector source for OneLakeSql.
tags: [aad, buffering, credentials, diagnostics, errors, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 1.0.24
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq
  title: OneLakeSql.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeSql/1.0.24/OneLakeSql_1.0.24.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.24 | Aad |

# Source files

* [OneLakeSql.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L295)
* [Credential access](../patterns/credentials.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L131)
* [Diagnostic tracing](../patterns/diagnostics.md): [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [OneLakeSql.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L44)
* [Resources and modular source loading](../patterns/packaging.md): [OneLakeSql.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L11), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L24)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L4)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L231)
* [Schema and type enforcement](../patterns/schema.md): [OneLakeSql.pq line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L131)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OneLakeSql.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L115), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L124)
* [Table.View handlers](../patterns/table-view.md): [OneLakeSql.pq line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L244), [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L57)
