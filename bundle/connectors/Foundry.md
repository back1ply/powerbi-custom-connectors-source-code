---
type: Power Query Connector
title: Palantir Foundry Datasets
description: Connect to Palantir Foundry datasets
tags: [credentials, errors, key, navigation, oauth, oauth2, odbc, packaging, parameter-metadata, pkce, schema, usernamepassword]
x-pqkb-publisher: Palantir
x-pqkb-version: 1.3.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m
  title: Foundry.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Foundry/1.3.1/Foundry_1.3.1.pqx
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
| Palantir | 1.3.1 | Key, OAuth, UsernamePassword |

# Source files

* [Foundry.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Foundry.m line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L95) — `credentials = Extension.CurrentCredential(),`
    * [Foundry.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L96) — `tokenRecord = Foundry.ClientCredentialsExchange(multipassApiPath, credentials[Username], credentials[Password])`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Foundry.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L25) — `Documentation.FieldCaption = Extension.LoadString("BaseUriFieldCaption"),`
    * [Foundry.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L20) — `shared Foundry.Contents = Value.ReplaceType(Foundry.Impl, Foundry.Type);`
    * [Foundry.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L22) — `Foundry.Type = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Foundry.m line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L113) — `navTable = Table.ToNavigationTable(withItemName, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Foundry.m line 417](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L417) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Foundry.m line 366](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L366) — `OAuth = [`
    * [Foundry.m line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L259) — `Foundry.StartLogin = (resourceUrl, state, display) =>`
    * [Foundry.m line 282](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L282) — `Foundry.FinishLogin = (context, callbackUri, state) =>`
    * [Foundry.m line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L287) — `grant_type="authorization_code",`
    * [Foundry.m line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L224) — `response = Json.Document(Web.Contents(url, settingsWithAuth))`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Foundry.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L65) — `res = Odbc.Query([DSN=DSN_NAME,local="true"], "SELECT 1", [`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Foundry.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L270) — `code_challenge = codeChallenge,`
    * [Foundry.m line 288](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L288) — `code_verifier=context[CodeVerifier],`
    * [Foundry.m line 264](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L264) — `codeChallenge = Text.Base64UrlEncodeWithoutPadding(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Foundry.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L11) — `oauthClientId = Text.FromBinary(Extension.Contents("client_id"));`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Foundry.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L20) — `shared Foundry.Contents = Value.ReplaceType(Foundry.Impl, Foundry.Type);`
    * [Foundry.m line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L109) — `else Foundry.OdbcSingleDatasetTable(baseUrl, token, [path]), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Foundry.m line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L89) — `validToken = if ignored <> null then token else error Error.Record("Unreachable", "Authentication Error")`
    * [Foundry.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L49) — `uri = if Foundry.CheckDriverAvailable() then BaseUri else error "unreachable",`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Foundry.m line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L224) — `response = Json.Document(Web.Contents(url, settingsWithAuth))`
