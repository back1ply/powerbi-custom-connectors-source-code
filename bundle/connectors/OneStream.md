---
type: Power Query Connector
title: OneStream
description: Connect to OneStream
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: OneStream
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq
  title: OneStream.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneStream/1.0.4/OneStream_1.0.4.pqx
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
| OneStream | 1.0.4 | OAuth |

# Source files

* [OneStream.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [OneStream.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L48) — `Documentation.FieldCaption = EnvironmentCaption,`
    * [OneStream.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L45) — `shared OneStream.Navigation = Value.ReplaceType(OneStreamNavigationImpl, OneStreamNavigationType);`
    * [OneStream.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L46) — `OneStreamNavigationType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [OneStream.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L74) — `navTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [OneStream.pq line 663](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L663) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [OneStream.pq line 836](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L836) — `OAuth = [`
    * [OneStream.pq line 837](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L837) — `StartLogin = StartLogin,`
    * [OneStream.pq line 838](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L838) — `FinishLogin = FinishLogin,`
    * [OneStream.pq line 888](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L888) — `codeParameter = if (grant_type = "authorization_code") then [code = code] else [refresh_token = code],`
    * [OneStream.pq line 791](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L791) — `response = Web.Contents(baseUrl, [`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [OneStream.pq line 862](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L862) — `code_challenge = codeChallenge,`
    * [OneStream.pq line 887](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L887) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [OneStream.pq line 857](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L857) — `codeChallenge = Base64UrlEncodeWithoutPadding(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [OneStream.pq line 842](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L842) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [OneStream.pq line 808](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L808) — `responseCode = Value.Metadata(response)[Response.Status],`
    * [OneStream.pq line 796](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L796) — `Headers =`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [OneStream.pq line 768](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L768) — `initialTry = if getDataResult then GetWebContentData(GetDataRequest, params, baseUrl, query, true) else Function.InvokeAfter(() => GetWebContentData(GetDataRequest, params, baseUrl, query, true), #duration(0,0,0,FirstRetryInterval)),`
    * [OneStream.pq line 768](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L768) — `initialTry = if getDataResult then GetWebContentData(GetDataRequest, params, baseUrl, query, true) else Function.InvokeAfter(() => GetWebContentData(GetDataRequest, params, baseUrl, query, true), #duration(0,0,0,FirstRetryInterval)),`
    * [OneStream.pq line 317](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L317) — `if Text.Lower(includeDescriptions) <> "true" // To cover for input mistakes anything that's not true will return without descriptions.`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [OneStream.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L45) — `shared OneStream.Navigation = Value.ReplaceType(OneStreamNavigationImpl, OneStreamNavigationType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [OneStream.pq line 779](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L779) — `tryGetData = if executeOrError then Function.InvokeAfter(() => GetWebContentData(GetDataRequest, params, baseUrl, query, true), #duration(0,0,0,RetryInterval)) else error Error.Record("Timeout", "Request: " & requestId & " has timed out. Please reduce the size of the request."),`
    * [OneStream.pq line 446](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L446) — `SI = try [XfBytes = sessionInfoObject[XfBytes]] otherwise [XfBytes = sessionInfoObject[xfBytes]]`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [OneStream.pq line 791](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L791) — `response = Web.Contents(baseUrl, [`
    * [OneStream.pq line 792](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L792) — `RelativePath = url,`
