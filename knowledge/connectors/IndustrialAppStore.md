---
type: Power Query Connector
title: IndustrialConnector
description: Connect to IndustrialConnector
tags: [diagnostics, errors, navigation, oauth2, packaging, pkce, response-metadata, schema]
publisher: IntelligentPlant
version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq
  title: IndustrialAppStore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IndustrialAppStore/3.0.1/IndustrialAppStore_3.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| IntelligentPlant | 3.0.1 | Not declared |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/Diagnostics.pqm)
* [IndustrialAppStore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [IndustrialAppStore.pq line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L285)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [IndustrialAppStore.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L290)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [IndustrialAppStore.pq line 1169](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1169)
* [Resources and modular source loading](../patterns/packaging.md): [IndustrialAppStore.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L9)
* [Response and pagination metadata](../patterns/response-metadata.md): [IndustrialAppStore.pq line 1283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1283)
* [Schema and type enforcement](../patterns/schema.md): [IndustrialAppStore.pq line 477](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L477)
* [Structured errors and HTTP status handling](../patterns/errors.md): [IndustrialAppStore.pq line 383](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L383)
