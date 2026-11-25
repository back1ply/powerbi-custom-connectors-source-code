---
type: Power Query Connector
title: Dremio
description: Import data from Dremio.
tags: [aad, anonymous, credentials, key, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Dremio
x-pqkb-version: 3.16.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/CACerts.pqm
  title: CACerts.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm
  title: DataTransform.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq
  title: Dremio.pq
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm
  title: DremioAdbcDataSource.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm
  title: DremioAdbcOptions.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm
  title: DremioOAuthDiscovery.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/FlightSqlAdbcConfig.pqm
  title: FlightSqlAdbcConfig.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm
  title: SqlGenerator.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Dremio/3.16.1/Dremio_3.16.1.pqx
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
| Dremio | 3.16.1 | Aad, Anonymous, Key, UsernamePassword |

# Source files

* [CACerts.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/CACerts.pqm)
* [DataTransform.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm)
* [Dremio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq)
* [DremioAdbcDataSource.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm)
* [DremioAdbcOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm)
* [DremioOAuthDiscovery.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm)
* [FlightSqlAdbcConfig.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/FlightSqlAdbcConfig.pqm)
* [SqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [DremioAdbcDataSource.pqm line 448](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L448) — `tableType = Value.Type(Table.Buffer(typeResult)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Dremio.pq line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L320) — `Credential = Extension.CurrentCredential(),`
    * [Dremio.pq line 338](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L338) — `TokenOption = GetTokenOption(Credential[AuthenticationKind]?),`
    * [DremioAdbcDataSource.pqm line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L115) — `Credential = Extension.CurrentCredential()`
    * [DremioAdbcDataSource.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L37) — `BadServer = Address[Host] = "" or Address[Path] <> "/" or Address[Query] <> [] or Address[Fragment] <> "" or Address[UserName] <> "" or Address[Password] <> "",`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm#L3) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm#L4) — `TraceLevel.Information,`
    * [Dremio.pq line 1047](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L1047) — `Diagnostics.Trace(`
    * [Dremio.pq line 1048](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L1048) — `TraceLevel.Information, [`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DataTransform.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm#L12) — `Value.ReplaceType(transformedTable, origTableType),`
    * [Dremio.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L180) — `Documentation.FieldCaption = Extension.LoadString("SoftwareServerParameterCaption"),`
    * [Dremio.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L214) — `Value.ReplaceType(Function, WithDocumentation);`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Dremio.pq line 904](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L904) — `Database = Odbc.DataSource(ConnectionString, Options){0}[Data]`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Dremio.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L72) — `UsernamePassword = [Name = "Dremio", Label = Extension.LoadString("AuthenticationLabel")],`
    * [DremioAdbcDataSource.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L8) — `binary = Extension.Contents(name),`
    * [DremioAdbcOptions.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm#L8) — `binary = Extension.Contents(name),`
    * [SqlGenerator.pqm line 1004](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm#L1004) — `binary = Extension.Contents(name),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [DataTransform.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm#L12) — `Value.ReplaceType(transformedTable, origTableType),`
    * [DataTransform.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm#L17) — `schema = Table.Schema(originalTable),`
    * [Diagnostics.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm#L112) — `else if base = type table then`
    * [Dremio.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L214) — `Value.ReplaceType(Function, WithDocumentation);`
    * [Dremio.pq line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L199) — `ReturnType = type table`
    * [DremioAdbcDataSource.pqm line 615](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L615) — `Table.TransformColumnTypes(originalTable, uuidTypeTransformations),`
    * [DremioAdbcDataSource.pqm line 373](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L373) — `emptyResult = #table(type table [Name = text, Description = nullable text, Data = table, Kind = text], {}),`
    * [SqlGeneratorCommon.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm#L304) — `fieldnamesfromvalue = Table.Column(Table.Schema(value),"Name"),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm#L5) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
    * [Dremio.pq line 961](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L961) — `error Error.Record(`
    * [Dremio.pq line 405](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L405) — `error "Unexpected resource path format",`
    * [DremioAdbcDataSource.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L15) — `error Error.Record("Expression.Error","The Adbc.DataSource function is not available in this environment"),`
    * [DremioAdbcDataSource.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L14) — `Adbc.DataSource = try #shared[Adbc.DataSource] otherwise (driver, connectionString, options) =>`
    * [DremioAdbcOptions.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm#L45) — `error Error.Record("Expression.Error", errorMessage)`
    * [DremioAdbcOptions.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm#L45) — `error Error.Record("Expression.Error", errorMessage)`
    * [DremioOAuthDiscovery.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm#L55) — `ManualStatusHandling = {400, 401, 403, 404, 405, 408, 429, 500, 502, 503, 504}`
    * [SqlGenerator.pqm line 430](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm#L430) — `error "NoopSkipTakeError"`
    * [SqlGeneratorCommon.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm#L295) — `else if(Type.Is(valuetype,type record)<> true) then error "Type provided is not a record type"`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [DremioAdbcDataSource.pqm line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L293) — `Table.View(null, [`
    * [DremioAdbcDataSource.pqm line 294](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L294) — `GetType = () => resultType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [DremioOAuthDiscovery.pqm line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm#L73) — `Response = try Web.Contents(url, WebContentsOptions),`
