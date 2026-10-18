---
type: Power Query Connector
title: ADPAnalytics
description: Connect to ADPAnalytics
tags: [credentials, errors, navigation, oauth, oauth2, packaging, response-metadata, schema]
publisher: ADP
version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m
  title: ADPAnalytics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ADPAnalytics/1.0.3/ADPAnalytics_1.0.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ADP | 1.0.3 | OAuth |

# Source files

* [ADPAnalytics.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [ADPAnalytics.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L98)
* [Navigation tables and connection checks](../patterns/navigation.md): [ADPAnalytics.m line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L77)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [ADPAnalytics.m line 238](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L238)
* [Resources and modular source loading](../patterns/packaging.md): [ADPAnalytics.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L5)
* [Response and pagination metadata](../patterns/response-metadata.md): [ADPAnalytics.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L23)
* [Schema and type enforcement](../patterns/schema.md): [ADPAnalytics.m line 233](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L233)
* [Structured errors and HTTP status handling](../patterns/errors.md): [ADPAnalytics.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L20)
