---
type: Power Query Connector
title: FifteenFive
description: Power BI connector source for FifteenFive.
tags: [key]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq
  title: FifteenFive.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FifteenFive/1.0.1/FifteenFive_1.0.1.pqx
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

* [FifteenFive.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 872](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L872) — `response = Binary.Buffer(FifteenFive.Request(endpoint, null))`
* [Credential access](../patterns/credentials.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 838](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L838) — `FifteenFive.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
    * [FifteenFive.pq line 838](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L838) — `FifteenFive.RequestHeaders = [Accept = "application/json", Authorization = "Bearer " & Extension.CurrentCredential()[Key]];`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 983](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L983) — `Documentation.FieldCaption = Extension.LoadString("fifteenfive.Contents.Parameter.url.FieldCaption"),`
    * [FifteenFive.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L5) — `shared FifteenFive.Contents = Value.ReplaceType(FifteenFive.ContentsImpl, FifteenFive.ContentsType);`
    * [FifteenFive.pq line 991](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L991) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 976](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L976) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [FifteenFive.pq line 1115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L1115) — `NavigationTable.NameColumn     = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 940](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L940) — `Table.GenerateByPage(`
    * [FifteenFive.pq line 935](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L935) — `page = toTable(pickCollection(response))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 983](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L983) — `Documentation.FieldCaption = Extension.LoadString("fifteenfive.Contents.Parameter.url.FieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 853](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L853) — `status = Record.FieldOrDefault(Value.Metadata(response), "Response.Status", 200)`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 857](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L857) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [FifteenFive.pq line 857](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L857) — `Function.InvokeAfter(() => @send(attempt + 1), #duration(0, 0, 0, (attempt + 1) * 1))`
    * [FifteenFive.pq line 849](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L849) — `queryOptions = if query = null then baseOptions else Record.AddField(baseOptions, "Query", query),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L5) — `shared FifteenFive.Contents = Value.ReplaceType(FifteenFive.ContentsImpl, FifteenFive.ContentsType);`
    * [FifteenFive.pq line 968](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L968) — `withData = Table.AddColumn(withKey, "Data", each [Value][Fetch](baseUrl), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 858](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L858) — `else error Error.Record(`
    * [FifteenFive.pq line 846](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L846) — `ManualStatusHandling = manualRetryStatusCodes,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Unreviewed match**
    * [FifteenFive.pq line 852](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L852) — `response = Web.Contents(url, requestOptions),`
