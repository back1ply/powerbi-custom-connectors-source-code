---
type: Power Query Connector
title: Bitly
description: Power BI connector source for Bitly.
tags: [credentials, key, navigation, packaging, parameter-metadata, schema]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq
  title: Bitly.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bitly/1.0.1/Bitly_1.0.1.pqx
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

* [Bitly.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Unreviewed match**
    * [Bitly.pq line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L256) — `response = Binary.Buffer(Bitly.Request(endpoint, null))`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Bitly.pq line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L222) — `Bitly.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
    * [Bitly.pq line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L222) — `Bitly.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Bitly.pq line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L347) — `Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"),`
    * [Bitly.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L5) — `shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);`
    * [Bitly.pq line 355](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L355) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Bitly.pq line 340](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L340) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Bitly.pq line 468](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L468) — `NavigationTable.NameColumn     = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Bitly.pq line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L347) — `Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Unreviewed match**
    * [Bitly.pq line 237](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L237) — `status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Unreviewed match**
    * [Bitly.pq line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L241) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Bitly.pq line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L241) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Bitly.pq line 233](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L233) — `queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Bitly.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L5) — `shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);`
    * [Bitly.pq line 332](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L332) — `withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Unreviewed match**
    * [Bitly.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L242) — `else error Error.Record(`
    * [Bitly.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L230) — `ManualStatusHandling = manualRetryStatusCodes,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Bitly.pq line 236](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L236) — `response = Web.Contents(url, requestOptions),`
