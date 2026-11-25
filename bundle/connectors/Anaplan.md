---
type: Power Query Connector
title: AnaplanConnector
description: Connect to AnaplanConnectorV2
tags: [credentials, errors, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, pkce, response-metadata, usernamepassword, web-requests]
x-pqkb-publisher: Anaplan
x-pqkb-version: 2.9.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq
  title: Anaplan.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/TraceContext.pqm
  title: TraceContext.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Anaplan/2.9.0/Anaplan_2.9.0.pqx
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
| Anaplan | 2.9.0 | OAuth, UsernamePassword |

# Source files

* [Anaplan.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm)
* [TraceContext.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/TraceContext.pqm)

# Pattern evidence

* [Asynchronous exports and result downloads](../patterns/async-exports.md)
  * **Uncertain match (older review)**
    * [Anaplan.pq line 509](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L509) — `hasTasksInProgress = List.MatchesAny(source[tasks], each _[taskState] = Extension.LoadString("TaskInProgress"))`
    * [Anaplan.pq line 628](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L628) — `fileDownload = (taskId as text) =>`
    * [Anaplan.pq line 637](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L637) — `WebServiceCalls = List.Transform(Numbers, each Function.InvokeAfter(() => getTaskStatus(_), if _ > 1 then DelayBetweenAttempts else #duration(0,0,0,0))),`
    * [Anaplan.pq line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L110) — `Response = Web.Contents(full_token_uri, [`
* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Anaplan.pq line 172](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L172) — `buffered = Binary.Buffer(response),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 322](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L322) — `credential = Extension.CurrentCredential() as record,`
    * [Anaplan.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L95) — `result =  TokenMethod(oldCredential[refresh_token], "refresh_token", token_host)`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 294](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L294) — `Documentation.FieldCaption = "Anaplan API URL",`
    * [Anaplan.pq line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L287) — `shared Anaplan.Contents = Value.ReplaceType(Anaplan.Connect, AnaplanType);`
    * [Anaplan.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L292) — `AnaplanType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 357](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L357) — `asNav = Table.ToNavigationTable(withLeaf, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Anaplan.pq line 767](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L767) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L227) — `OAuth = [`
    * [Anaplan.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L54) — `StartLogin = (resourceUrl, state, display) =>`
    * [Anaplan.pq line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L86) — `FinishLogin = (context, callbackUri, state) =>`
    * [Anaplan.pq line 106](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L106) — `grant_type = grantType,`
    * [Anaplan.pq line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L110) — `Response = Web.Contents(full_token_uri, [`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 779](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L779) — `list = List.Generate(`
    * [Anaplan.pq line 379](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L379) — `resp[meta][paging][next] <> null`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L68) — `code_challenge = codeVerifier,`
    * [Anaplan.pq line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L101) — `codeVerifier = if (context <> null) then [code_verifier = context[codeVerifier]?] else [],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L234) — `Label = Extension.LoadString("Anaplan")`
    * [TraceContext.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/TraceContext.pqm#L21) — `tracePath = Extension.LoadString("AConnectHeaderValue")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L173) — `statusCode = Value.Metadata(response)[Response.Status],`
    * [Anaplan.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L112) — `Headers=[`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [Anaplan.pq line 637](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L637) — `WebServiceCalls = List.Transform(Numbers, each Function.InvokeAfter(() => getTaskStatus(_), if _ > 1 then DelayBetweenAttempts else #duration(0,0,0,0))),`
    * [Anaplan.pq line 605](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L605) — `Timeout = #duration(0, 0, Number.FromText(Extension.LoadString("RequestTimeoutMinutes")), 0)]),`
    * [Anaplan.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L60) — `trimmedOauthAuthUrl = if oauthAuthUrl <> null then Text.Trim(oauthAuthUrl) else null,`
    * [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm#L8) — `if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Anaplan.pq line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L287) — `shared Anaplan.Contents = Value.ReplaceType(Anaplan.Connect, AnaplanType);`
    * [Diagnostics.pqm line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm#L85) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 120](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L120) — `error Error.Record(Parts[error], Parts[message]?)`
    * [Anaplan.pq line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L119) — `if (Parts[error]? <> null) then`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Anaplan.pq line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L110) — `Response = Web.Contents(full_token_uri, [`
    * [Anaplan.pq line 667](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L667) — `RelativePath = Extension.LoadString("AuthTokenPath"),`
