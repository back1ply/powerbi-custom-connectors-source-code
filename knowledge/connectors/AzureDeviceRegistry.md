---
type: Power Query Connector
title: Azure Device Registry (ADR)
description: Connect to AzureDeviceRegistry
tags: [aad, diagnostics, errors, navigation, packaging, response-metadata, retry-polling, schema]
publisher: Microsoft
version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq
  title: AzureDeviceRegistry.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/CommonFunctions.pqm
  title: CommonFunctions.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/QueryHelper.pqm
  title: QueryHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureDeviceRegistry/1.0.3/AzureDeviceRegistry_1.0.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.3 | Aad |

# Source files

* [AzureDeviceRegistry.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq)
* [CommonFunctions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/CommonFunctions.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/Diagnostics.pqm)
* [QueryHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/QueryHelper.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/Diagnostics.pqm#L5)
* [Navigation tables and connection checks](../patterns/navigation.md): [AzureDeviceRegistry.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L40)
* [Resources and modular source loading](../patterns/packaging.md): [AzureDeviceRegistry.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L47)
* [Response and pagination metadata](../patterns/response-metadata.md): [AzureDeviceRegistry.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L150)
* [Retries, delays, and polling](../patterns/retry-polling.md): [AzureDeviceRegistry.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L155)
* [Schema and type enforcement](../patterns/schema.md): [AzureDeviceRegistry.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L116), [CommonFunctions.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L23)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AzureDeviceRegistry.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L214)
