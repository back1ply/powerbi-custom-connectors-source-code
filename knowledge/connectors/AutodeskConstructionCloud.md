---
type: Power Query Connector
title: Autodesk Construction Cloud
description: Connect to Autodesk Construction Cloud
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, pagination, pkce, response-metadata, retry-polling, schema]
publisher: Autodesk
version: 1.8.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq
  title: AutodeskConstructionCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/Diagnostics.pqm
  title: Diagnostics.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutodeskConstructionCloud/1.8.1/AutodeskConstructionCloud_1.8.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Autodesk | 1.8.1 | OAuth |

# Source files

* [AutodeskConstructionCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/Diagnostics.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [AutodeskConstructionCloud.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L124)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [AutodeskConstructionCloud.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L47)
* [Page generation and cursor traversal](../patterns/pagination.md): [AutodeskConstructionCloud.pq line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L299)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [AutodeskConstructionCloud.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L65)
* [Resources and modular source loading](../patterns/packaging.md): [AutodeskConstructionCloud.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L5)
* [Response and pagination metadata](../patterns/response-metadata.md): [AutodeskConstructionCloud.pq line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L302)
* [Retries, delays, and polling](../patterns/retry-polling.md): [AutodeskConstructionCloud.pq line 348](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L348)
* [Schema and type enforcement](../patterns/schema.md): [AutodeskConstructionCloud.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L142)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AutodeskConstructionCloud.pq line 106](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L106)
