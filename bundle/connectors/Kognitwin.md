---
type: Power Query Connector
title: Kognitwin
description: Connect to Kognitwin
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, schema, web-requests]
x-pqkb-publisher: Kongsberg
x-pqkb-version: 2.5.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq
  title: Kognitwin.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kognitwin/2.5.0/Kognitwin_2.5.0.pqx
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
| Kongsberg | 2.5.0 | OAuth |

# Source files

* [Kognitwin.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L284) — `Documentation.FieldCaption = "Kognitwin URL",`
    * [Kognitwin.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L100) — `Value.ReplaceType(`
    * [Kognitwin.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L279) — `type function (url as`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L81) — `Table.ToNavigationTable(`
    * [Kognitwin.pq line 770](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L770) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L113) — `OAuth = [`
    * [Kognitwin.pq line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L114) — `StartLogin = StartLogin,`
    * [Kognitwin.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L115) — `FinishLogin = FinishLogin,`
    * [Kognitwin.pq line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L197) — `if (grant_type = "authorization_code") then`
    * [Kognitwin.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L214) — `Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Kognitwin.pq line 809](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L809) — `Table.GenerateByPage(`
    * [Kognitwin.pq line 813](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L813) — `cursor = if (previous <> null) then Value.Metadata(previous)[NextCursor] else null,`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L138) — `code_challenge = codeVerifier,`
    * [Kognitwin.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L192) — `code_verifier = verifier`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L121) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Kognitwin.pq line 813](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L813) — `cursor = if (previous <> null) then Value.Metadata(previous)[NextCursor] else null,`
    * [Kognitwin.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L218) — `Headers = [`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L100) — `Value.ReplaceType(`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 229](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L229) — `Error.Record(`
    * [Kognitwin.pq line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L227) — `if (Parts[error]? <> null) then`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Kognitwin.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L214) — `Web.Contents(`
