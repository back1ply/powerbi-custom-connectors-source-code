---
type: Power Query Connector
title: Dremio
description: Import data from Dremio.
tags: [aad, anonymous, buffering, credentials, diagnostics, errors, key, navigation, odbc, packaging, response-metadata, schema, table-view, usernamepassword]
publisher: Dremio
version: 3.16.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/CACerts.pqm
  title: CACerts.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DataTransform.pqm
  title: DataTransform.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq
  title: Dremio.pq
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm
  title: DremioAdbcDataSource.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm
  title: DremioAdbcOptions.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioOAuthDiscovery.pqm
  title: DremioOAuthDiscovery.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/FlightSqlAdbcConfig.pqm
  title: FlightSqlAdbcConfig.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGenerator.pqm
  title: SqlGenerator.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Dremio/3.16.1/Dremio_3.16.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Dremio | 3.16.1 | Aad, Anonymous, Key, UsernamePassword |

# Source files

* [CACerts.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/CACerts.pqm)
* [DataTransform.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DataTransform.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Diagnostics.pqm)
* [Dremio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq)
* [DremioAdbcDataSource.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm)
* [DremioAdbcOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm)
* [DremioOAuthDiscovery.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioOAuthDiscovery.pqm)
* [FlightSqlAdbcConfig.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/FlightSqlAdbcConfig.pqm)
* [SqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGenerator.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGeneratorCommon.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [DremioAdbcDataSource.pqm line 448](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L448)
* [Credential access](../patterns/credentials.md): [Dremio.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L13), [DremioAdbcDataSource.pqm line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L115)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Diagnostics.pqm#L3), [Dremio.pq line 1047](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L1047)
* [Navigation tables and connection checks](../patterns/navigation.md): [Dremio.pq line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L41)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Dremio.pq line 904](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L904)
* [Resources and modular source loading](../patterns/packaging.md): [Dremio.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L72), [DremioAdbcDataSource.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L8), [DremioAdbcOptions.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm#L8), [SqlGenerator.pqm line 1004](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGenerator.pqm#L1004)
* [Response and pagination metadata](../patterns/response-metadata.md): [SqlGeneratorCommon.pqm line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGeneratorCommon.pqm#L296)
* [Schema and type enforcement](../patterns/schema.md): [DataTransform.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DataTransform.pqm#L12), [Dremio.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L214)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Dremio.pq line 961](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L961), [DremioAdbcDataSource.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L15), [DremioAdbcOptions.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm#L45), [DremioOAuthDiscovery.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioOAuthDiscovery.pqm#L55)
* [Table.View handlers](../patterns/table-view.md): [DremioAdbcDataSource.pqm line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L293)
