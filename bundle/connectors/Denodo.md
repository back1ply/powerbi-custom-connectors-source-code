---
type: Power Query Connector
title: Denodo
description: Connect to Denodo
tags: [aad, credentials, diagnostics, errors, odbc, packaging, parameter-metadata, usernamepassword, windows]
x-pqkb-publisher: Denodo
x-pqkb-version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m
  title: DenodoForPowerBI.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm
  title: Validation.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Denodo/1.1.2/Denodo_1.1.2.pqx
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
| Denodo | 1.1.2 | Aad, UsernamePassword, Windows |

# Source files

* [DenodoForPowerBI.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm)
* [Validation.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [DenodoForPowerBI.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L101) — `Credential = Extension.CurrentCredential(),`
    * [DenodoForPowerBI.m line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L103) — `AuthKind = Credential[AuthenticationKind],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm#L32) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm#L32) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DenodoForPowerBI.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L32) — `Documentation.FieldCaption = "DSN or Connection String",`
    * [DenodoForPowerBI.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L26) — `shared Denodo.Contents = Value.ReplaceType(DenodoForPowerBIImpl, DenodoForPowerBIType);`
    * [DenodoForPowerBI.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L28) — `DenodoForPowerBIType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [DenodoForPowerBI.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L209) — `OdbcDataSource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [DenodoForPowerBI.m line 595](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L595) — `Label = Extension.LoadString("DataSourceLabel")      // Loaded from resources.resx`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [DenodoForPowerBI.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L26) — `shared Denodo.Contents = Value.ReplaceType(DenodoForPowerBIImpl, DenodoForPowerBIType);`
    * [Diagnostics.pqm line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm#L218) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DenodoForPowerBI.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L75) — `ValidateQueryTimeout = if QueryTimeoutIsNotNull then if (Value.Is(_QueryTimeout, Number.Type)) then true else error Error.Record("Expression.Error", "The value entered for QueryTimeout is not of the correct type.", null) else false,`
    * [DenodoForPowerBI.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L75) — `ValidateQueryTimeout = if QueryTimeoutIsNotNull then if (Value.Is(_QueryTimeout, Number.Type)) then true else error Error.Record("Expression.Error", "The value entered for QueryTimeout is not of the correct type.", null) else false,`
    * [Diagnostics.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm#L32) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Validation.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm#L50) — `error Error.Record("InvalidConnectionString", "Connection String does not have a valid format. Allowed properties: SERVER, PORT, DATABASE, SSLMODE.", item)`
    * [Validation.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm#L50) — `error Error.Record("InvalidConnectionString", "Connection String does not have a valid format. Allowed properties: SERVER, PORT, DATABASE, SSLMODE.", item)`
