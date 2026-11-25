---
type: Power Query Connector
title: SoftOne BI
description: Connect to Soft1 / Atlantis
tags: [buffering, errors, navigation, oauth, packaging, response-metadata, schema, web-requests]
x-pqkb-publisher: SoftOne
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m
  title: SoftOneBI.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SoftOneBI/1.0.0/SoftOneBI_1.0.0.pqx
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
| SoftOne | 1.0.0 | OAuth |

# Source files

* [SoftOneBI.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L98) — `(x) => try Binary.Buffer(Binary.Decompress(x, Compression.Deflate)) otherwise null`
* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [SoftOneBI.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L43) — `serial = Extension.CurrentCredential()[Properties][serial],`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L50) — `navTable = Table.ToNavigationTable(sourceL, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [SoftOneBI.m line 201](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L201) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [SoftOneBI.m line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L218) — `OAuth = [`
    * [SoftOneBI.m line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L219) — `StartLogin = StartLogin,`
    * [SoftOneBI.m line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L220) — `FinishLogin = FinishLogin,`
    * [SoftOneBI.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L121) — `unzippedContent=Table.AddColumn(zippedTbls, "CONTENT", each unzip(Web.Contents(base_url, [RelativePath=Text.Combine({serial, "/", [name]}) ]))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L17) — `scope_prefix =  Extension.LoadString("scope_prefix");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L178) — `responseMetadata = Value.Metadata(response),`
    * [SoftOneBI.m line 179](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L179) — `responseCode = responseMetadata[Response.Status],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L25) — `shared SoftOneBI.Contents = Value.ReplaceType(CreateNavTable, NavTableType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 148](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L148) — `errors.badRequest = Record.AddField(Error.Record(Extension.LoadString("lte_http_400"), Extension.LoadString("lte_http_400_msg")), "Status", 400),`
    * [SoftOneBI.m line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L48) — `sourceD=Table.AddColumn(sourceN, "Data", each  try GetTable(serial, [Name]) otherwise no_data),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [SoftOneBI.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L121) — `unzippedContent=Table.AddColumn(zippedTbls, "CONTENT", each unzip(Web.Contents(base_url, [RelativePath=Text.Combine({serial, "/", [name]}) ]))),`
    * [SoftOneBI.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L121) — `unzippedContent=Table.AddColumn(zippedTbls, "CONTENT", each unzip(Web.Contents(base_url, [RelativePath=Text.Combine({serial, "/", [name]}) ]))),`
