---
type: Power Query Connector
title: Eduframe
description: Power BI connector source for Eduframe.
tags: [credentials, key, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, response-metadata, retry-polling, web-requests]
x-pqkb-publisher: Eduframe
x-pqkb-version: 2.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq
  title: EduFrame.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm
  title: Requests.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Eduframe/2.4.0/Eduframe_2.4.0.pqx
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
| Eduframe | 2.4.0 | Key, OAuth |

# Source files

* [EduFrame.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq)
* [Requests.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Requests.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L29) — `let is_bearer_token = Extension.CurrentCredential()[AuthenticationKind] = "Key" in`
    * [Requests.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L29) — `let is_bearer_token = Extension.CurrentCredential()[AuthenticationKind] = "Key" in`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L129) — `Documentation.FieldCaption = Extension.LoadString("DomainSlug"),`
    * [EduFrame.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L19) — `shared EduFrame.Contents = Value.ReplaceType(NavTable, NavTableType);`
    * [EduFrame.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L116) — `type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L149) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [EduFrame.pq line 328](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L328) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 351](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L351) — `OAuth = [`
    * [EduFrame.pq line 353](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L353) — `StartLogin = StartLogin,`
    * [EduFrame.pq line 354](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L354) — `FinishLogin = FinishLogin,`
    * [EduFrame.pq line 412](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L412) — `codeParameter = if (grant_type = "authorization_code") then [ code = code ] else [ refresh_token = code ], // This way can can handle RefreshLogin automatically using the same method`
    * [EduFrame.pq line 420](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L420) — `Response = Web.Contents(eduframe_token_url, [`
    * [Requests.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L3) — `DefaultHttp = (url as text, options as record) as binary => Web.Contents(url, AddAuthHeader(options)),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Requests.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L76) — `List.Combine(List.Generate(`
    * [Requests.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L14) — `else Json.Document(content) meta [Next=GetNextLink(content)],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L5) — `client_id = Text.FromBinary(Extension.Contents("client_id"));`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 422](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L422) — `Headers = [`
    * [Requests.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L22) — `status = Value.Metadata(result)[Response.Status]`
    * [Requests.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L22) — `status = Value.Metadata(result)[Response.Status]`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L224) — `floor = (v as datetimezone) => let t = fmt(v) in if DateTimeZone.FromText(t) <= v then t else fmt(v - #duration(0, 0, 0, 1)),`
    * [EduFrame.pq line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L209) — `if bounds = null then error "Filter cannot be folded to /availability_blocks"`
    * [Requests.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L11) — `content = Value.WaitFor(Fetcher(url, query, http ?? DefaultHttp), timeout, 10)`
    * [Requests.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L10) — `timeout = (iteration) => if iteration = 0 then #duration(0, 0, 0, 0) else #duration(0, 0, 1, 5), // Wait 65 seconds before trying again. Adds up to 5:30 minutes delay total which is our rate limiting duration.`
    * [Requests.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L10) — `timeout = (iteration) => if iteration = 0 then #duration(0, 0, 0, 0) else #duration(0, 0, 1, 5), // Wait 65 seconds before trying again. Adds up to 5:30 minutes delay total which is our rate limiting duration.`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [EduFrame.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L19) — `shared EduFrame.Contents = Value.ReplaceType(NavTable, NavTableType);`
    * [EduFrame.pq line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L183) — `AvailabilityBlocksType = type table [`
* [Table.View handlers](../patterns/table-view.md)
  * **Unreviewed match**
    * [EduFrame.pq line 193](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L193) — `View = (state as record) => Table.View(null, [`
    * [EduFrame.pq line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L194) — `GetType = () => AvailabilityBlocksType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 420](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L420) — `Response = Web.Contents(eduframe_token_url, [`
    * [Requests.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L3) — `DefaultHttp = (url as text, options as record) as binary => Web.Contents(url, AddAuthHeader(options)),`
