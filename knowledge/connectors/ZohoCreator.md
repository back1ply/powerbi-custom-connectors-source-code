---
type: Power Query Connector
title: Zoho Creator
description: Connect to Zoho Creator
tags: [buffering, errors, navigation, oauth, oauth2, packaging, response-metadata, retry-polling, schema]
publisher: Zoho
version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m
  title: ZohoCreator.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZohoCreator/2.0.0/ZohoCreator_2.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Zoho | 2.0.0 | OAuth |

# Source files

* [ZohoCreator.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L62)
* [Navigation tables and connection checks](../patterns/navigation.md): [ZohoCreator.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L122)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [ZohoCreator.m line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L134)
* [Resources and modular source loading](../patterns/packaging.md): [ZohoCreator.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L15)
* [Response and pagination metadata](../patterns/response-metadata.md): [ZohoCreator.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L64)
* [Retries, delays, and polling](../patterns/retry-polling.md): [ZohoCreator.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L43)
* [Schema and type enforcement](../patterns/schema.md): [ZohoCreator.m line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L86)
* [Structured errors and HTTP status handling](../patterns/errors.md): [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L62)
