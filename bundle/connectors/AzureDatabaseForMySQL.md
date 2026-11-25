---
type: Power Query Connector
title: Azure Database for MySQL
description: Connect to Azure Database for MySQL
tags: [packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq
  title: AzureDatabaseForMySQL.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureDatabaseForMySQL/1.0.4/AzureDatabaseForMySQL_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.4 | UsernamePassword |

# Source files

* [AzureDatabaseForMySQL.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [AzureDatabaseForMySQL.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L12) — `(datasource) => Extension.CurrentCredential(), () => MySQL.Database(server, database, [ReturnSingleDatabase = true])`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureDatabaseForMySQL.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L35) — `Documentation.FieldCaption = Extension.LoadString("serverFieldName"),`
    * [AzureDatabaseForMySQL.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L8) — `shared AzureDatabaseForMySQL.Database = Value.ReplaceType(AzureDatabaseForMySQL.DatabaseImpl, AzureDatabaseForMySQLDatabaseType);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureDatabaseForMySQL.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L35) — `Documentation.FieldCaption = Extension.LoadString("serverFieldName"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AzureDatabaseForMySQL.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L8) — `shared AzureDatabaseForMySQL.Database = Value.ReplaceType(AzureDatabaseForMySQL.DatabaseImpl, AzureDatabaseForMySQLDatabaseType);`
    * [AzureDatabaseForMySQL.pq line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L42) — `ReturnType = type table`
