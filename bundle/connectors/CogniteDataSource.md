---
type: Power Query Connector
title: Cognite Data Fusion (REST API)
description: Connect to Cognite Data Fusion (CDF)
tags: [errors, graphql, navigation, oauth, oauth2, odata, packaging, pagination, parameter-metadata, pkce, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: CogniteDataSource
x-pqkb-version: 1.1.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq
  title: CogniteDataSource.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CogniteDataSource/1.1.3/CogniteDataSource_1.1.3.pqx
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
| CogniteDataSource | 1.1.3 | OAuth |

# Source files

* [CogniteDataSource.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm)
* [Value.ToText.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [CogniteDataSource.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L314) — `organization = Extension.CurrentCredential()[Properties][Organization]?,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L56) — `Documentation.FieldCaption = Extension.LoadString("ProjectName"),`
    * [CogniteDataSource.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L50) — `shared CogniteDataSource.Contents = Value.ReplaceType(CogniteDataSourceImpl, CogniteDataSourceType);`
    * [CogniteDataSource.pq line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L53) — `CogniteDataSourceType = type function (`
    * [Table.GenerateByPage.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L24) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm#L21) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [GraphQL requests](../patterns/graphql.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 1010](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L1010) — `postData = Json.FromValue([query = payload, variables = variablesUpdated]),`
    * [CogniteDataSource.pq line 198](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L198) — `Text.FromBinary(Json.FromValue(path)),`
    * [CogniteDataSource.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L132) — `Response = Web.Contents(`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 301](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L301) — `NavTable = Table.ToNavigationTable(`
    * [Table.ToNavigationTable.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm#L15) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L215) — `OAuth = [`
    * [CogniteDataSource.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L84) — `StartLogin = (dataSourcePath, state, display) =>`
    * [CogniteDataSource.pq line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L157) — `FinishLogin = (clientApplication, dataSourcePath, context, callbackUri, state) =>`
    * [CogniteDataSource.pq line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L128) — `if (grant_type = "authorization_code") then`
    * [CogniteDataSource.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L132) — `Response = Web.Contents(`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 544](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L544) — `source = OData.Feed(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 696](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L696) — `Table.GenerateByPage(`
    * [CogniteDataSource.pq line 555](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L555) — `offset = Table.PositionOf(source, rowToReplace, 0, "Name"),`
    * [Table.GenerateByPage.pqm line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L7) — `listOfPages = List.Generate(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L104) — `code_challenge = codeChallenge,`
    * [CogniteDataSource.pq line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L114) — `Context = [code_verifier = codeVerifier]`
    * [CogniteDataSource.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L89) — `Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L56) — `Documentation.FieldCaption = Extension.LoadString("ProjectName"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 661](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L661) — `if (List.Contains({200}, Value.Metadata(endpointResponse)[Response.Status]?)) then`
    * [CogniteDataSource.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L144) — `Headers = [#"Content-type" = "application/x-www-form-urlencoded", #"Accept" = "application/json"]`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 715](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L715) — `Function.InvokeAfter(`
    * [CogniteDataSource.pq line 693](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L693) — `pageDelay = #duration(0, 0, 0, CogniteDefaults[StreamsPageDelayMs] / 1000),`
    * [CogniteDataSource.pq line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L126) — `CodeVerifier = if (context <> null) then [code_verifier = context[code_verifier]] else [],`
    * [Table.GenerateByPage.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L18) — `if (firstRow = null) then`
    * [Value.ToText.pqm line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm#L67) — `List.Accumulate(x, "", (seed,item) => if seed="" then Serialize(item) else seed & ", " & Serialize(item)) &`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L50) — `shared CogniteDataSource.Contents = Value.ReplaceType(CogniteDataSourceImpl, CogniteDataSourceType);`
    * [CogniteDataSource.pq line 954](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L954) — `else if (Type.Is(Value.Type(preProcessing), type table)) then`
    * [Table.GenerateByPage.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L24) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm#L21) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Value.ToText.pqm line 170](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm#L170) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L166) — `error Error.Record("DataSource.Error", Parts[error_description])`
    * [CogniteDataSource.pq line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L166) — `error Error.Record("DataSource.Error", Parts[error_description])`
    * [Value.ToText.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm#L10) — `try`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [CogniteDataSource.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L132) — `Response = Web.Contents(`
