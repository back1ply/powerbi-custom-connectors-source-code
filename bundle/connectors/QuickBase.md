---
type: Power Query Connector
title: qbconnector
description: Connect to qbconnector
tags: [buffering, credentials, errors, key, navigation, packaging, parameter-metadata, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: QuickBase
x-pqkb-version: 1.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m
  title: qbconnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QuickBase/1.4.0/QuickBase_1.4.0.pqx
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
| QuickBase | 1.4.0 | Key |

# Source files

* [qbconnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [qbconnector.m line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L70) — `buffered = Binary.Buffer(result),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [qbconnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L33) — `Credential = Extension.CurrentCredential(),`
    * [qbconnector.m line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L35) — `key = if (Credential[AuthenticationKind] = "Key") then Credential[Key] else Credential[access_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [qbconnector.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L20) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
    * [qbconnector.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L11) — `shared QuickBase.Contents = Value.ReplaceType(qbconnectorImpl, qbconnectorType);`
    * [qbconnector.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L16) — `qbconnectorType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [qbconnector.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L96) — `navTable = Table.ToNavigationTable(tableTableStructure, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [qbconnector.m line 470](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L470) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [qbconnector.m line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L52) — `list = List.Generate(`
    * [qbconnector.m line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L290) — `page = if (nextLink <> null) then GetPages(baseUrl, nextLink, headers) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [qbconnector.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L12) — `qbconnector.UserAgent = Extension.LoadString("UserAgent");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [qbconnector.m line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L71) — `status =  Value.Metadata(result)[Response.Status],`
    * [qbconnector.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L38) — `dbSchema = try Json.Document(Web.Contents(qbconnector.BaseUrl&"tables?appId="&splitUrl{1}, [Headers=[#"Content-Type"=qbconnector.ContentType, #"QB-Realm-Hostname"= Text.Replace(splitUrl{0}, "https://", ""), #"USER-AGENT"= qbconnector.UserAgent, Authorization="QB-USER-TOKEN "&key]])),`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [qbconnector.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L57) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [qbconnector.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L75) — `(i) => #duration(0, 0, 0, .5))`
    * [qbconnector.m line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L35) — `key = if (Credential[AuthenticationKind] = "Key") then Credential[Key] else Credential[access_token],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [qbconnector.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L11) — `shared QuickBase.Contents = Value.ReplaceType(qbconnectorImpl, qbconnectorType);`
    * [qbconnector.m line 260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L260) — `#"Grouped Rows" = Table.Group(#"fieldsTable", {"label1"}, {{"Count", each Table.RowCount(_), type number}, {"Partition", each Table.AddIndexColumn(_, "CountMultiple",0,1), type table}}),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [qbconnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L45) — `(error Error.Record("Error", "Authentication Fail with error: " & dbSchema[Error][Message]))`
    * [qbconnector.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L38) — `dbSchema = try Json.Document(Web.Contents(qbconnector.BaseUrl&"tables?appId="&splitUrl{1}, [Headers=[#"Content-Type"=qbconnector.ContentType, #"QB-Realm-Hostname"= Text.Replace(splitUrl{0}, "https://", ""), #"USER-AGENT"= qbconnector.UserAgent, Authorization="QB-USER-TOKEN "&key]])),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [qbconnector.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L38) — `dbSchema = try Json.Document(Web.Contents(qbconnector.BaseUrl&"tables?appId="&splitUrl{1}, [Headers=[#"Content-Type"=qbconnector.ContentType, #"QB-Realm-Hostname"= Text.Replace(splitUrl{0}, "https://", ""), #"USER-AGENT"= qbconnector.UserAgent, Authorization="QB-USER-TOKEN "&key]])),`
