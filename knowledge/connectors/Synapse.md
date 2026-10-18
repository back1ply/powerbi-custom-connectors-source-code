---
type: Power Query Connector
title: Azure Synapse Analytics workspace
description: Import data from Azure Synapse Analytics workspace
tags: [aad, credentials, diagnostics, errors, navigation, packaging, response-metadata, schema]
publisher: Microsoft
version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq
  title: Synapse.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Synapse/1.0.5/Synapse_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.5 | Aad |

# Source files

* [Synapse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Synapse.pq line 400](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L400)
* [Diagnostic tracing](../patterns/diagnostics.md): [Synapse.pq line 415](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L415)
* [Navigation tables and connection checks](../patterns/navigation.md): [Synapse.pq line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L90)
* [Resources and modular source loading](../patterns/packaging.md): [Synapse.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L45)
* [Response and pagination metadata](../patterns/response-metadata.md): [Synapse.pq line 352](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L352)
* [Schema and type enforcement](../patterns/schema.md): [Synapse.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L38)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Synapse.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L350)
