---
type: Power Query Connector
title: Exact Online Premium
description: Connect to Exact Online Premium
tags: [diagnostics, errors, oauth, oauth2, odbc, packaging, pkce, schema, web-requests]
x-pqkb-publisher: ExactOnlinePremium
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m
  title: ExactOnlinePremium.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ExactOnlinePremium/1.0.1/ExactOnlinePremium_1.0.1.pqx
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
| ExactOnlinePremium | 1.0.1 | OAuth |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm)
* [ExactOnlinePremium.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [ExactOnlinePremium.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L121) — `OAuth = [`
    * [ExactOnlinePremium.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L122) — `StartLogin  = OAuth.StartLogin,`
    * [ExactOnlinePremium.m line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L123) — `FinishLogin = OAuth.FinishLogin,`
    * [ExactOnlinePremium.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L25) — `userInfoText = LogValue("UserInfo", Text.FromBinary(Web.Contents(configJson[api_url], [`
    * [OAuth.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L29) — `OAuth.StartLogin = (resourceUrl, state, display) =>`
    * [OAuth.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L50) — `OAuth.FinishLogin = (context, callbackUri, state) =>`
    * [OAuth.pqm line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L70) — `grant_type    = grantType,`
    * [OAuth.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L74) — `Response = Web.Contents(oauth_token_url, [`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [ExactOnlinePremium.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L108) — `OdbcDataSource = Odbc.DataSource(ConnectionString, ConnectionOptions),`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [OAuth.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L38) — `code_challenge        = Base64UrlEncodeNoPadding(Sha256Hash(codeVerifier)),`
    * [OAuth.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L64) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [OAuth.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L25) — `hashBinary = Crypto.CreateHash(CryptoAlgorithm.SHA256, asciiText)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ExactOnlinePremium.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L9) — `configJson = Json.Document(Text.FromBinary(Extension.Contents(jsonFileName)));`
    * [OAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L3) — `configJson = Json.Document(Text.FromBinary(Extension.Contents(jsonFileName))),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm#L85) — `if base = type table then "table" else`
    * [ExactOnlinePremium.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L13) — `shared ExactOnlinePremium.Contents = Value.ReplaceType(ExactOnlinePremiumImpl, ExactOnlinePremiumType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [OAuth.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L54) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [OAuth.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L54) — `error Error.Record(parts[error], parts[error_description], parts)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [ExactOnlinePremium.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L25) — `userInfoText = LogValue("UserInfo", Text.FromBinary(Web.Contents(configJson[api_url], [`
    * [ExactOnlinePremium.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L26) — `RelativePath = LogValue("UserRelativePath", configJson[userinfo_rel_path]),`
    * [OAuth.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm#L74) — `Response = Web.Contents(oauth_token_url, [`
