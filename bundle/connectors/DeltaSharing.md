---
type: Power Query Connector
title: Delta Sharing
description: Import Data from Delta Sharing Server
tags: [buffering, credentials, errors, key, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, pkce, response-metadata, retry-polling, schema, web-requests]
x-pqkb-publisher: Databricks
x-pqkb-version: 1.1.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq
  title: DeltaSharing.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DeltaSharing/1.1.4/DeltaSharing_1.1.4.pqx
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
| Databricks | 1.1.4 | Key, OAuth |

# Source files

* [DeltaSharing.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L432) — `processFile = Table.AddColumn(addPartitionColumns, "##data##", each Parquet.Document(Binary.Buffer(ProtectSensitiveQueryParameters([#"##url##"], [ManualCredentials = true])))),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 464](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L464) — `credential = Extension.CurrentCredential(),`
    * [DeltaSharing.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L117) — `refreshToken = oldCredentials[refresh_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 229](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L229) — `Documentation.FieldCaption = Extension.LoadString("ServerURLLabel"),`
    * [DeltaSharing.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L6) — `shared DeltaSharing.Contents =  Value.ReplaceType(GetShares, SharingServerType);`
    * [DeltaSharing.pq line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L227) — `type function (`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L296) — `navTable = Table.ToNavigationTable(renamed, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L24) — `OAuth =  [`
    * [DeltaSharing.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L25) — `StartLogin = OidcStartLogin,`
    * [DeltaSharing.pq line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L26) — `FinishLogin = OidcFinishLogin,`
    * [DeltaSharing.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L121) — `grant_type = "refresh_token",`
    * [DeltaSharing.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L98) — `response = Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 332](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L332) — `list = List.Generate(`
    * [DeltaSharing.pq line 515](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L515) — `page = FetchPage(pageToken),`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 195](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L195) — `code_challenge = codeChallenge,`
    * [DeltaSharing.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L149) — `code_verifier = codeVerifier,`
    * [DeltaSharing.pq line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L183) — `codeChallenge = Base64UrlEncode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L36) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 355](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L355) — `status = if result <> null then Value.Metadata(result)[Response.Status] else -1,`
    * [DeltaSharing.pq line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L102) — `Headers = [`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 335](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L335) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [DeltaSharing.pq line 360](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L360) — `(iteration) => #duration(0, 0, 0, delay * Number.Power(2, iteration)),  // Exponential backoff delay`
    * [DeltaSharing.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L48) — `if List.Count(unexpectedParams) > 0 then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L6) — `shared DeltaSharing.Contents =  Value.ReplaceType(GetShares, SharingServerType);`
    * [DeltaSharing.pq line 571](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L571) — `type table (toType);`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L49) — `error Error.Record("Error", "Only clientId, scope and audience are allowed in Query Parameter, found unexpected: " & Text.Combine(unexpectedParams, ", "))`
    * [DeltaSharing.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L49) — `error Error.Record("Error", "Only clientId, scope and audience are allowed in Query Parameter, found unexpected: " & Text.Combine(unexpectedParams, ", "))`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [DeltaSharing.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L98) — `response = Web.Contents(`
