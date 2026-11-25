---
type: Power Query Connector
title: InterSystems IRIS
description: Connect to InterSystems IRIS
tags: [credentials, errors, navigation, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: InterSystems
x-pqkb-version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m
  title: Iris_PowerBI_Connector.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IRIS/1.1.2/IRIS_1.1.2.pqx
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
| InterSystems | 1.1.2 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm)
* [Iris_PowerBI_Connector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/OdbcConstants.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Iris_PowerBI_Connector.m line 414](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L414) — `columnsAPI = try Table.Buffer(Odbc.Query(ConnectionString, "SELECT * FROM %DeepSee_SQL.GetDimensionColumns('" & dimensionTable & "')")),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Iris_PowerBI_Connector.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L81) — `Credential = Extension.CurrentCredential(),`
    * [Iris_PowerBI_Connector.m line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L84) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Iris_PowerBI_Connector.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L36) — `Documentation.FieldCaption = "Host (IP Address)",`
    * [Iris_PowerBI_Connector.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L14) — `shared IRIS.Database = Value.ReplaceType(IRISImpl, IRISType);`
    * [Iris_PowerBI_Connector.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L34) — `IRISType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Iris_PowerBI_Connector.m line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L176) — `Database = Table.ToNavigationTable(DatabaseItems, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Iris_PowerBI_Connector.m line 481](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L481) — `NavigationTable.NameColumn = nameColumn,`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Iris_PowerBI_Connector.m line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L125) — `OdbcDataSource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Iris_PowerBI_Connector.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L17) — `Description = Extension.LoadString("DataSourceLabel"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [Iris_PowerBI_Connector.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L14) — `shared IRIS.Database = Value.ReplaceType(IRISImpl, IRISType);`
    * [Iris_PowerBI_Connector.m line 496](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L496) — `Type = type table [`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Iris_PowerBI_Connector.m line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L91) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [Iris_PowerBI_Connector.m line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IRIS/Iris_PowerBI_Connector.m#L91) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
