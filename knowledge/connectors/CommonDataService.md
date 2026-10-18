---
type: Power Query Connector
title: Dataverse
description: Connect to Dataverse through its SQL endpoint
tags: [aad, errors, native-query, navigation, packaging, response-metadata, schema, table-view]
publisher: Microsoft
version: 1.1.17
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq
  title: CommonDataService.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CommonDataService/1.1.17/CommonDataService_1.1.17.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.1.17 | Aad |

# Source files

* [CommonDataService.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq)

# Detected patterns

* [Native queries](../patterns/native-query.md): [CommonDataService.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L80)
* [Navigation tables and connection checks](../patterns/navigation.md): [CommonDataService.pq line 327](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L327)
* [Resources and modular source loading](../patterns/packaging.md): [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L98)
* [Response and pagination metadata](../patterns/response-metadata.md): [CommonDataService.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L211)
* [Schema and type enforcement](../patterns/schema.md): [CommonDataService.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L62)
* [Structured errors and HTTP status handling](../patterns/errors.md): [CommonDataService.pq line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L202)
* [Table.View handlers](../patterns/table-view.md): [CommonDataService.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L74)
