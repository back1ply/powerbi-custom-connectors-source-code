---
type: Power Query Connector
title: MicrostrategyDataset
description: Import data from Strategy Dataset
tags: [buffering, credentials, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, table-view, usernamepassword]
publisher: MicroStrategy
version: 2.5.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m
  title: MicroStrategyDataset.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrostrategyDataset/2.5.0/MicrostrategyDataset_2.5.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| MicroStrategy | 2.5.0 | OAuth, UsernamePassword |

# Source files

* [MicroStrategyDataset.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [MicroStrategyDataset.m line 648](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L648)
* [Credential access](../patterns/credentials.md): [MicroStrategyDataset.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L102)
* [Navigation tables and connection checks](../patterns/navigation.md): [MicroStrategyDataset.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L22)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [MicroStrategyDataset.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L36)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [MicroStrategyDataset.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L192)
* [Resources and modular source loading](../patterns/packaging.md): [MicroStrategyDataset.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L9)
* [Response and pagination metadata](../patterns/response-metadata.md): [MicroStrategyDataset.m line 889](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L889)
* [Retries, delays, and polling](../patterns/retry-polling.md): [MicroStrategyDataset.m line 1473](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1473)
* [Schema and type enforcement](../patterns/schema.md): [MicroStrategyDataset.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L18)
* [Structured errors and HTTP status handling](../patterns/errors.md): [MicroStrategyDataset.m line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1011)
* [Table.View handlers](../patterns/table-view.md): [MicroStrategyDataset.m line 496](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L496)
