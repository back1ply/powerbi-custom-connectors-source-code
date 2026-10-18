---
type: Power Query Connector
title: Amazon OpenSearch Service
description: Connect to OpenSearch
tags: [credentials, diagnostics, errors, implicit, key, navigation, odbc, packaging, schema, usernamepassword]
publisher: Amazon
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m
  title: AmazonOpenSearchService.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonOpenSearchService/1.0.1/AmazonOpenSearchService_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Amazon | 1.0.1 | Implicit, Key, UsernamePassword |

# Source files

* [AmazonOpenSearchService.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AmazonOpenSearchService.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L38)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [AmazonOpenSearchService.m line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L183)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [AmazonOpenSearchService.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L154)
* [Resources and modular source loading](../patterns/packaging.md): [AmazonOpenSearchService.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L222)
* [Schema and type enforcement](../patterns/schema.md): [AmazonOpenSearchService.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L12)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AmazonOpenSearchService.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L174)
