---
type: Power Query Connector
title: CosmosDB
description: Connect to CosmosDB using ODBC
tags: [aad, credentials, diagnostics, errors, key, navigation, odbc, packaging, schema]
publisher: Microsoft
version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m
  title: CosmosDB.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CosmosDB/1.0.9/CosmosDB_1.0.9.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.9 | Aad, Key |

# Source files

* [CosmosDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [CosmosDB.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L215)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [CosmosDB.m line 447](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L447)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [CosmosDB.m line 388](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L388)
* [Resources and modular source loading](../patterns/packaging.md): [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L135)
* [Schema and type enforcement](../patterns/schema.md): [CosmosDB.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L132)
* [Structured errors and HTTP status handling](../patterns/errors.md): [CosmosDB.m line 410](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L410)
