---
type: Power Query Connector
title: Asana
description: Connect to Asana
tags: [credentials, errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, schema, table-view, web-requests]
x-pqkb-publisher: Asana
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m
  title: Asana.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Asana/1.0.3/Asana_1.0.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T17:23:17Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Asana | 1.0.3 | OAuth |

# Source files

* [Asana.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Asana.m line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L194) — `refresh_token = Extension.CurrentCredential()[refresh_token],`
    * [Asana.m line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L194) — `refresh_token = Extension.CurrentCredential()[refresh_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Asana.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L16) — `Documentation.FieldCaption = Extension.LoadString("UrlParameterCaption"),`
    * [Asana.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L12) — `shared Asana.Tables =  Value.ReplaceType(AsanaNavTable, Asana_Type);`
    * [Asana.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L14) — `Asana_Type = type function (`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Asana.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L32) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Asana.m line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L84) — `OAuth = [`
    * [Asana.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L85) — `StartLogin=StartLogin,`
    * [Asana.m line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L86) — `FinishLogin=FinishLogin,`
    * [Asana.m line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L145) — `grant_type = grantType,`
    * [Asana.m line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L157) — `tokenResponse = Web.Contents(api_url & "/powerbi/auth", [`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Asana.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L117) — `code_challenge = GenerateCodeChallenge(code_verifier),`
    * [Asana.m line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L110) — `code_verifier = GenerateCodeVerifier(),`
    * [Asana.m line 233](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L233) — `result = Binary.ToText(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(str, TextEncoding.Ascii)), BinaryEncoding.Base64)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Asana.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L4) — `config = Json.Document ( Extension.Contents( "Config.json") );`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Asana.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L12) — `shared Asana.Tables =  Value.ReplaceType(AsanaNavTable, Asana_Type);`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Asana.m line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L136) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [Asana.m line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L136) — `error Error.Record(parts[error], parts[error_description], parts)`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Asana.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L39) — `View = (state as record) => Table.View(null, [`
    * [Asana.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L41) — `GetType = () => Value.Type(AsanaSchema()),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Asana.m line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L157) — `tokenResponse = Web.Contents(api_url & "/powerbi/auth", [`
    * [Asana.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L182) — `RelativePath = "/v1/data"`
