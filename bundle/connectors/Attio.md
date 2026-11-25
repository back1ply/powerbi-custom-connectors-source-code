---
type: Power Query Connector
title: Attio
description: Power BI connector source for Attio.
tags: [key, navigation, packaging, parameter-metadata, schema]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq
  title: Attio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Attio/1.0.0/Attio_1.0.0.pqx
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
| Microsoft | 1.0.0 | Key |

# Source files

* [Attio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L85) — `response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
    * [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L85) — `response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Attio.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L151) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.attio.com"}],`
    * [Attio.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L5) — `shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);`
    * [Attio.pq line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L153) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Attio.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L145) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Attio.pq line 223](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L223) — `NavigationTable.NameColumn     = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L109) — `if __style = "cursor" then Table.GenerateByPage((previous) => if previous = null then getPageCursor(null) else let nc = Value.Metadata(previous)[NextCursor] in if nc = null then null else getPageCursor(nc))`
    * [Attio.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L84) — `query    = if cursor = null then base else Record.AddField(base, __paging[CursorParam], cursor),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Attio.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L151) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("attio.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("attio.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.attio.com"}],`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L109) — `if __style = "cursor" then Table.GenerateByPage((previous) => if previous = null then getPageCursor(null) else let nc = Value.Metadata(previous)[NextCursor] in if nc = null then null else getPageCursor(nc))`
    * [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L85) — `response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Attio.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L5) — `shared Attio.Contents = Value.ReplaceType(Attio.ContentsImpl, Attio.ContentsType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L85) — `response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
