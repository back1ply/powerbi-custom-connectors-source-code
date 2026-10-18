---
type: Power Query Connector
title: Dataflows
description: Import data from a dataflow
tags: [aad, buffering, credentials, diagnostics, errors, native-query, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 3.1.33
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm
  title: Cdsa.Workspace.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm
  title: Fabric.GetClusterUrl.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq
  title: PowerPlatformDataflows.pq
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm
  title: Utils.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PowerPlatformDataflows/3.1.33/PowerPlatformDataflows_3.1.33.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 3.1.33 | Aad |

# Source files

* [Cdsa.Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm)
* [Fabric.GetClusterUrl.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm)
* [PowerPlatformDataflows.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L295)
* [Credential access](../patterns/credentials.md): [Fabric.GetClusterUrl.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L13), [PowerPlatformDataflows.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L217), [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L131)
* [Diagnostic tracing](../patterns/diagnostics.md): [Cdsa.Workspace.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L28), [Fabric.GetClusterUrl.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L26), [PowerPlatformDataflows.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L230), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L41)
* [Native queries](../patterns/native-query.md): [PowerPlatformDataflows.pq line 1727](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1727)
* [Navigation tables and connection checks](../patterns/navigation.md): [Cdsa.Workspace.pqm line 243](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L243), [PowerPlatformDataflows.pq line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L197)
* [Resources and modular source loading](../patterns/packaging.md): [PowerPlatformDataflows.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L150), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L50)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L12), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L4)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L231)
* [Schema and type enforcement](../patterns/schema.md): [PowerPlatformDataflows.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L144), [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L58), [Table.ToNavigationTable.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm#L32)
* [Structured errors and HTTP status handling](../patterns/errors.md): [PowerPlatformDataflows.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L249), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L27), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L48)
* [Table.View handlers](../patterns/table-view.md): [PowerPlatformDataflows.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L175), [Table.NavigationTableView.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L47)
