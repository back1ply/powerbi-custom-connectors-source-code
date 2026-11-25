---
type: Power Query Connector
title: Dynatrace_Grail_DQL
description: Connect to Dynatrace_Grail_DQL
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, schema, web-requests]
x-pqkb-publisher: Dynatrace
x-pqkb-version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m
  title: DynatraceGrail.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DynatraceGrail/1.0.7/DynatraceGrail_1.0.7.pqx
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
| Dynatrace | 1.0.7 | OAuth |

# Source files

* [DynatraceGrail.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L43) — `Documentation.FieldCaption = "Dynatrace environment",`
    * [DynatraceGrail.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L88) — `shared DynatraceGrail.Contents = Value.ReplaceType(GrailNavTable, GetDataType);`
    * [DynatraceGrail.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L41) — `GetDataType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L101) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),`
    * [DynatraceGrail.m line 334](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L334) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 349](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L349) — `OAuth = [`
    * [DynatraceGrail.m line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L350) — `StartLogin=StartLogin,`
    * [DynatraceGrail.m line 351](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L351) — `FinishLogin=FinishLogin,`
    * [DynatraceGrail.m line 420](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L420) — `grant_type = grantType,`
    * [DynatraceGrail.m line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L156) — `Source = Json.Document(Web.Contents(_url,`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 385](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L385) — `code_challenge = codeVerifier,`
    * [DynatraceGrail.m line 379](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L379) — `Base64Url.Encode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(plainTextCodeVerifier)))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L445) — `Icon16 = { Extension.Contents("Dynatrace_Grail_DQL16.png"), Extension.Contents("Dynatrace_Grail_DQL20.png"), Extension.Contents("Dynatrace_Grail_DQL24.png"), Extension.Contents("Dynatrace_Grail_DQL32.png") },`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L88) — `shared DynatraceGrail.Contents = Value.ReplaceType(GrailNavTable, GetDataType);`
    * [DynatraceGrail.m line 265](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L265) — `EmptyTable = Table.FromRecords({}, type table[ #"metric.key" = Text.Type ]),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L407) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [DynatraceGrail.m line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L37) — `error "Invalid environment name"`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [DynatraceGrail.m line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L156) — `Source = Json.Document(Web.Contents(_url,`
