---
type: Power Query Connector
title: eWay-CRM
description: Connect to eWay-CRM
tags: [credentials, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, schema, web-requests]
x-pqkb-publisher: eWayCRM
x-pqkb-version: 2.2.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m
  title: eWay_CRM.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/eWayCRM/2.2.0/eWayCRM_2.2.0.pqx
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
| eWayCRM | 2.2.0 | OAuth |

# Source files

* [eWay_CRM.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L13) — `SessionResult = CreateSession(Extension.CurrentCredential()),`
    * [eWay_CRM.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L57) — `WebServiceUrl = GetWebServiceFromToken(Credential[access_token]),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L216) — `Documentation.FieldCaption = "Include Relations",`
    * [eWay_CRM.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L6) — `shared eWayCRM.Contents = Value.ReplaceType(eWayCRM_Implementation, eWayCRM_Type);`
    * [eWay_CRM.m line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L214) — `eWayCRM_Type = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 326](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L326) — `NavigationTable = Table.ToNavigationTable(ObjectsFinal, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [eWay_CRM.m line 343](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L343) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 424](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L424) — `OAuth = [`
    * [eWay_CRM.m line 370](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L370) — `StartLogin = (resourceUrl, state, display) =>`
    * [eWay_CRM.m line 391](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L391) — `FinishLogin = (context, callbackUri, state) =>`
    * [eWay_CRM.m line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L407) — `grant_type = grant_type])),`
    * [eWay_CRM.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L20) — `AdditionalFields = Json.Document(Web.Contents(AdditionalFieldsUrl,`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 378](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L378) — `code_challenge = CreateSha256Hash(CodeVerifier),`
    * [eWay_CRM.m line 399](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L399) — `CodeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [eWay_CRM.m line 363](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L363) — `Hash = Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L358) — `clientSecret = Text.FromBinary(Extension.Contents("client_secret"));`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L6) — `shared eWayCRM.Contents = Value.ReplaceType(eWayCRM_Implementation, eWayCRM_Type);`
    * [eWay_CRM.m line 463](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L463) — `type table (toType),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [eWay_CRM.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L20) — `AdditionalFields = Json.Document(Web.Contents(AdditionalFieldsUrl,`
