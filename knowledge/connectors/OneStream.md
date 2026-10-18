---
type: Power Query Connector
title: OneStream
description: Connect to OneStream
tags: [errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, web-requests]
publisher: OneStream
version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq
  title: OneStream.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneStream/1.0.4/OneStream_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| OneStream | 1.0.4 | OAuth |

# Source files

* [OneStream.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [OneStream.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L74)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [OneStream.pq line 837](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L837)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [OneStream.pq line 862](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L862)
* [Resources and modular source loading](../patterns/packaging.md): [OneStream.pq line 842](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L842)
* [Response and pagination metadata](../patterns/response-metadata.md): [OneStream.pq line 808](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L808)
* [Retries, delays, and polling](../patterns/retry-polling.md): [OneStream.pq line 768](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L768)
* [Schema and type enforcement](../patterns/schema.md): [OneStream.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L45)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OneStream.pq line 779](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L779)
* [Web requests and relative paths](../patterns/web-requests.md): [OneStream.pq line 792](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L792)
