---
type: Power Query Connector
title: SurveyMonkey
description: Connect to SurveyMonkey
tags: [credentials, diagnostics, key, navigation, packaging, pagination, response-metadata, schema, web-requests]
x-pqkb-publisher: SurveyMonkey
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm
  title: FetchResource.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m
  title: SurveyMonkey.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SurveyMonkey/1.1.0/SurveyMonkey_1.1.0.pqx
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
| SurveyMonkey | 1.1.0 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm)
* [FetchResource.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm)
* [SurveyMonkey.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [SurveyMonkey.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L66) — `access_token = Extension.CurrentCredential()[Key],`
    * [SurveyMonkey.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L66) — `access_token = Extension.CurrentCredential()[Key],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [SurveyMonkey.m line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L78) — `navTable = Table.ToNavigationTable(source, {"ID"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [SurveyMonkey.m line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L116) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [FetchResource.pqm line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L7) — `listOfPages = List.Generate(`
    * [FetchResource.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L32) — `page = if (nextLink <> null) then GetPage(nextLink, access_token) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SurveyMonkey.m line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L142) — `ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [FetchResource.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L30) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
    * [FetchResource.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L40) — `[Headers=[#"Authorization" = "bearer "& access_token]]),`
    * [SurveyMonkey.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L32) — `responseCode = Diagnostics.LogValue("code", Value.Metadata(response)[Response.Status]),`
    * [SurveyMonkey.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L30) — `[Headers=[#"Authorization" = "bearer "& access_token], ManualStatusHandling={401,403,503}]`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [FetchResource.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L21) — `Value.ReplaceType(`
    * [SurveyMonkey.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L13) — `shared SurveyMonkey.Contents = Value.ReplaceType(SurveyMonkeyNavTable, SurveyMonkeyNavTableType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [FetchResource.pqm line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm#L39) — `response = Web.Contents(url,`
    * [SurveyMonkey.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L28) — `response = Web.Contents(`
