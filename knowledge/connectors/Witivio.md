---
type: Power Query Connector
title: PQExtension1
description: Connect to PQExtension1
tags: [aad, navigation, packaging, pagination, response-metadata, schema]
publisher: Witivio
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq
  title: Witivio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Witivio/1.0.0/Witivio_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Witivio | 1.0.0 | Aad |

# Source files

* [Witivio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Witivio.pq line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L23)
* [Page generation and cursor traversal](../patterns/pagination.md): [Witivio.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L204)
* [Resources and modular source loading](../patterns/packaging.md): [Witivio.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L55)
* [Response and pagination metadata](../patterns/response-metadata.md): [Witivio.pq line 207](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L207)
* [Schema and type enforcement](../patterns/schema.md): [Witivio.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L150)
