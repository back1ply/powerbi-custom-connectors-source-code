---
type: Power Query Connector
title: MarkLogic
description: MarkLogic
tags: [credentials, diagnostics, errors, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: MarkLogic
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m
  title: MarkLogicODBC.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MarkLogicODBC/1.0.6/MarkLogicODBC_1.0.6.pqx
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
| MarkLogic | 1.0.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm)
* [MarkLogicODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [MarkLogicODBC.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L132) — `Credential = Extension.CurrentCredential(),`
    * [MarkLogicODBC.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L135) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MarkLogicODBC.m line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L94) — `Documentation.FieldCaption = "Hostname",`
    * [MarkLogicODBC.m line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L90) — `shared MarkLogicODBC.Contents = Value.ReplaceType(MarkLogicODBCImpl, MarkLogicODBCType);`
    * [MarkLogicODBC.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L92) — `MarkLogicODBCType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [MarkLogicODBC.m line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L315) — `OdbcDatasource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MarkLogicODBC.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L358) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [MarkLogicODBC.m line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L90) — `shared MarkLogicODBC.Contents = Value.ReplaceType(MarkLogicODBCImpl, MarkLogicODBCType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [MarkLogicODBC.m line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L139) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [MarkLogicODBC.m line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MarkLogicODBC/MarkLogicODBC.m#L139) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
