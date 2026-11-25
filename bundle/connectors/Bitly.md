---
type: Power Query Connector
title: Bitly
description: Power BI connector source for Bitly.
tags: [credentials, key, navigation, packaging, parameter-metadata, schema]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq
  title: Bitly.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bitly/1.0.0/Bitly_1.0.0.pqx
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

* [Bitly.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Bitly.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L49) — `response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
    * [Bitly.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L49) — `response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Bitly.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L83) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api-ssl.bitly.com/v4"}],`
    * [Bitly.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L5) — `shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);`
    * [Bitly.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L85) — `t = type function (url as url, optional options as options) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Bitly.pq line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L77) — `nav = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Bitly.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L144) — `NavigationTable.NameColumn     = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Bitly.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L83) — `url = (type text) meta [Documentation.FieldCaption = Extension.LoadString("bitly.Contents.Parameter.url.FieldCaption"), Documentation.FieldDescription = Extension.LoadString("bitly.Contents.Parameter.url.FieldDescription"), Documentation.SampleValues = {"https://api-ssl.bitly.com/v4"}],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Bitly.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L5) — `shared Bitly.Contents = Value.ReplaceType(Bitly.ContentsImpl, Bitly.ContentsType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Bitly.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bitly/Bitly.pq#L49) — `response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),`
