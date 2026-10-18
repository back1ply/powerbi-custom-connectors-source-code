---
type: Power Query Connector
title: LEAP
description: Connect to LEAP
tags: [buffering, credentials, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema]
publisher: LEAP
version: 1.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m
  title: LEAP.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LEAP/1.3.0/LEAP_1.3.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| LEAP | 1.3.0 | OAuth |

# Source files

* [LEAP.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [LEAP.m line 743](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L743)
* [Credential access](../patterns/credentials.md): [LEAP.m line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L99)
* [Navigation tables and connection checks](../patterns/navigation.md): [LEAP.m line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L72)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [LEAP.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L75)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [LEAP.m line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L176)
* [Resources and modular source loading](../patterns/packaging.md): [LEAP.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L47)
* [Response and pagination metadata](../patterns/response-metadata.md): [LEAP.m line 602](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L602)
* [Retries, delays, and polling](../patterns/retry-polling.md): [LEAP.m line 725](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L725)
* [Schema and type enforcement](../patterns/schema.md): [LEAP.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L41)
* [Structured errors and HTTP status handling](../patterns/errors.md): [LEAP.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L105)
