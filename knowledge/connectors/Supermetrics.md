---
type: Power Query Connector
title: Supermetrics
description: Power BI connector source for Supermetrics.
tags: [buffering, credentials, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema]
publisher: Supermetrics
version: 3.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m
  title: Supermetrics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Supermetrics/3.3.0/Supermetrics_3.3.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Supermetrics | 3.3.0 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Icons.pqm)
* [Supermetrics.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Supermetrics.m line 334](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L334)
* [Credential access](../patterns/credentials.md): [Supermetrics.m line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L293)
* [Navigation tables and connection checks](../patterns/navigation.md): [Supermetrics.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L11)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Supermetrics.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L209)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Supermetrics.m line 184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L184)
* [Resources and modular source loading](../patterns/packaging.md): [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Icons.pqm#L3), [Supermetrics.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L7)
* [Response and pagination metadata](../patterns/response-metadata.md): [Supermetrics.m line 305](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L305)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Supermetrics.m line 282](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L282)
* [Schema and type enforcement](../patterns/schema.md): [Supermetrics.m line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L77)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Supermetrics.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L162)
