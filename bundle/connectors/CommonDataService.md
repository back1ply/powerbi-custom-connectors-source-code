---
type: Power Query Connector
title: Dataverse
description: Connect to Dataverse through its SQL endpoint
tags: [aad, native-query, packaging, parameter-metadata, response-metadata, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.17
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq
  title: CommonDataService.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CommonDataService/1.1.17/CommonDataService_1.1.17.pqx
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
| Microsoft | 1.1.17 | Aad |

# Source files

* [CommonDataService.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L98) — `Documentation.FieldCaption = Extension.LoadString("CreateNavigationPropertiesCaption"),`
    * [CommonDataService.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L62) — `shared CommonDataService.Database = Value.ReplaceType(`
* [Native queries](../patterns/native-query.md)
  * **Match from a review of older source**
    * [CommonDataService.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L80) — `baseResult = Value.NativeQuery(navTable, query, parameters, newOptions),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L98) — `Documentation.FieldCaption = Extension.LoadString("CreateNavigationPropertiesCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [CommonDataService.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L211) — `authHeader = Record.FieldOrDefault(Value.Metadata(response)[Headers], headerKey),`
    * [CommonDataService.pq line 208](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L208) — `options = [Headers=[Authorization="Bearer"], ManualStatusHandling={401}],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [CommonDataService.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L62) — `shared CommonDataService.Database = Value.ReplaceType(`
    * [CommonDataService.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L113) — `ReturnType = type table`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [CommonDataService.pq line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L202) — `GetRows = () => error Error.Record("DataSource.Error", Extension.LoadString("LoadDataError"), null)`
    * [CommonDataService.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L83) — `newResult = try Value.NativeQuery(newNavTable, query, parameters, newOptions) otherwise baseResultWithCaptions,`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [CommonDataService.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L74) — `nativeQueryOverride = Table.View(navTable, [`
    * [CommonDataService.pq line 201](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L201) — `GetType = () => type table [],`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [CommonDataService.pq line 159](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L159) — `response = Json.Document(Web.Contents(BapEndpoint)),`
