---
type: Power Query Connector
title: MariaDB
description: Connect to MariaDB
tags: [credentials, diagnostics, navigation, odbc, packaging, schema, usernamepassword]
publisher: MariaDB
version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m
  title: MariaDB.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MariaDB/1.0.7/MariaDB_1.0.7.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| MariaDB | 1.0.7 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/Diagnostics.pqm)
* [MariaDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [MariaDB.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L108)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [MariaDB.m line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L299)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [MariaDB.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L268)
* [Resources and modular source loading](../patterns/packaging.md): [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L30)
* [Schema and type enforcement](../patterns/schema.md): [MariaDB.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L19)
