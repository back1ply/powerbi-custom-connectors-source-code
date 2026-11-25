---
type: Power Query Connector
title: ClickHouse
description: Connect to ClickHouse
tags: [credentials, diagnostics, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: ClickHouse
x-pqkb-version: 1.1.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq
  title: ClickHouseConnector.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ClickHouse/1.1.6/ClickHouse_1.1.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-02T11:27:27Z'
stale_after: '2026-11-16T11:27:27Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ClickHouse | 1.1.6 | UsernamePassword |

# Source files

* [ClickHouseConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [ClickHouseConnector.pq line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L252) — `Credential = Extension.CurrentCredential(),`
    * [ClickHouseConnector.pq line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L254) — `[UID = Credential[Username], PWD = Credential[Password]],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [ClickHouseConnector.pq line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L130) — `Documentation.FieldCaption = "Host",`
    * [ClickHouseConnector.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L123) — `shared ClickHouse.Database = Value.ReplaceType(DatabaseCoreImplementation, DatabaseType);`
    * [ClickHouseConnector.pq line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L128) — `DatabaseType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [ClickHouseConnector.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L367) — `OdbcDatasource = try Odbc.DataSource(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ClickHouseConnector.pq line 427](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L427) — `Label = Extension.LoadString("DataSourceLabel")`
