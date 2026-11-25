---
type: Power Query Connector
title: Kyvos ODBC
description: Kyvos ODBC
tags: [credentials, errors, oauth, oauth2, odbc, packaging, parameter-metadata, pkce, usernamepassword, web-requests]
x-pqkb-publisher: Kyvos
x-pqkb-version: 1.0.8
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq
  title: KyvosODBC.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/KyvosODBC/1.0.8/KyvosODBC_1.0.8.pqx
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
| Kyvos | 1.0.8 | OAuth, UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm)
* [KyvosODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 399](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L399) — `Credential = Extension.CurrentCredential(),`
    * [KyvosODBC.pq line 401](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L401) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm#L3) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm#L4) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 348](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L348) — `Documentation.FieldCaption = Extension.LoadString("ServerParameterCaption"),`
    * [KyvosODBC.pq line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L377) — `Value.ReplaceType(Function, WithDocumentation);`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L302) — `OAuth = [`
    * [KyvosODBC.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L138) — `StartLogin = (resourceUrl, state, display) =>`
    * [KyvosODBC.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L191) — `FinishLogin = (context, callbackUri, state) =>`
    * [KyvosODBC.pq line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L202) — `codeParameter = if (grant_type = "authorization_code") then [code = code] else [refresh_token = code],`
    * [KyvosODBC.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L144) — `properties = Json.Document(Web.Contents(normalizedURL,`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L517) — `OdbcDatasource = Odbc.DataSource(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L175) — `code_challenge = codeVerifier,`
    * [KyvosODBC.pq line 201](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L201) — `codeVerifier = if (context[plainTextCodeVerifier] <> null) then [code_verifier = context[plainTextCodeVerifier]] else [],`
    * [KyvosODBC.pq line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L161) — `Base64Url.Encode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(plainTextCodeVerifier)))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L309) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm#L112) — `else if base = type table then`
    * [KyvosODBC.pq line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L377) — `Value.ReplaceType(Function, WithDocumentation);`
    * [KyvosODBC.pq line 361](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L361) — `ReturnType = type table`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/Diagnostics.pqm#L5) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
    * [KyvosODBC.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L230) — `error Error.Record(Parts[error], Parts[message]?)`
    * [KyvosODBC.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L147) — `ManualStatusHandling={404}`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [KyvosODBC.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/KyvosODBC/KyvosODBC.pq#L144) — `properties = Json.Document(Web.Contents(normalizedURL,`
