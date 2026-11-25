---
type: Power Query Connector
title: MicrostrategyDataset
description: Import data from Strategy Dataset
tags: [buffering, credentials, errors, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, pkce, response-metadata, retry-polling, schema, table-view, usernamepassword, web-requests]
x-pqkb-publisher: MicroStrategy
x-pqkb-version: 2.5.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m
  title: MicroStrategyDataset.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrostrategyDataset/2.5.0/MicrostrategyDataset_2.5.0.pqx
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
| MicroStrategy | 2.5.0 | OAuth, UsernamePassword |

# Source files

* [MicroStrategyDataset.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 648](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L648) — `resultCombined = List.Buffer(List.Combine(List.Transform(fetchedPages, toTableRows))),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L102) — `credentials = Extension.CurrentCredential(),`
    * [MicroStrategyDataset.m line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L103) — `_authMode = if credentials[AuthenticationKind] = "OAuth" then`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L62) — `Documentation.FieldCaption = Extension.LoadString("ApiUrl"),`
    * [MicroStrategyDataset.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L18) — `shared MicroStrategyDataset.Contents = Value.ReplaceType(MicroStrategyDataset.Contents.Impl, MicroStrategyDataset.Contents.Type);`
    * [MicroStrategyDataset.m line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L24) — `type function (libraryUrl as Uri.Type) as any`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 329](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L329) — `nt = Table.ToNavigationTable(ot, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [MicroStrategyDataset.m line 1699](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1699) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L34) — `OAuth = [`
    * [MicroStrategyDataset.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L36) — `StartLogin = OAuth.StartLogin,`
    * [MicroStrategyDataset.m line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L37) — `FinishLogin = OAuth.FinishLogin,`
    * [MicroStrategyDataset.m line 247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L247) — `grant_type = grantType,`
    * [MicroStrategyDataset.m line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L254) — `tokenResponse = Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 641](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L641) — `pagesToFetch = List.Generate(deriveFirstPage, each _{0} < paging[rowCount], each derivePage(_)),`
    * [MicroStrategyDataset.m line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L517) — `GetRowCount = () as number => state[rowCount] - state[offset],`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L192) — `code_challenge = commonOIDCProperties[codeChallenge],`
    * [MicroStrategyDataset.m line 251](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L251) — `code_verifier = codeVerifier`
    * [MicroStrategyDataset.m line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L315) — `hash = Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L9) — `LOCALE = Extension.LoadString("Locale");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 889](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L889) — `stateUsedNames = Value.Metadata(state)[usedNames],`
    * [MicroStrategyDataset.m line 257](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L257) — `Headers = [`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 1473](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1473) — `Response = Function.InvokeAfter(() => Rest.GetInstanceStatus(connection, projectId, reportId, instanceId, isCube), #duration(0, 0, 0, 1)),`
    * [MicroStrategyDataset.m line 1123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1123) — `Timeout=#duration(0, 0, 0, connection[timeout])`
    * [MicroStrategyDataset.m line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L103) — `_authMode = if credentials[AuthenticationKind] = "OAuth" then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L18) — `shared MicroStrategyDataset.Contents = Value.ReplaceType(MicroStrategyDataset.Contents.Impl, MicroStrategyDataset.Contents.Type);`
    * [MicroStrategyDataset.m line 908](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L908) — `type table (recordType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1011) — `error Error.Record("MstrApi.Error", errorData[message], Record.RemoveFields(errorData, "message"));`
    * [MicroStrategyDataset.m line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L113) — `error Extension.LoadString("ErrorWrongTimeoutInput")`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 496](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L496) — `View = (state as record) => Table.View(null, [`
    * [MicroStrategyDataset.m line 498](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L498) — `GetType = () => Instance[tableType],`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [MicroStrategyDataset.m line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L254) — `tokenResponse = Web.Contents(`
