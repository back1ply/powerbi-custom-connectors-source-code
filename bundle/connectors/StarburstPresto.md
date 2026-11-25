---
type: Power Query Connector
title: StarburstPresto
description: Power BI connector source for StarburstPresto.
tags: [aad, credentials, errors, key, oauth, odbc, parameter-metadata, usernamepassword, windows]
x-pqkb-publisher: Starburst
x-pqkb-version: 5.4.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq
  title: StarburstEnterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/StarburstPresto/5.4.4/StarburstPresto_5.4.4.pqx
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
| Starburst | 5.4.4 | Aad, Key, OAuth, UsernamePassword, Windows |

# Source files

* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/OdbcConstants.pqm)
* [StarburstEnterprise.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [StarburstEnterprise.pq line 196](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L196) — `Credential = Extension.CurrentCredential(),`
    * [StarburstEnterprise.pq line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L197) — `AuthenticationMode = Credential[AuthenticationKind],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [StarburstEnterprise.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L146) — `Documentation.FieldCaption = "Host",`
    * [StarburstEnterprise.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L21) — `shared StarburstPresto.Contents = Value.ReplaceType(StarburstGenericImpl, StarburstGenericType);`
    * [StarburstEnterprise.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L144) — `type function (`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [StarburstEnterprise.pq line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L37) — `OAuth = [`
    * [StarburstEnterprise.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L38) — `StartLogin = OAuthStartLogin,`
    * [StarburstEnterprise.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L39) — `FinishLogin = OAuthFinishLogin,`
    * [StarburstEnterprise.pq line 578](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L578) — `if (grant_type = "authorization_code") then`
    * [StarburstEnterprise.pq line 599](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L599) — `Web.Contents(`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [StarburstEnterprise.pq line 425](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L425) — `OdbcDataSource = Odbc.DataSource(ConnectionString, OdbcOptions),`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Uncertain match (older review)**
    * [StarburstEnterprise.pq line 518](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L518) — `code_challenge = CreateSha256Hash(codeVerifier),`
    * [StarburstEnterprise.pq line 573](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L573) — `code_verifier = verifier`
    * [StarburstEnterprise.pq line 787](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L787) — `hash = Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Uncertain match (older review)**
    * [StarburstEnterprise.pq line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L133) — `Icon16 = { Extension.Contents("StarburstEnterprise16.png"), Extension.Contents("StarburstEnterprise20.png"), Extension.Contents("StarburstEnterprise24.png"), Extension.Contents("StarburstEnterprise32.png") },`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [StarburstEnterprise.pq line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L493) — `error Error.Record("DataSource.Error", "The Starburst ODBC driver is not installed on the host. Please install the appropriate driver. " & ConnectionHostPort)`
    * [StarburstEnterprise.pq line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L493) — `error Error.Record("DataSource.Error", "The Starburst ODBC driver is not installed on the host. Please install the appropriate driver. " & ConnectionHostPort)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [StarburstEnterprise.pq line 599](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L599) — `Web.Contents(`
