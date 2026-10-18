---
type: Power Query Connector
title: Azure Resource Graph
description: Connect to Azure Resource Graph
tags: [aad, errors, navigation, packaging, pagination, response-metadata, retry-polling, schema]
publisher: Microsoft
version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq
  title: AzureResourceGraph.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureResourceGraph/1.0.6/AzureResourceGraph_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.6 | Aad |

# Source files

* [AzureResourceGraph.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [AzureResourceGraph.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L180)
* [Page generation and cursor traversal](../patterns/pagination.md): [AzureResourceGraph.pq line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L53)
* [Resources and modular source loading](../patterns/packaging.md): [AzureResourceGraph.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9)
* [Response and pagination metadata](../patterns/response-metadata.md): [AzureResourceGraph.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L56)
* [Retries, delays, and polling](../patterns/retry-polling.md): [AzureResourceGraph.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L59)
* [Schema and type enforcement](../patterns/schema.md): [AzureResourceGraph.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L5)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AzureResourceGraph.pq line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L94)
