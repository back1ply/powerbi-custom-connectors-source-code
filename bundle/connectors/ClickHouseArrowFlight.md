---
type: Power Query Connector
title: ClickHouse Arrow Flight
description: Connect to ClickHouse over Arrow Flight SQL
tags: [usernamepassword]
x-pqkb-publisher: ClickHouse
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq
  title: ClickHouseArrowFlight.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm
  title: ClickHouseSqlGenerator.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/FlightSqlAdbcConfig.pqm
  title: FlightSqlAdbcConfig.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm
  title: TypeInfo.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ClickHouseArrowFlight/1.0.0/ClickHouseArrowFlight_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T17:23:17Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ClickHouse | 1.0.0 | UsernamePassword |

# Source files

* [ClickHouseArrowFlight.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq)
* [ClickHouseSqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm)
* [FlightSqlAdbcConfig.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/FlightSqlAdbcConfig.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm)
* [TypeInfo.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 412](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L412) — `Credential = Extension.CurrentCredential(),`
    * [ClickHouseArrowFlight.pq line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L432) — `Text.ToBinary(Credential[Username] & ":" & Credential[Password], TextEncoding.Utf8),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Unreviewed match**
    * [ClickHouseSqlGenerator.pqm line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm#L144) — `else Diagnostics.Trace(TraceLevel.Information,`
    * [ClickHouseSqlGenerator.pqm line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm#L144) — `else Diagnostics.Trace(TraceLevel.Information,`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L20) — `Documentation.FieldCaption = "Server",`
    * [ClickHouseArrowFlight.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L16) — `shared ClickHouseArrowFlight.Database = Value.ReplaceType(DatabaseCoreImplementation, DatabaseType);`
    * [ClickHouseArrowFlight.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L18) — `DatabaseType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 381](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L381) — `Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf");`
    * [ClickHouseArrowFlight.pq line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L252) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L96) — `Label = Extension.LoadString("DataSourceLabel")`
    * [ClickHouseSqlGenerator.pqm line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm#L98) — `binary = Extension.Contents(name), asText = Text.FromBinary(binary)`
    * [FlightSqlAdbcConfig.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/FlightSqlAdbcConfig.pqm#L34) — `binary = Extension.Contents(name), asText = Text.FromBinary(binary)`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 370](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L370) — `Value.ReplaceMetadata(leaf, Value.Metadata(leaf) & [ExcludedColumns = excludedColumns]);`
    * [ClickHouseSqlGenerator.pqm line 351](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm#L351) — `physicalType = try Value.Metadata(arg[Type])[ClickHouseType] otherwise null`
    * [SqlGeneratorCommon.pqm line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm#L290) — `else if(Value.Metadata(valuetype)[recordtype]? = "FunctionOverrides") then Value.AssertFunctionOverrides(value,valuetype)`
* [Schema and type enforcement](../patterns/schema.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L16) — `shared ClickHouseArrowFlight.Database = Value.ReplaceType(DatabaseCoreImplementation, DatabaseType);`
    * [ClickHouseArrowFlight.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L364) — `tableType = type table (Type.ForRecord(fields, false)),`
    * [Diagnostics.pqm line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm#L85) — `if base = type table then "table" else`
    * [SqlGeneratorCommon.pqm line 298](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm#L298) — `fieldnamesfromvalue = Table.Column(Table.Schema(value),"Name"),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L190) — `error Error.Record("Expression.Error", InvalidKeysText)`
    * [ClickHouseArrowFlight.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L88) — `database = try json[database] otherwise null`
    * [ClickHouseSqlGenerator.pqm line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm#L142) — `let v = try visitor(node)`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [SqlGeneratorCommon.pqm line 289](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm#L289) — `else if(Type.Is(valuetype,type record)<> true) then error "Type provided is not a record type"`
    * [TypeInfo.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm#L65) — `else error Error.Record("Expression.Error", "Not a boolean literal", value),`
    * [TypeInfo.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm#L65) — `else error Error.Record("Expression.Error", "Not a boolean literal", value),`
* [Table.View handlers](../patterns/table-view.md)
  * **Unreviewed match**
    * [ClickHouseArrowFlight.pq line 451](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L451) — `Table.View(null, [`
    * [ClickHouseArrowFlight.pq line 452](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L452) — `GetType = () => resultType,`
