---
type: Power Query Connector
title: MongoDB Atlas SQL
description: Connect to MongoDB Atlas SQL
tags: [credentials, diagnostics, errors, navigation, odbc, packaging, schema, usernamepassword]
publisher: MongoDBAtlasODBC
version: 1.2.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq
  title: MongoDBAtlasODBC.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MongoDBAtlasODBC/1.2.4/MongoDBAtlasODBC_1.2.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| MongoDBAtlasODBC | 1.2.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/Diagnostics.pqm)
* [MongoDBAtlasODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [MongoDBAtlasODBC.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L55)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [MongoDBAtlasODBC.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L125)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [MongoDBAtlasODBC.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L47)
* [Resources and modular source loading](../patterns/packaging.md): [MongoDBAtlasODBC.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L142)
* [Schema and type enforcement](../patterns/schema.md): [MongoDBAtlasODBC.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L13)
* [Structured errors and HTTP status handling](../patterns/errors.md): [MongoDBAtlasODBC.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L17)
