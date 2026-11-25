---
type: Power Query Connector
title: Autodesk Construction Cloud
description: Connect to Autodesk Construction Cloud
tags: [errors, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, pkce, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: Autodesk
x-pqkb-version: 1.8.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq
  title: AutodeskConstructionCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm
  title: Diagnostics.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutodeskConstructionCloud/1.8.1/AutodeskConstructionCloud_1.8.1.pqx
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
| Autodesk | 1.8.1 | OAuth |

# Source files

* [AutodeskConstructionCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 248](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L248) — `Documentation.FieldCaption = "Region",`
    * [AutodeskConstructionCloud.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L142) — `shared AutodeskConstructionCloud.Feed = Value.ReplaceType(NavigationTable.Nested, AutodeskConstructionCloudType);`
    * [AutodeskConstructionCloud.pq line 246](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L246) — `AutodeskConstructionCloudType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L149) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [AutodeskConstructionCloud.pq line 675](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L675) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L131) — `OAuth = [`
    * [AutodeskConstructionCloud.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L47) — `StartLogin = (resourceUrl, state, display) =>`
    * [AutodeskConstructionCloud.pq line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L79) — `FinishLogin = (c, dataSourcePath, context, callbackUri, state) =>`
    * [AutodeskConstructionCloud.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L89) — `codeParameter = if (grant_type = "authorization_code") then [ code = code ] else [ refresh_token = code ],`
    * [AutodeskConstructionCloud.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L100) — `Response = Web.Contents(base_path & "/authentication/v2" & "/token", [`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L299) — `Table.GenerateByPage((previous) =>`
    * [AutodeskConstructionCloud.pq line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L304) — `page = if (nextLink <> null) then dataFunc(nextLink) else null`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L65) — `code_challenge = codeVerifier,`
    * [AutodeskConstructionCloud.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L88) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [AutodeskConstructionCloud.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L56) — `Base64Url.Encode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(plainTextCodeVerifier)))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L5) — `client_id_us = Extension.LoadString("CLIENT_ID_US");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L302) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
    * [AutodeskConstructionCloud.pq line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L102) — `Headers = [`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 348](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L348) — `waitForResult = Value.WaitFor(`
    * [AutodeskConstructionCloud.pq line 365](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L365) — `(iteration) => #duration(0, 0, 0, Number.Power(2, iteration)),`
    * [AutodeskConstructionCloud.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L40) — `if Table.Contains(regions, [ShortName = plainRegion]) then regions{[ShortName = plainRegion]}[ClientID]`
    * [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L8) — `if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L142) — `shared AutodeskConstructionCloud.Feed = Value.ReplaceType(NavigationTable.Nested, AutodeskConstructionCloudType);`
    * [Diagnostics.pqm line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L85) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L112) — `error Error.Record(Parts[error], Parts[message]?)`
    * [AutodeskConstructionCloud.pq line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L42) — `else error "Invalid region"`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AutodeskConstructionCloud.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L100) — `Response = Web.Contents(base_path & "/authentication/v2" & "/token", [`
