---
type: Power Query Connector
title: IndustrialConnector
description: Connect to IndustrialConnector
tags: [errors, navigation, oauth2, packaging, parameter-metadata, pkce, response-metadata, schema, web-requests]
x-pqkb-publisher: IntelligentPlant
x-pqkb-version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq
  title: IndustrialAppStore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IndustrialAppStore/3.0.1/IndustrialAppStore_3.0.1.pqx
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
| IntelligentPlant | 3.0.1 | Not declared |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm)
* [IndustrialAppStore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L80) — `Documentation.FieldCaption = "Tags",`
    * [IndustrialAppStore.pq line 477](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L477) — `outputFunction = Value.ReplaceType(tagSearchInternal, tagSearchFunctionSignatureWithMeta)`
    * [IndustrialAppStore.pq line 473](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L473) — `tagSearchFunctionSignatureWithMeta = type function(tagName as TagNameType, optional pageSize as SizeType, optional pageNumber as PageType) as table meta [`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 317](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L317) — `navtable = Table.ToNavigationTable(withIsLeaf, {"UrlName"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [IndustrialAppStore.pq line 1486](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1486) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 289](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L289) — `OAuth = [`
    * [IndustrialAppStore.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L290) — `StartLogin = IndustrialAppStore.StartLogin,`
    * [IndustrialAppStore.pq line 291](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L291) — `FinishLogin = IndustrialAppStore.FinishLogin,`
    * [IndustrialAppStore.pq line 1506](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1506) — `grant_type = grantType,`
    * [IndustrialAppStore.pq line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L377) — `content = Web.Contents(url),`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 1169](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1169) — `code_challenge = CreateCodeChallange(codeVerifier),`
    * [IndustrialAppStore.pq line 1502](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1502) — `codeVerifier = if (codeVerifier <> null) then [code_verifier = codeVerifier] else [],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L9) — `Configuration = Json.Document(Extension.Contents("config.json"));`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 1283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1283) — `response_code = Value.Metadata(response)[Response.Status], // get response code`
    * [IndustrialAppStore.pq line 1266](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1266) — `Headers =[`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm#L85) — `if base = type table then "table" else`
    * [IndustrialAppStore.pq line 477](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L477) — `outputFunction = Value.ReplaceType(tagSearchInternal, tagSearchFunctionSignatureWithMeta)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [IndustrialAppStore.pq line 383](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L383) — `Type = error Error.Record(`
    * [IndustrialAppStore.pq line 169](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L169) — `parseResult = if (input <> null or input <> "") then try DateTimeZone.From(input) else null,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [IndustrialAppStore.pq line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L377) — `content = Web.Contents(url),`
