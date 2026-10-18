---
type: Power Query Connector
title: ClickHouse
description: Connect to ClickHouse
tags: [credentials, diagnostics, errors, navigation, odbc, packaging, schema, usernamepassword]
publisher: ClickHouse
version: 1.1.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq
  title: ClickHouseConnector.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ClickHouse/1.1.6/ClickHouse_1.1.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ClickHouse | 1.1.6 | UsernamePassword |

# Source files

* [ClickHouseConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [ClickHouseConnector.pq line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L252)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [ClickHouseConnector.pq line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L411)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [ClickHouseConnector.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L367)
* [Resources and modular source loading](../patterns/packaging.md): [ClickHouseConnector.pq line 427](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L427)
* [Schema and type enforcement](../patterns/schema.md): [ClickHouseConnector.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L123)
* [Structured errors and HTTP status handling](../patterns/errors.md): [ClickHouseConnector.pq line 488](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L488)
