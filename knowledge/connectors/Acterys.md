---
type: Power Query Connector
title: 'Acterys : Model Automation & Planning'
description: Connect to Acterys
tags: [aad, credentials, navigation, packaging, retry-polling, schema]
publisher: Managility
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq
  title: Acterys.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Acterys/1.0.0/Acterys_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Managility | 1.0.0 | Aad |

# Source files

* [Acterys.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Acterys.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L8)
* [Navigation tables and connection checks](../patterns/navigation.md): [Acterys.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L57)
* [Resources and modular source loading](../patterns/packaging.md): [Acterys.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L219)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Acterys.pq line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L67)
* [Schema and type enforcement](../patterns/schema.md): [Acterys.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L204)
