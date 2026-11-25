---
type: Power Query Connector
title: CData Connect Cloud
description: Connect to CData Connect Cloud
tags: [diagnostics, errors, oauth, oauth2, packaging, parameter-metadata, pkce, schema, web-requests]
x-pqkb-publisher: CData
x-pqkb-version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq
  title: CDataConnectCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm
  title: CDataConnectCloudRest.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm
  title: CDataConnectCloudRestV2.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm
  title: CDataConnectCloudService.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm
  title: CDataConnectCloudServiceV2.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm
  title: OAuth.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm
  title: Utilities.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CDataConnectCloud/3.1.0/CDataConnectCloud_3.1.0.pqx
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
| CData | 3.1.0 | OAuth |

# Source files

* [CDataConnectCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq)
* [CDataConnectCloudRest.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm)
* [CDataConnectCloudRestV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm)
* [CDataConnectCloudService.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm)
* [CDataConnectCloudServiceV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm)
* [Utilities.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm#L3) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm#L4) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CDataConnectCloud.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L55) — `Documentation.FieldCaption = Extension.LoadString("OptionsQueryFieldCaption"),`
    * [CDataConnectCloud.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L44) — `shared CDataConnectCloud.ContentsV2 = Value.ReplaceType(CDataConnectCloudServiceV2.NavImpl, CDataConnectCloud.NavImplType);`
    * [CDataConnectCloud.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L50) — `CDataConnectCloud.NavImplType = type function (`
    * [CDataConnectCloudService.pqm line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L164) — `Documentation.FieldCaption = [PARAM_NAME],`
    * [CDataConnectCloudServiceV2.pqm line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L254) — `Documentation.FieldCaption = [PARAM_NAME],`
    * [Utilities.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [CDataConnectCloud.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L8) — `OAuth = [`
    * [CDataConnectCloud.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L9) — `StartLogin = OAuth.StartLogin,`
    * [CDataConnectCloud.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L10) — `FinishLogin = OAuth.FinishLogin,`
    * [CDataConnectCloudRest.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L22) — `content = Web.Contents(`
    * [CDataConnectCloudRestV2.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L22) — `content = Web.Contents(`
    * [CDataConnectCloudService.pqm line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L411) — `OAuth.StartLogin = OAuth[StartLogin],`
    * [CDataConnectCloudService.pqm line 412](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L412) — `OAuth.FinishLogin = OAuth[FinishLogin],`
    * [CDataConnectCloudServiceV2.pqm line 499](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L499) — `OAuth.StartLogin = OAuth[StartLogin],`
    * [CDataConnectCloudServiceV2.pqm line 500](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L500) — `OAuth.FinishLogin = OAuth[FinishLogin],`
    * [OAuth.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L19) — `OAuth.StartLogin = (resourceUrl, state, display) =>`
    * [OAuth.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L48) — `OAuth.FinishLogin = (context, callbackUri, state) =>`
    * [OAuth.pqm line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L67) — `grant_type = grantType,`
    * [OAuth.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L59) — `Response = Web.Contents(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [OAuth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L37) — `code_challenge = codeChallenge`
    * [OAuth.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L57) — `code_verifier = verifier`
    * [OAuth.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L23) — `Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CDataConnectCloud.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L12) — `Label = Extension.LoadString("AuthenticationLabel")`
    * [CDataConnectCloudRest.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L8) — `& Extension.LoadString("ProductVersion")`
    * [CDataConnectCloudRestV2.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L8) — `& Extension.LoadString("ProductVersion")`
    * [CDataConnectCloudService.pqm line 381](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L381) — `binary = Extension.Contents(name), asText = Text.FromBinary(binary)`
    * [CDataConnectCloudServiceV2.pqm line 472](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L472) — `binary = Extension.Contents(name), asText = Text.FromBinary(binary)`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CDataConnectCloud.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L44) — `shared CDataConnectCloud.ContentsV2 = Value.ReplaceType(CDataConnectCloudServiceV2.NavImpl, CDataConnectCloud.NavImplType);`
    * [CDataConnectCloudRest.pqm line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L191) — `changedPrimatives = Table.TransformColumnTypes(ResultSetTable, primativeTransforms)`
    * [CDataConnectCloudRest.pqm line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L209) — `tableType = type table (toType)`
    * [CDataConnectCloudRestV2.pqm line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L217) — `changedPrimatives = Table.TransformColumnTypes(ResultSetTable, primativeTransforms)`
    * [CDataConnectCloudRestV2.pqm line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L222) — `ResultSetTable = Table.FromRecords(jsonResponse[workspaces], type table[name, id])`
    * [CDataConnectCloudService.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L17) — `type table`
    * [CDataConnectCloudServiceV2.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L64) — `type table`
    * [Diagnostics.pqm line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm#L109) — `else if base = type table then`
    * [Utilities.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [CDataConnectCloudRest.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L37) — `error Error.Record(jsonResponse[#"error"][code], jsonResponse[#"error"][message])`
    * [CDataConnectCloudRest.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L30) — `ManualStatusHandling = {400}`
    * [CDataConnectCloudRestV2.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L37) — `error Error.Record(jsonResponse[#"error"][code], jsonResponse[#"error"][message])`
    * [CDataConnectCloudRestV2.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L30) — `ManualStatusHandling = {400}`
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm#L5) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [CDataConnectCloudService.pqm line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L211) — `Table.View(`
    * [CDataConnectCloudService.pqm line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L214) — `OnTake = (count as number) => @View(state & [`
    * [CDataConnectCloudServiceV2.pqm line 301](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L301) — `Table.View(`
    * [CDataConnectCloudServiceV2.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L304) — `OnTake = (count as number) => @View(state & [`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [CDataConnectCloudRest.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L22) — `content = Web.Contents(`
    * [CDataConnectCloudRestV2.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L22) — `content = Web.Contents(`
    * [OAuth.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm#L59) — `Response = Web.Contents(`
