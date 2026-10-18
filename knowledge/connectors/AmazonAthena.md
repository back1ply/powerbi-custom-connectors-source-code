---
type: Power Query Connector
title: AmazonAthena
description: Connect to Athena
tags: [aad, credentials, implicit, native-query, navigation, odbc, packaging, schema]
publisher: Amazon
version: 1.2.8
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m
  title: AmazonAthena.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonAthena/1.2.8/AmazonAthena_1.2.8.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Amazon | 1.2.8 | Aad, Implicit |

# Source files

* [AmazonAthena.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AmazonAthena.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L53)
* [Native queries](../patterns/native-query.md): [AmazonAthena.m line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L129)
* [Navigation tables and connection checks](../patterns/navigation.md): [AmazonAthena.m line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L220)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [AmazonAthena.m line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L124)
* [Resources and modular source loading](../patterns/packaging.md): [AmazonAthena.m line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L76)
* [Schema and type enforcement](../patterns/schema.md): [AmazonAthena.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L18)
