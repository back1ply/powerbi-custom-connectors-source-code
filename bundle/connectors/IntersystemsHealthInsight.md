---
type: Power Query Connector
title: InterSystems Health Insight
description: Connect to InterSystems Health Insight
tags: [buffering, credentials, diagnostics, errors, navigation, odbc, packaging, parameter-metadata, schema, usernamepassword]
x-pqkb-publisher: IntersystemsHealthInsight
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq
  title: IntersystemsHealthInsight.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntersystemsHealthInsight/1.0.4/IntersystemsHealthInsight_1.0.4.pqx
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
| IntersystemsHealthInsight | 1.0.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm)
* [IntersystemsHealthInsight.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/OdbcConstants.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 440](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L440) — `columnsAPI = try Table.Buffer(Odbc.Query(ConnectionString, "SELECT * FROM %DeepSee_SQL.GetDimensionColumns('" & dimensionTable & "')")),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L93) — `Credential = Extension.CurrentCredential(),`
    * [IntersystemsHealthInsight.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L96) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L42) — `Documentation.FieldCaption = Extension.LoadString("fieldCaptionHost"),`
    * [IntersystemsHealthInsight.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L16) — `shared IntersystemsHealthInsight.Database = Value.ReplaceType(HealthInsightImpl,HealthInsightType);`
    * [IntersystemsHealthInsight.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L40) — `HealthInsightType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L188) — `Database = Table.ToNavigationTable(DatabaseItems, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [IntersystemsHealthInsight.pq line 509](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L509) — `NavigationTable.NameColumn = nameColumn,`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L137) — `OdbcDataSource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [IntersystemsHealthInsight.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L21) — `Description = Extension.LoadString("DataSourceLabel"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [IntersystemsHealthInsight.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L16) — `shared IntersystemsHealthInsight.Database = Value.ReplaceType(HealthInsightImpl,HealthInsightType);`
    * [IntersystemsHealthInsight.pq line 524](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L524) — `Type = type table [`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [IntersystemsHealthInsight.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L103) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [IntersystemsHealthInsight.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L103) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
