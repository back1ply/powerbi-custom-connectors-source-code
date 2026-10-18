---
type: Power Query Connector
title: Attio
description: Power BI connector source for Attio.
tags: [credentials, key, navigation, packaging, pagination, response-metadata, schema]
publisher: Microsoft
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq
  title: Attio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Attio/1.0.0/Attio_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.0 | Key |

# Source files

* [Attio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L85)
* [Navigation tables and connection checks](../patterns/navigation.md): [Attio.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L145)
* [Page generation and cursor traversal](../patterns/pagination.md): [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L109)
* [Resources and modular source loading](../patterns/packaging.md): [Attio.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L151)
* [Response and pagination metadata](../patterns/response-metadata.md): [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L109)
* [Schema and type enforcement](../patterns/schema.md): [Attio.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L5)
