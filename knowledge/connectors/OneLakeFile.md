---
type: Power Query Connector
title: OneLake Files
description: Power BI connector source for OneLake Files.
tags: [aad, buffering, credentials, diagnostics, errors, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 1.2.11
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq
  title: OneLakeFile.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeFile/1.2.11/OneLakeFile_1.2.11.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.2.11 | Aad |

# Source files

* [OneLakeFile.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L295)
* [Credential access](../patterns/credentials.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L431), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L131)
* [Diagnostic tracing](../patterns/diagnostics.md): [OneLakeFile.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L213), [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [OneLakeFile.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L44)
* [Resources and modular source loading](../patterns/packaging.md): [OneLakeFile.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L12), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L47), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L24)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L4)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L231)
* [Schema and type enforcement](../patterns/schema.md): [OneLakeFile.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L137)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OneLakeFile.pq line 177](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L177), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L124)
* [Table.View handlers](../patterns/table-view.md): [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L57)
