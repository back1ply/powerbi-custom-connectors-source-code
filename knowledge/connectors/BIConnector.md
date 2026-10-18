---
type: Power Query Connector
title: BIConnector
description: Import data from OBIEE Server.
tags: [credentials, navigation, odbc, packaging, schema, usernamepassword]
publisher: Microsoft
version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq
  title: BIConnector.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BIConnector/1.1.0/BIConnector_1.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.1.0 | UsernamePassword |

# Source files

* [BIConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [BIConnector.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [BIConnector.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L83)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [BIConnector.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L39)
* [Resources and modular source loading](../patterns/packaging.md): [BIConnector.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L98)
* [Schema and type enforcement](../patterns/schema.md): [BIConnector.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L12)
