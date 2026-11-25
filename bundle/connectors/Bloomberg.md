---
type: Power Query Connector
title: Bloomberg
description: Power BI connector source for Bloomberg.
tags: [buffering, diagnostics, errors, graphql, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, pkce, response-metadata, retry-polling, schema, table-view, web-requests]
x-pqkb-publisher: Bloomberg
x-pqkb-version: 2.0.12
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm
  title: Auth.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m
  title: Bloomberg.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Configuration.pqm
  title: Configuration.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm
  title: Data-Handler.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm
  title: Folding.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/JWT.pqm
  title: JWT.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm
  title: Utils.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bloomberg/2.0.12/Bloomberg_2.0.12.pqx
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
| Bloomberg | 2.0.12 | OAuth |

# Source files

* [Auth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm)
* [Bloomberg.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m)
* [Configuration.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Configuration.pqm)
* [Data-Handler.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm)
* [Folding.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm)
* [JWT.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/JWT.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Folding.pqm line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L216) — `Functions = Table.Buffer(Table.SelectRows(Record.ToTable(Library), each try ([Value] is function) otherwise false))`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Bloomberg.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L98) — `query1 =  Diagnostics.LogTrace(TraceLevel.Information, Text.Combine({"Connector version ", ConnectorVersion}), query),`
    * [Diagnostics.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L13) — `LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L13) — `LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Bloomberg.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L66) — `Documentation.FieldCaption = Extension.LoadString("Bql.Query.Dialog.Argument.Caption"),`
    * [Bloomberg.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L7) — `shared Bloomberg.Query = Value.ReplaceType(BloombergQuery, EntryPointType);`
    * [Bloomberg.m line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L63) — `EntryPointType = type function (`
    * [Utils.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L50) — `Value.ReplaceType(`
* [GraphQL requests](../patterns/graphql.md)
  * **Match from a review of older source**
    * [Auth.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L20) — `Web.Contents(Configuration.OAuthBaseUrl & "/as/token.oauth2", [`
    * [Data-Handler.pqm line 289](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L289) — `bodyData = [`
    * [Data-Handler.pqm line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L293) — `body = Text.FromBinary(Json.FromValue(bodyData)),`
    * [Folding.pqm line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L254) — `jsonObject = Json.FromValue(transformedRecord),`
    * [Utils.pqm line 375](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L375) — `rawResult = Web.Contents(Configuration.BqlUrl,`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Utils.pqm line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L296) — `else Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Utils.pqm line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L95) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Auth.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L83) — `StartLogin = (resourceUrl, state, display) =>`
    * [Auth.pqm line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L105) — `FinishLogin = (context, callbackUri, state) =>`
    * [Auth.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L38) — `grant_type = grantType,`
    * [Auth.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L20) — `Web.Contents(Configuration.OAuthBaseUrl & "/as/token.oauth2", [`
    * [Bloomberg.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L132) — `OAuth = [`
    * [Bloomberg.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L38) — `Auth.StartLogin= Auth[StartLogin];`
    * [Bloomberg.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L39) — `Auth.FinishLogin= Auth[FinishLogin];`
    * [Utils.pqm line 375](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L375) — `rawResult = Web.Contents(Configuration.BqlUrl,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Data-Handler.pqm line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L218) — `page = RequestBiAppSql(sql, foldingTransforms, clientContext, traceParentId),`
    * [Utils.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L24) — `listOfPageContents = List.Generate(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Auth.pqm line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L91) — `code_challenge = codeVerifier,`
    * [Auth.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L34) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Auth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L4) — `binary = Extension.Contents(name),`
    * [Bloomberg.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L21) — `binary = Extension.Contents(name),`
    * [Data-Handler.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L4) — `binary = Extension.Contents(name),`
    * [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L4) — `binary = Extension.Contents(name),`
    * [Folding.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L4) — `binary = Extension.Contents(name),`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L4) — `binary = Extension.Contents(name),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Auth.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L22) — `Headers = [`
    * [Data-Handler.pqm line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L164) — `else GetSubsequentPage(Value.Metadata(previous), state[traceParentId])`
    * [Utils.pqm line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L377) — `Headers = headersWithCcrtSubject,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [Auth.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L34) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [Bloomberg.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L101) — `table = if query2 = null`
    * [Data-Handler.pqm line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L70) — `waitForResult = Value.WaitFor(`
    * [Data-Handler.pqm line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L78) — `(iteration) => #duration(0, 0, 0, Configuration.PollDelay),`
    * [Data-Handler.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L75) — `actualResult = if status = "RUNNING" then null else result`
    * [Diagnostics.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L14) — `Diagnostics.LogTrace = if Configuration.EnableTraceOutput then Diagnostics.Trace else (level, message, value) => value,`
    * [Folding.pqm line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L100) — `name=_[Name],order= if _[Order] = 0 then "ASCENDING" else "DESCENDING"`
    * [Utils.pqm line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L111) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [Utils.pqm line 380](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L380) — `Timeout = #duration(0, 0, 1, 0)`
    * [Utils.pqm line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L60) — `if (Record.HasFields(state, tableInfo[tableId]))`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Bloomberg.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L7) — `shared Bloomberg.Query = Value.ReplaceType(BloombergQuery, EntryPointType);`
    * [Diagnostics.pqm line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L202) — `if base = type table then "table" else`
    * [Folding.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L44) — `tableType = Table.Schema(res),`
    * [Utils.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L50) — `Value.ReplaceType(`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Auth.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L46) — `error Error.Record(`
    * [Auth.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L28) — `ManualStatusHandling = {400},`
    * [Bloomberg.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L102) — `then error Error.Record("Invalid argument", "Query argument cannot be null.")`
    * [Bloomberg.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L102) — `then error Error.Record("Invalid argument", "Query argument cannot be null.")`
    * [Data-Handler.pqm line 298](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L298) — `otherwise error Error.Record(`
    * [Data-Handler.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm#L83) — `error "Failed to return data after reaching poll retry attempt limit"`
    * [Diagnostics.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm#L13) — `LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Folding.pqm line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L216) — `Functions = Table.Buffer(Table.SelectRows(Record.ToTable(Library), each try ([Value] is function) otherwise false))`
    * [Utils.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L127) — `then error Error.Record(reason, response[errors]{0}[message])`
    * [Utils.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L127) — `then error Error.Record(reason, response[errors]{0}[message])`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Folding.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L37) — `viewResult = Table.View(null, [`
    * [Folding.pqm line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm#L39) — `GetType = () => GetTypeFromMetadata(state),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Auth.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L20) — `Web.Contents(Configuration.OAuthBaseUrl & "/as/token.oauth2", [`
    * [Utils.pqm line 375](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L375) — `rawResult = Web.Contents(Configuration.BqlUrl,`
