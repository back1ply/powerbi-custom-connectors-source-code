---
type: Power Query Connector
title: Azure HorizonDB Database
description: Import or connect to an Azure HorizonDB Database
tags: [aad, credentials, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq
  title: AzureHorizonDB.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureHorizonDB/1.0.3/AzureHorizonDB_1.0.3.pqx
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
| Microsoft | 1.0.3 | Aad, UsernamePassword |

# Source files

* [AzureHorizonDB.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AzureHorizonDB.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L33) — `(datasource) => Extension.CurrentCredential(), () => PostgreSQL.Database(server, database, options)`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureHorizonDB.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L109) — `Documentation.FieldCaption = Extension.LoadString("CommandTimeoutCaption"),`
    * [AzureHorizonDB.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L22) — `shared AzureHorizonDB.Database = Value.ReplaceType(AzureHorizonDB.DatabaseImpl, AzureHorizonDBDataBaseType);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureHorizonDB.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L47) — `Extension.LoadString("InvalidOptionsKey"), {InvalidKey, Text.Combine(VisibleKeys, ",")}`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AzureHorizonDB.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L22) — `shared AzureHorizonDB.Database = Value.ReplaceType(AzureHorizonDB.DatabaseImpl, AzureHorizonDBDataBaseType);`
    * [AzureHorizonDB.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L129) — `ReturnType = type table`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [AzureHorizonDB.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L84) — `error Error.Record("Expression.Error", InvalidKeyText)`
    * [AzureHorizonDB.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureHorizonDB/AzureHorizonDB.pq#L84) — `error Error.Record("Expression.Error", InvalidKeyText)`
