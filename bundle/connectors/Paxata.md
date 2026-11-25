---
type: Power Query Connector
title: Paxata
description: Connect to Paxata
tags: [buffering, credentials, key, navigation, packaging, parameter-metadata, response-metadata, web-requests]
x-pqkb-publisher: Paxata
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m
  title: Paxata.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Paxata/1.0.3/Paxata_1.0.3.pqx
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
| Paxata | 1.0.3 | Key |

# Source files

* [Paxata.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Paxata.m line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L226) — `buffered = Binary.Buffer(req),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Paxata.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L215) — `accessKey = Text.Combine({":", Extension.CurrentCredential()[Key]}),`
    * [Paxata.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L215) — `accessKey = Text.Combine({":", Extension.CurrentCredential()[Key]}),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Paxata.m line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L31) — `Documentation.FieldCaption = "Url",`
    * [Paxata.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L26) — `shared Paxata.Contents = Value.ReplaceType(PaxataDatasets, PaxataType);`
    * [Paxata.m line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L29) — `PaxataType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Paxata.m line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L140) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Paxata.m line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L256) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Paxata.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L19) — `ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Paxata.m line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L227) — `ResponseCode = Value.Metadata(req)[Response.Status],`
    * [Paxata.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L222) — `req = Web.Contents(url, [ Headers = headers, Content = Text.ToBinary(content), ManualCredentials = true, ManualStatusHandling={404} ]),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Paxata.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L26) — `shared Paxata.Contents = Value.ReplaceType(PaxataDatasets, PaxataType);`
    * [Paxata.m line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L94) — `withTop10Data = Table.AddColumn(Top10Records, "Data", each PaxataDataSet(url, [dataFileId], [schema]), type table)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Paxata.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L222) — `req = Web.Contents(url, [ Headers = headers, Content = Text.ToBinary(content), ManualCredentials = true, ManualStatusHandling={404} ]),`
