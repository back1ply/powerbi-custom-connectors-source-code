---
type: Power Query Connector
title: Azure Cost Management
description: Connect to Azure Cost Management
tags: [aad, credentials, diagnostics, errors, navigation, packaging, pagination, response-metadata, retry-polling, schema]
publisher: Microsoft
version: 1.0.42
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq
  title: AzureCostManagement.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCostManagement/1.0.42/AzureCostManagement_1.0.42.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.42 | Aad |

# Source files

* [AzureCostManagement.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ToNavigationTable.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AzureCostManagement.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L182)
* [Diagnostic tracing](../patterns/diagnostics.md): [AzureCostManagement.pq line 2445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L2445), [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [AzureCostManagement.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L155)
* [Page generation and cursor traversal](../patterns/pagination.md): [AzureCostManagement.pq line 2451](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L2451)
* [Resources and modular source loading](../patterns/packaging.md): [AzureCostManagement.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L117)
* [Response and pagination metadata](../patterns/response-metadata.md): [AzureCostManagement.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L191), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm#L12)
* [Retries, delays, and polling](../patterns/retry-polling.md): [AzureCostManagement.pq line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L186)
* [Schema and type enforcement](../patterns/schema.md): [AzureCostManagement.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L109), [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.GenerateByPage.pqm#L20), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AzureCostManagement.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L190), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm#L27)
