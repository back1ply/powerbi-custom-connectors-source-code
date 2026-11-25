---
type: Power Query Connector
title: Viva Insights
description: Connect to Viva Insights Data
tags: [aad, errors, navigation, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq
  title: WorkplaceAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WorkplaceAnalytics/3.1.0/WorkplaceAnalytics_3.1.0.pqx
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
| Microsoft | 3.1.0 | Aad |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm)
* [WorkplaceAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [WorkplaceAnalytics.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L278) — `bufferedResponse = Binary.Buffer(content),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [WorkplaceAnalytics.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L217) — `Documentation.FieldCaption = Extension.LoadString("ScopeIdCaption"),`
    * [WorkplaceAnalytics.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L89) — `Value.ReplaceType(`
    * [WorkplaceAnalytics.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L249) — `type function (scopeId as scopeId, optional jobName as jobName, optional jobId as jobId, optional options as options) as table meta [`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [WorkplaceAnalytics.pq line 752](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L752) — `navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [WorkplaceAnalytics.pq line 712](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L712) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [WorkplaceAnalytics.pq line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L75) — `listOfPages = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [WorkplaceAnalytics.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L217) — `Documentation.FieldCaption = Extension.LoadString("ScopeIdCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L178) — `documentationName = Value.Metadata(Value.Type(x))[Documentation.Name]?,`
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
    * [WorkplaceAnalytics.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L279) — `responseHeaders = Value.Metadata(content)[Headers],`
    * [WorkplaceAnalytics.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L279) — `responseHeaders = Value.Metadata(content)[Headers],`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L8) — `if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [WorkplaceAnalytics.pq line 416](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L416) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(), interval())},`
    * [WorkplaceAnalytics.pq line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L432) — `() => #duration(0, 0, 0, 5),`
    * [WorkplaceAnalytics.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L60) — `if (getResultsEnvironment = null or getResultsEnvironment = "") then Env else getResultsEnvironment;`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L77) — `isTableType = (x as type) =>  try if Type.Is(x, Table.Type) and x <> type table and Type.TableSchema(x) is table then true else false otherwise false,`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L44) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [WorkplaceAnalytics.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L89) — `Value.ReplaceType(`
    * [WorkplaceAnalytics.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L175) — `typeMap = #table(type table [ApiType = text, ResultingType = text], {`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [WorkplaceAnalytics.pq line 205](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L205) — `error Error.Record(`
    * [WorkplaceAnalytics.pq line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L26) — `Extension.Cache = try #shared[Extension.Cache] otherwise () => [Metadata = [Serialized = (key, ctor) => ctor()]];`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [WorkplaceAnalytics.pq line 573](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L573) — `DataloadQueryFolding = (state as record) => Table.View(null, [`
    * [WorkplaceAnalytics.pq line 574](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L574) — `GetType = () => if reportSchema <> null then Value.Type(reportSchema) else Value.Type(GetRows()),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [WorkplaceAnalytics.pq line 274](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L274) — `content = Web.Contents(url, options & [ManualStatusHandling = {400}]),`
