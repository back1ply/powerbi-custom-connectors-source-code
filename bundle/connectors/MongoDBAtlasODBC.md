---
type: Power Query Connector
title: MongoDB Atlas SQL
description: Connect to MongoDB Atlas SQL
tags: [credentials, diagnostics, errors, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: MongoDBAtlasODBC
x-pqkb-version: 1.2.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq
  title: MongoDBAtlasODBC.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MongoDBAtlasODBC/1.2.4/MongoDBAtlasODBC_1.2.4.pqx
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
| MongoDBAtlasODBC | 1.2.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm)
* [MongoDBAtlasODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [MongoDBAtlasODBC.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L55) — `Credential = Extension.CurrentCredential(),`
    * [MongoDBAtlasODBC.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L57) — `UID = Credential[Username],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MongoDBAtlasODBC.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L25) — `Documentation.FieldCaption = "MongoDB URI",`
    * [MongoDBAtlasODBC.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L13) — `shared MongoDBAtlasODBC.Contents = Value.ReplaceType(MongoDBAtlasODBCImpl, MongoDBAtlasODBCType);`
    * [MongoDBAtlasODBC.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L22) — `MongoDBAtlasODBCType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [MongoDBAtlasODBC.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L47) — `DataSource = Odbc.DataSource(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MongoDBAtlasODBC.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L142) — `ButtonText = {Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp")},`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [MongoDBAtlasODBC.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L17) — `Error.Record(`
    * [MongoDBAtlasODBC.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L16) — `error`
