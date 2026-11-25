---
type: Power Query Connector
title: Azure Device Registry (ADR)
description: Connect to AzureDeviceRegistry
tags: [aad, diagnostics, errors, navigation, packaging, pagination, parameter-metadata, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq
  title: AzureDeviceRegistry.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm
  title: CommonFunctions.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/QueryHelper.pqm
  title: QueryHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureDeviceRegistry/1.0.3/AzureDeviceRegistry_1.0.3.pqx
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
| Microsoft | 1.0.3 | Aad |

# Source files

* [AzureDeviceRegistry.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq)
* [CommonFunctions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm)
* [QueryHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/QueryHelper.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm#L5) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm#L6) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L66) — `Documentation.FieldCaption = Extension.LoadString("ScopeParamCaption"),`
    * [AzureDeviceRegistry.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L116) — `shared AzureDeviceRegistry.Query = Value.ReplaceType(AdrNavTable, AdrType);`
    * [AzureDeviceRegistry.pq line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L64) — `AdrType = type function(`
    * [CommonFunctions.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L23) — `Value.ReplaceType(`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L139) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [AzureDeviceRegistry.pq line 331](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L331) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 232](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L232) — `list = List.Generate(`
    * [AzureDeviceRegistry.pq line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L154) — `page = if (nextToken <> null) then`
    * [CommonFunctions.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L6) — `listOfPages = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L47) — `Label = Extension.LoadString("Title")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L150) — `nextToken = if (previous = null) then Diagnostics.LogValue("Start GetData For Table " & tableName,"") else Value.Metadata(previous)[SkipToken]?,`
    * [AzureDeviceRegistry.pq line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L212) — `[Headers = [#"Content-Type" = "application/json"],`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L155) — `Function.InvokeAfter(() =>`
    * [AzureDeviceRegistry.pq line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L161) — `#duration(0,0,0,delay))`
    * [AzureDeviceRegistry.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L145) — `baseQuery = if(tableName = TableNames.Asset) then Asset.Query else if(tableName = TableNames.Device) then Device.Query else error "Invalid table name",`
    * [CommonFunctions.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L17) — `if (firstRow = null) then`
    * [Diagnostics.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm#L17) — `if result[HasError] then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L116) — `shared AzureDeviceRegistry.Query = Value.ReplaceType(AdrNavTable, AdrType);`
    * [CommonFunctions.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L23) — `Value.ReplaceType(`
    * [CommonFunctions.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm#L69) — `type table (toType),`
    * [Diagnostics.pqm line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm#L114) — `else if base = type table then`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 257](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L257) — `error Error.Record(`
    * [AzureDeviceRegistry.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L145) — `baseQuery = if(tableName = TableNames.Asset) then Asset.Query else if(tableName = TableNames.Device) then Device.Query else error "Invalid table name",`
    * [Diagnostics.pqm line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm#L7) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AzureDeviceRegistry.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L211) — `result = Web.Contents(apiUrl,`
