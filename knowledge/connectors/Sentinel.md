---
type: Power Query Connector
title: Sentinel
description: Power BI connector source for Sentinel.
tags: [aad, credentials, navigation, packaging, schema]
publisher: Microsoft
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq
  title: Sentinel.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Sentinel/1.0.2/Sentinel_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | Aad |

# Source files

* [Sentinel.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Sentinel.pq line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L105)
* [Navigation tables and connection checks](../patterns/navigation.md): [Sentinel.pq line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L126)
* [Resources and modular source loading](../patterns/packaging.md): [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L11)
* [Schema and type enforcement](../patterns/schema.md): [Sentinel.pq line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L119)
