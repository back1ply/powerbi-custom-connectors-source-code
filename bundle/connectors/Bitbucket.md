---
type: Power Query Connector
title: Bitbucket
description: Power BI connector source for Bitbucket.
tags: [credentials, key, navigation, packaging, parameter-metadata, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq
  title: Bitbucket.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bitbucket/1.0.0/Bitbucket_1.0.0.pqx
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

* [Bitbucket.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L123) — `response = Json.Document(Web.Contents(nextUrl, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
    * [Bitbucket.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L123) — `response = Json.Document(Web.Contents(nextUrl, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L182) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.bitbucket.org/2.0"}],`
    * [Bitbucket.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L5) — `shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);`
    * [Bitbucket.pq line 184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L184) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L176) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Bitbucket.pq line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L254) — `NavigationTable.NameColumn     = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L146) — `if __style = "nextLinkBody" then Table.GenerateByPage((previous) => let next = if previous = null then (let __lim = __paging[LimitParam]? in if __lim <> null and __sendsLimit(url) then url & (if Text.Contains(url, "?") then "&" else "?") & __lim & "=" & Text.From(__pageSize) else url) else Value.Metadata(previous)[Next] in getPageNLB(next))`
    * [Bitbucket.pq line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L130) — `asTable meta [Next = nextLink],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L182) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitbucket.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api.bitbucket.org/2.0"}],`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L146) — `if __style = "nextLinkBody" then Table.GenerateByPage((previous) => let next = if previous = null then (let __lim = __paging[LimitParam]? in if __lim <> null and __sendsLimit(url) then url & (if Text.Contains(url, "?") then "&" else "?") & __lim & "=" & Text.From(__pageSize) else url) else Value.Metadata(previous)[Next] in getPageNLB(next))`
    * [Bitbucket.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L123) — `response = Json.Document(Web.Contents(nextUrl, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Bitbucket.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L5) — `shared Bitbucket.Contents = Value.ReplaceType(Bitbucket.ContentsImpl, Bitbucket.ContentsType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Bitbucket.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitbucket/Bitbucket.pq#L123) — `response = Json.Document(Web.Contents(nextUrl, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
