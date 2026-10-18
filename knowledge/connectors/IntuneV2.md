---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad, errors, navigation, odata, packaging, schema]
publisher: Microsoft
version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq
  title: IntuneV2.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneV2/2.0.0/IntuneV2_2.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 2.0.0 | Aad |

# Source files

* [IntuneV2.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [IntuneV2.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L63)
* [OData feeds](../patterns/odata.md): [IntuneV2.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L56)
* [Resources and modular source loading](../patterns/packaging.md): [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L14)
* [Schema and type enforcement](../patterns/schema.md): [IntuneV2.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L9)
* [Structured errors and HTTP status handling](../patterns/errors.md): [IntuneV2.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L59)
