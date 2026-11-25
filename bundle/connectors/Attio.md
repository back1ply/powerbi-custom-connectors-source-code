---
type: Power Query Connector
title: Attio
description: Power BI connector source for Attio.
tags: [key, navigation, packaging, parameter-metadata, schema]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq
  title: Attio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Attio/1.0.1/Attio_1.0.1.pqx
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

* [Attio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Unreviewed match**
    * [Attio.pq line 506](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L506) — `response = Binary.Buffer(Attio.Request(endpoint, null))`
* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 472](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L472) — `Attio.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
    * [Attio.pq line 472](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L472) — `Attio.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Attio.pq line 653](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L653) — `Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"),`
    * [Attio.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L5) — `shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);`
    * [Attio.pq line 661](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L661) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Attio.pq line 646](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L646) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Attio.pq line 785](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L785) — `NavigationTable.NameColumn     = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 601](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L601) — `Table.GenerateByPage(`
    * [Attio.pq line 569](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L569) — `page = toTable(items),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Attio.pq line 653](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L653) — `Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 487](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L487) — `status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Unreviewed match**
    * [Attio.pq line 491](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L491) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Attio.pq line 491](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L491) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [Attio.pq line 483](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L483) — `queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Attio.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L5) — `shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);`
    * [Attio.pq line 638](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L638) — `withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Unreviewed match**
    * [Attio.pq line 492](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L492) — `else error Error.Record(`
    * [Attio.pq line 480](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L480) — `ManualStatusHandling = manualRetryStatusCodes,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 486](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L486) — `response = Web.Contents(url, requestOptions),`
