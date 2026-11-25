---
type: Power Query Connector
title: Azure Database for PostgreSQL
description: Connect to Azure Database for PostgreSQL
tags: [aad, errors, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.3.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq
  title: AzurePostgreSQL.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzurePostgreSQL/1.3.2/AzurePostgreSQL_1.3.2.pqx
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
| Microsoft | 1.3.2 | Aad, UsernamePassword |

# Source files

* [AzurePostgreSQL.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [AzurePostgreSQL.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L33) — `(datasource) => Extension.CurrentCredential(), () => PostgreSQL.Database(server, database, options)`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzurePostgreSQL.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L109) — `Documentation.FieldCaption = Extension.LoadString("CommandTimeoutCaption"),`
    * [AzurePostgreSQL.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L22) — `shared AzurePostgreSQL.Database = Value.ReplaceType(AzurePostgreSQL.DatabaseImpl, AzurePostgreSQLDataBaseType);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzurePostgreSQL.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L47) — `Extension.LoadString("InvalidOptionsKey"), {InvalidKey, Text.Combine(VisibleKeys, ",")}`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AzurePostgreSQL.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L22) — `shared AzurePostgreSQL.Database = Value.ReplaceType(AzurePostgreSQL.DatabaseImpl, AzurePostgreSQLDataBaseType);`
    * [AzurePostgreSQL.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L129) — `ReturnType = type table`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AzurePostgreSQL.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L84) — `error Error.Record("Expression.Error", InvalidKeyText)`
    * [AzurePostgreSQL.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L84) — `error Error.Record("Expression.Error", InvalidKeyText)`
