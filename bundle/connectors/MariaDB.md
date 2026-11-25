---
type: Power Query Connector
title: MariaDB
description: Connect to MariaDB
tags: [credentials, diagnostics, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: MariaDB
x-pqkb-version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m
  title: MariaDB.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MariaDB/1.0.7/MariaDB_1.0.7.pqx
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
| MariaDB | 1.0.7 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm)
* [MariaDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [MariaDB.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L108) — `Credential = Extension.CurrentCredential(),`
    * [MariaDB.m line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L109) — `CredentialRecord = if (Credential[AuthenticationKind]?) = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L30) — `Documentation.FieldCaption = Extension.LoadString("GetData_Server_FieldCaption"),`
    * [MariaDB.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L19) — `shared MariaDB.Contents = Value.ReplaceType(MariaDBDatabaseImplOdbc, MariaDBDatabaseType);`
    * [MariaDB.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L28) — `MariaDBDatabaseType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [MariaDB.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L268) — `OdbcDataSource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MariaDB/MariaDB.m#L30) — `Documentation.FieldCaption = Extension.LoadString("GetData_Server_FieldCaption"),`
