---
type: Power Query Connector
title: Windsor
description: Connect to Windsor
tags: [credentials, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, schema]
publisher: Windsor
version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq
  title: Windsor.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Windsor/1.0.4/Windsor_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Windsor | 1.0.4 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Icons.pqm)
* [Windsor.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Windsor.pq line 1057](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L1057)
* [Navigation tables and connection checks](../patterns/navigation.md): [Windsor.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L14)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Windsor.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L17)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Windsor.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L83)
* [Resources and modular source loading](../patterns/packaging.md): [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Icons.pqm#L3), [Windsor.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L10)
* [Response and pagination metadata](../patterns/response-metadata.md): [Windsor.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L191)
* [Schema and type enforcement](../patterns/schema.md): [Windsor.pq line 544](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L544)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Windsor.pq line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L136)
