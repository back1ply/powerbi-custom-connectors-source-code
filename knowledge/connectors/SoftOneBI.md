---
type: Power Query Connector
title: SoftOne BI
description: Connect to Soft1 / Atlantis
tags: [buffering, credentials, errors, navigation, oauth, oauth2, packaging, response-metadata, schema, web-requests]
publisher: SoftOne
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m
  title: SoftOneBI.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SoftOneBI/1.0.0/SoftOneBI_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SoftOne | 1.0.0 | OAuth |

# Source files

* [SoftOneBI.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [SoftOneBI.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L98)
* [Credential access](../patterns/credentials.md): [SoftOneBI.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L43)
* [Navigation tables and connection checks](../patterns/navigation.md): [SoftOneBI.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L50)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [SoftOneBI.m line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L219)
* [Resources and modular source loading](../patterns/packaging.md): [SoftOneBI.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L17)
* [Response and pagination metadata](../patterns/response-metadata.md): [SoftOneBI.m line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L178)
* [Schema and type enforcement](../patterns/schema.md): [SoftOneBI.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L25)
* [Structured errors and HTTP status handling](../patterns/errors.md): [SoftOneBI.m line 148](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L148)
* [Web requests and relative paths](../patterns/web-requests.md): [SoftOneBI.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L121)
