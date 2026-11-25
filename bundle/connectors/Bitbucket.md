---
type: Power Query Connector
title: Bitbucket
description: Power BI connector source for Bitbucket.
tags: [credentials, key, navigation, packaging, parameter-metadata, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq
  title: Bitbucket.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bitbucket/1.0.1/Bitbucket_1.0.1.pqx
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
| Microsoft | 1.0.1 | Key |

# Source files

* [Bitbucket.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Unreviewed match**
    * [Bitbucket.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L122) — `response = Binary.Buffer(Bitbucket.Request(endpoint, null))`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L88) — `Bitbucket.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
    * [Bitbucket.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L88) — `Bitbucket.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 233](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L233) — `Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"),`
    * [Bitbucket.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L5) — `shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);`
    * [Bitbucket.pq line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L241) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L226) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Bitbucket.pq line 365](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L365) — `NavigationTable.NameColumn     = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L190) — `Table.GenerateByPage(`
    * [Bitbucket.pq line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L185) — `page = toTable(pickCollection(response))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 233](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L233) — `Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L103) — `status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Unreviewed match**
    * [Bitbucket.pq line 107](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L107) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Bitbucket.pq line 107](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L107) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Bitbucket.pq line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L99) — `queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L5) — `shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);`
    * [Bitbucket.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L218) — `withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Unreviewed match**
    * [Bitbucket.pq line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L108) — `else error Error.Record(`
    * [Bitbucket.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L96) — `ManualStatusHandling = manualRetryStatusCodes,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L102) — `response = Web.Contents(url, requestOptions),`
