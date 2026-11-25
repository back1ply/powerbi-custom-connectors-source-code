---
type: Power Query Connector
title: Indexima
description: Connect to Indexima Data Hub
tags: [credentials, errors, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Indexima
x-pqkb-version: 1.7.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m
  title: Indexima.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Indexima/1.7.6/Indexima_1.7.6.pqx
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
| Indexima | 1.7.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm)
* [Indexima.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Indexima.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L105) — `Credential = Extension.CurrentCredential(),`
    * [Indexima.m line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L118) — `if Credential[AuthenticationKind]? = "Username" then`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L39) — `Documentation.FieldCaption = Extension.LoadString("ParamServer_Caption"),`
    * [Indexima.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L34) — `shared Indexima.Database = Value.ReplaceType(IndeximaCore, IndeximaType);`
    * [Indexima.m line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L37) — `IndeximaType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Indexima.m line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L250) — `if (Text.StartsWith(server, "DSN=", Comparer.OrdinalIgnoreCase)) then Odbc.DataSource (server, Options)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L39) — `Documentation.FieldCaption = Extension.LoadString("ParamServer_Caption"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [Indexima.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L34) — `shared Indexima.Database = Value.ReplaceType(IndeximaCore, IndeximaType);`
    * [Indexima.m line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L84) — `Schema = JDBC_Schema,				                        // default schema, must be blank for navigation into Hive2 structures`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Indexima.m line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L123) — `error Error.Record("Error", "Unknown authentication mechanism: " & Credential[AuthenticationKind]?),`
    * [Indexima.m line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Indexima/Indexima.m#L123) — `error Error.Record("Error", "Unknown authentication mechanism: " & Credential[AuthenticationKind]?),`
