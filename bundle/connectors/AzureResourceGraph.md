---
type: Power Query Connector
title: Azure Resource Graph
description: Connect to Azure Resource Graph
tags: [aad, packaging, pagination, parameter-metadata, response-metadata, retry-polling, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq
  title: AzureResourceGraph.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureResourceGraph/1.0.6/AzureResourceGraph_1.0.6.pqx
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
| Microsoft | 1.0.6 | Aad |

# Source files

* [AzureResourceGraph.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9) — `Documentation.FieldCaption = Extension.LoadString("QueryFieldCaption"),`
    * [AzureResourceGraph.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L5) — `shared AzureResourceGraph.Query = Value.ReplaceType(ARGImpl, AzureResourceGraphType);`
    * [AzureResourceGraph.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L7) — `AzureResourceGraphType = type function(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L53) — `Table.GenerateByPage((previous) =>`
    * [AzureResourceGraph.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L59) — `page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9) — `Documentation.FieldCaption = Extension.LoadString("QueryFieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L56) — `nextToken = if (previous = null) then "" else Value.Metadata(previous)[SkipToken]?,`
    * [AzureResourceGraph.pq line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L92) — `[Headers = [#"Content-Type" = "application/json", #"X-Ms-Command-Name" = "ARGPBI"],`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L59) — `page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null`
    * [AzureResourceGraph.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L59) — `page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null`
    * [AzureResourceGraph.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L56) — `nextToken = if (previous = null) then "" else Value.Metadata(previous)[SkipToken]?,`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AzureResourceGraph.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L5) — `shared AzureResourceGraph.Query = Value.ReplaceType(ARGImpl, AzureResourceGraphType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AzureResourceGraph.pq line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L91) — `result = Web.Contents(apiUrl,`
