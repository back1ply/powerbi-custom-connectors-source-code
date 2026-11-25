---
type: Power Query Connector
title: BuildingConnected & TradeTapp
description: Connect to BuildingConnected & TradeTapp
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, schema, web-requests]
x-pqkb-publisher: Autodesk
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq
  title: BuildingConnected.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Schemas.pqm
  title: Schemas.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BuildingConnected/1.0.6/BuildingConnected_1.0.6.pqx
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
| Autodesk | 1.0.6 | OAuth |

# Source files

* [BuildingConnected.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm)
* [Schemas.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Schemas.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [BuildingConnected.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L145) — `Diagnostics.Trace(TraceLevel.Error, message, () => error message, true);`
    * [BuildingConnected.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L145) — `Diagnostics.Trace(TraceLevel.Error, message, () => error message, true);`
    * [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm#L3) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm#L4) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 181](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L181) — `Documentation.FieldCaption = "Range Start",`
    * [BuildingConnected.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L176) — `shared BuildingConnected.Contents = Value.ReplaceType(BuildingConnectedNavTable, BuildingConnectedType);`
    * [BuildingConnected.pq line 179](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L179) — `BuildingConnectedType = type function (`
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm#L23) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm#L19) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 223](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L223) — `navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm#L13) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L101) — `OAuth = [`
    * [BuildingConnected.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L18) — `StartLogin = (resourceUrl, state, display) =>`
    * [BuildingConnected.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L55) — `FinishLogin = (context, callbackUri, state) =>`
    * [BuildingConnected.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L65) — `codeParameter = if (grant_type = "authorization_code") then [code = code] else [refresh_token = code],`
    * [BuildingConnected.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L74) — `Response = Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [BuildingConnected.pq line 465](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L465) — `Table.GenerateByPage(`
    * [BuildingConnected.pq line 505](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L505) — `page = if (nextLink <> null) then GetPage(nextLink, schema) else null`
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L39) — `code_challenge = codeVerifier,`
    * [BuildingConnected.pq line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L64) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [BuildingConnected.pq line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L27) — `Base64Url.Encode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(plainTextCodeVerifier)))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L6) — `client_id_us = Extension.LoadString("CLIENT_ID_US");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [BuildingConnected.pq line 365](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L365) — `statusCode = Value.Metadata(response)[Response.Status],`
    * [BuildingConnected.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L78) — `Headers = [`
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L176) — `shared BuildingConnected.Contents = Value.ReplaceType(BuildingConnectedNavTable, BuildingConnectedType);`
    * [BuildingConnected.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L214) — `withData_bc = Table.AddColumn(rename_bc, "Data", each GetEntity(url_bc, [Name], SchemaTable_bc, rangeStart, rangeEnd, includeClosed), type table),`
    * [Diagnostics.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm#L112) — `else if base = type table then`
    * [Schemas.pqm line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Schemas.pqm#L36) — `Schema.BidLineItemType = type table [`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L44) — `changedPrimitives = Table.TransformColumnTypes(reordered, primitiveTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.GenerateByPage.pqm#L23) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ToNavigationTable.pqm#L19) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L89) — `error Error.Record(Parts[error], Parts[message]?)`
    * [BuildingConnected.pq line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L29) — `error "Unexpected code_challenge_method",`
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Diagnostics.pqm#L5) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [BuildingConnected.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BuildingConnected/BuildingConnected.pq#L74) — `Response = Web.Contents(`
