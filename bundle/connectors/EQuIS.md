---
type: Power Query Connector
title: EQuIS
description: Power BI connector source for EQuIS.
tags: [aad, buffering, credentials, key, navigation, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: EarthSoft
x-pqkb-version: 7.23.10067
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m
  title: EQuIS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/EQuIS/7.23.10067/EQuIS_7.23.10067.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| EarthSoft | 7.23.10067 | Aad, Key, UsernamePassword |

# Source files

* [EQuIS.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [EQuIS.m line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L97) — `apiResponse = Json.Document(Binary.Buffer(Web.Contents(baseUri & "/api/config/anon")))`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [EQuIS.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L64) — `cred = Extension.CurrentCredential(),`
    * [EQuIS.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L65) — `token = if cred[AuthenticationKind] = "UsernamePassword" then`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [EQuIS.m line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L112) — `Documentation.FieldCaption = Extension.LoadString("Input.Url.Label"),`
    * [EQuIS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L14) — `shared EQuIS.Contents = Value.ReplaceType(Navigator.GetMain, NavigatorInfo);`
    * [EQuIS.m line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L110) — `NavigatorInfo = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [EQuIS.m line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L142) — `nav = Table.ToNavigationTable(tbl, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [EQuIS.m line 480](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L480) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [EQuIS.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L20) — `ButtonText = { "EQuIS", Extension.LoadString("ConnectorTooltip") },`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [EQuIS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L14) — `shared EQuIS.Contents = Value.ReplaceType(Navigator.GetMain, NavigatorInfo);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [EQuIS.m line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L67) — `Text.Trim(Text.FromBinary(Web.Contents(baseUri & "/api/tokens" & "?user-agent=equis-pqx", [ Headers = [ #"Content-Type" = "application/json" ], Content = Text.ToBinary(json) ])), """")`
