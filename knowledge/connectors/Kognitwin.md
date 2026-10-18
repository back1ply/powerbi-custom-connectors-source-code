---
type: Power Query Connector
title: Kognitwin
description: Connect to Kognitwin
tags: [errors, navigation, oauth, oauth2, packaging, pagination, pkce, response-metadata, schema]
publisher: Kongsberg
version: 2.5.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq
  title: Kognitwin.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kognitwin/2.5.0/Kognitwin_2.5.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Kongsberg | 2.5.0 | OAuth |

# Source files

* [Kognitwin.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Kognitwin.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L81)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Kognitwin.pq line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L114)
* [Page generation and cursor traversal](../patterns/pagination.md): [Kognitwin.pq line 809](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L809)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Kognitwin.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L138)
* [Resources and modular source loading](../patterns/packaging.md): [Kognitwin.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L121)
* [Response and pagination metadata](../patterns/response-metadata.md): [Kognitwin.pq line 813](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L813)
* [Schema and type enforcement](../patterns/schema.md): [Kognitwin.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L100)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Kognitwin.pq line 229](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L229)
