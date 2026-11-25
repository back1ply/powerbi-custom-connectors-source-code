---
type: Power Query Connector
title: Windsor
description: Connect to Windsor
tags: [errors, oauth, oauth2, packaging, pkce, web-requests]
x-pqkb-publisher: Windsor
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq
  title: Windsor.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Windsor/1.0.4/Windsor_1.0.4.pqx
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
| Windsor | 1.0.4 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Icons.pqm)
* [Windsor.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [Windsor.pq line 1057](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L1057) — `ApiKey = Extension.CurrentCredential()[access_token]`
    * [Windsor.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L103) — `refresh_token = TokenData[TokenData][refresh_token]?,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Uncertain match (older review)**
    * [Windsor.pq line 708](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L708) — `Documentation.FieldCaption = title`
    * [Windsor.pq line 544](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L544) — `Value.ReplaceType(`
    * [Windsor.pq line 772](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L772) — `type function (`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Windsor.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L16) — `OAuth = [`
    * [Windsor.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L17) — `StartLogin = Windsor.Auth[Start],`
    * [Windsor.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L18) — `FinishLogin = Windsor.Auth[Finish],`
    * [Windsor.pq line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L153) — `_codeparam = if (grant_type = "authorization_code") then [code = code] else [refresh_token = code],`
    * [Windsor.pq line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L128) — `resp = Web.Contents(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Windsor.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L83) — `code_challenge = self.createHash(PlainTextVerifier)`
    * [Windsor.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L151) — `then [code_verifier = verifier]`
    * [Windsor.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L65) — `Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(verifier, TextEncoding.Ascii)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Icons.pqm#L3) — `Extension.Contents("Windsor16.png"),`
    * [Windsor.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L10) — `Icons = Expression.Evaluate(Text.FromBinary(Extension.Contents("Icons.pqm")), #shared);`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Windsor.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L191) — `MetaData = Value.Metadata(Response),`
    * [Windsor.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L132) — `Headers=[`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Windsor.pq line 351](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L351) — `_resultWithColumnTypes = Table.TransformColumnTypes(_table, Schema)`
    * [Windsor.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L350) — `Schema = Windsor.Utils[GetSchema](UsedFields),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Windsor.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L142) — `error Error.Record(res[error], access_token_data[access_token])`
    * [Windsor.pq line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L136) — `ManualStatusHandling = ManualHandlingStatusCodes`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Windsor.pq line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L128) — `resp = Web.Contents(`
