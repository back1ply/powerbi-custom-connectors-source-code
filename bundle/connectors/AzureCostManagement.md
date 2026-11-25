---
type: Power Query Connector
title: Azure Cost Management
description: Connect to Azure Cost Management
tags: [aad, credentials, diagnostics, errors, navigation, packaging, pagination, parameter-metadata, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.42
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq
  title: AzureCostManagement.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCostManagement/1.0.42/AzureCostManagement_1.0.42.pqx
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
| Microsoft | 1.0.42 | Aad |

# Source files

* [AzureCostManagement.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L182) — `(datasource) => if (datasource[DataSource.Kind] = "AzureBlobs") then [ AuthenticationKind = "Anonymous" ] else Extension.CurrentCredential(),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 2445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2445) — `Diagnostics.Trace(TraceLevel.Error, message, () => error message, true);`
    * [AzureCostManagement.pq line 2445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2445) — `Diagnostics.Trace(TraceLevel.Error, message, () => error message, true);`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 2349](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2349) — `Documentation.FieldCaption = Extension.LoadString("lbl_Choose_Scope"),`
    * [AzureCostManagement.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L109) — `shared AzureCostManagement.Contents = Value.ReplaceType(AzureCostManagement.ContentsInternal, AzureCostManagement.ContentsType);`
    * [AzureCostManagement.pq line 2369](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2369) — `t = type function (scope as scope, scopeValue as scopeValue, numberOfMonths as numberOfMonths, optional parameters as parameters) as table`
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 421](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L421) — `result = if (errorMsg <> "") then errorMsg else (Table.ToNavigationTable(navTableSource, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"))`
    * [AzureCostManagement.pq line 2299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2299) — `NavigationTable.NameColumn = nameColumn,`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 2260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2260) — `list = List.Generate(`
    * [AzureCostManagement.pq line 2456](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2456) — `page = if (nextLink <> null and nextLink <> "") then GetPage(nextLink, schema, appType) else null`
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L117) — `ButtonText = {Extension.LoadString("AzureCostManagement"), Extension.LoadString("AzureCostManagement")},`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L191) — `status = Value.Metadata(response)[Response.Status],`
    * [AzureCostManagement.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L190) — `response = Web.Contents(url, [IsRetry = (isRetry = true or iteration > 0), Timeout = apiCallTimeout, Content = contentParameter, Headers = header, ManualStatusHandling = {500, 502, 503, 504}]),`
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L186) — `waitForResult = Value.WaitFor(`
    * [AzureCostManagement.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L17) — `reportStatusPullingInterval = #duration(0, 0, 0, 1);`
    * [AzureCostManagement.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L65) — `if (Text.StartsWith(EnvironmentConfiguration[AzureActiveDirectory], GlobalCloudConfiguration[AzureActiveDirectory])) then`
    * [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm#L8) — `if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm#L14) — `if (firstRow = null) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L109) — `shared AzureCostManagement.Contents = Value.ReplaceType(AzureCostManagement.ContentsInternal, AzureCostManagement.ContentsType);`
    * [AzureCostManagement.pq line 2992](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2992) — `RITransactionPropertyType = type table [`
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L44) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms, culture),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 375](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L375) — `error Error.Record("Invalid scope identifier entered. A valid scope identifier takes the form '/providers/Microsoft.Billing/billingAccounts/{billingAccountId}/billingProfiles/{billingProfileId}'. Scope entered: " & billingScopeIdentifier)`
    * [AzureCostManagement.pq line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L162) — `then error "Unexpected data source path value."`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AzureCostManagement.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L190) — `response = Web.Contents(url, [IsRetry = (isRetry = true or iteration > 0), Timeout = apiCallTimeout, Content = contentParameter, Headers = header, ManualStatusHandling = {500, 502, 503, 504}]),`
