---
type: Power Query Connector
title: CosmosDB
description: Connect to CosmosDB using ODBC
tags: [aad, credentials, diagnostics, errors, key, odbc, packaging, parameter-metadata, schema]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m
  title: CosmosDB.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CosmosDB/1.0.9/CosmosDB_1.0.9.pqx
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
| Microsoft | 1.0.9 | Aad, Key |

# Source files

* [CosmosDB.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L215) — `Credential                 = Extension.CurrentCredential( ),`
    * [CosmosDB.m line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L216) — `AuthKind = Credential[AuthenticationKind],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L135) — `(   host as ( type text meta [  Documentation.FieldCaption     = Extension.LoadString( "HostCaption" ),`
    * [CosmosDB.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L132) — `shared CosmosDB.Contents = Value.ReplaceType( CosmosDBImplementation, CosmosDBType );`
    * [CosmosDB.m line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L134) — `CosmosDBType = type function`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 388](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L388) — `OdbcDatasource = Odbc.DataSource( ConnectionString,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L135) — `(   host as ( type text meta [  Documentation.FieldCaption     = Extension.LoadString( "HostCaption" ),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L132) — `shared CosmosDB.Contents = Value.ReplaceType( CosmosDBImplementation, CosmosDBType );`
    * [CosmosDB.m line 305](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L305) — `Table.Schema( _types )[ Name ]`
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm#L188) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [CosmosDB.m line 410](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L410) — `error Error.Record( errorRecord[ Message ] )`
    * [CosmosDB.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/CosmosDB.m#L26) — `GetPlatformVersion = () => try Number.From(Text.Split(Module.Versions()[Core], "."){1}) otherwise 0;`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CosmosDB/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
