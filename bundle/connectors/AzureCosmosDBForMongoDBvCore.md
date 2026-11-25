---
type: Power Query Connector
title: Azure Cosmos DB for MongoDB vCore
description: Connect to Azure Cosmos DB for MongoDB vCore
tags: [diagnostics, errors, navigation, packaging, parameter-metadata, schema, table-view, usernamepassword, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq
  title: AzureCosmosDBForMongoDBvCore.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm
  title: DateTimeZones.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm
  title: ExtendedJson.Extract.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm
  title: Visitors.VisitAstKind.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCosmosDBForMongoDBvCore/1.0.2/AzureCosmosDBForMongoDBvCore_1.0.2.pqx
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
| Microsoft | 1.0.2 | UsernamePassword |

# Source files

* [AzureCosmosDBForMongoDBvCore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq)
* [DateTimeZones.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm)
* [ExtendedJson.Extract.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm)
* [Visitors.VisitAstKind.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L3) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L4) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95) — `Documentation.FieldCaption = Extension.LoadString("baseURLFieldCaption"),`
    * [AzureCosmosDBForMongoDBvCore.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L46) — `shared AzureCosmosDBForMongoDBvCore.Contents = Value.ReplaceType(AzureCosmosDBForMongoDBvCoreImpl, CosmosDbType);`
    * [AzureCosmosDBForMongoDBvCore.pq line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L92) — `CosmosDbType = type function (`
    * [Table.ChangeType.pqm line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L95) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L149) — `NavTable = Table.ToNavigationTable(tableIsLeaf, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [AzureCosmosDBForMongoDBvCore.pq line 1046](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L1046) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95) — `Documentation.FieldCaption = Extension.LoadString("baseURLFieldCaption"),`
    * [ExtendedJson.Extract.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm#L63) — `error Extension.LoadString("extractUnexpectedEJSONError") & Text.FromBinary(Json.FromValue(dateElement))`
    * [Visitors.VisitAstKind.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm#L3) — `TimeZones = Expression.Evaluate( Text.FromBinary(Extension.Contents("DateTimeZones.pqm")), #shared),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L46) — `shared AzureCosmosDBForMongoDBvCore.Contents = Value.ReplaceType(AzureCosmosDBForMongoDBvCoreImpl, CosmosDbType);`
    * [AzureCosmosDBForMongoDBvCore.pq line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L517) — `newSchema = Diagnostics.LogValue("newSchema in OnSelectColumns", type table (Type.ForRecord(reorderedSchema, false))),`
    * [Diagnostics.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L112) — `else if base = type table then`
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L66) — `changedPrimitives = Table.TransformColumnTypes(reordered, primitiveTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L127) — `error Extension.LoadString("databaseCollectionError")`
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L5) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
    * [ExtendedJson.Extract.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm#L24) — `try Int32.From(element[#"$numberInt"]) otherwise element[#"$numberInt"]`
    * [Table.ChangeType.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L32) — `Error.Record(`
    * [Table.ChangeType.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L6) — `error "type argument should be a table type"`
    * [Visitors.VisitAstKind.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm#L75) — `_double = try Double.From(value),`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 975](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L975) — `Table.View(`
    * [AzureCosmosDBForMongoDBvCore.pq line 262](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L262) — `AzureCosmosDBForMongoDBvCoreImpl.GetType = (state as record) as type =>`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AzureCosmosDBForMongoDBvCore.pq line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L186) — `source = Web.Contents(databaseURL, [Headers = applicationHeader, Content = postData]),`
