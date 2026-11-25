---
type: Power Query Connector
title: SingleStore Direct Query Connector
description: SingleStoreDirectQueryConnector
tags: [credentials, native-query, odbc, packaging, parameter-metadata, usernamepassword, windows]
x-pqkb-publisher: SingleStore
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m
  title: SingleStoreODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SingleStoreODBC/1.1.1/SingleStoreODBC_1.1.1.pqx
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
| SingleStore | 1.1.1 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/OdbcConstants.pqm)
* [SingleStoreODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [SingleStoreODBC.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L153) — `Credential = Extension.CurrentCredential(),`
    * [SingleStoreODBC.m line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L155) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [SingleStoreODBC.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L81) — `Documentation.FieldCaption = Extension.LoadString("ServerFieldCaption"),`
    * [SingleStoreODBC.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L270) — `Transform = Value.ReplaceType(Table.FromRecords(Table.TransformRows(source, (row) as record => transformRow(row))), Value.Type(source))`
    * [SingleStoreODBC.m line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L79) — `SingleStoreConnectorMetaMain = type function (`
* [Native queries](../patterns/native-query.md)
  * **Match from a review of older source**
    * [SingleStoreODBC.m line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L395) — `OdbcDataSource =  if QueryWithoutSemicolumns <> null then Value.NativeQuery(DataSource, QueryWithoutSemicolumns, null, [ EnableFolding = true ]) else DataSource`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [SingleStoreODBC.m line 308](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L308) — `OdbcDatasource = Odbc.DataSource(ConnectionStringWithSSL, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SingleStoreODBC.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L16) — `Config_DriverName = Extension.LoadString("DriverName");`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [SingleStoreODBC.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L270) — `Transform = Value.ReplaceType(Table.FromRecords(Table.TransformRows(source, (row) as record => transformRow(row))), Value.Type(source))`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [SingleStoreODBC.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L162) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [SingleStoreODBC.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SingleStoreODBC/SingleStoreODBC.m#L162) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
