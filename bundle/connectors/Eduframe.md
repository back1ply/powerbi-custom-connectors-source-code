---
type: Power Query Connector
title: Eduframe
description: Power BI connector source for Eduframe.
tags: [credentials, key, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, response-metadata, retry-polling, web-requests]
x-pqkb-publisher: Eduframe
x-pqkb-version: 2.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq
  title: EduFrame.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm
  title: Requests.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Eduframe/2.3.0/Eduframe_2.3.0.pqx
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
| Eduframe | 2.3.0 | Key, OAuth |

# Source files

* [EduFrame.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq)
* [Requests.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Requests.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L27) — `let is_bearer_token = Extension.CurrentCredential()[AuthenticationKind] = "Key" in`
    * [Requests.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L27) — `let is_bearer_token = Extension.CurrentCredential()[AuthenticationKind] = "Key" in`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L123) — `Documentation.FieldCaption = Extension.LoadString("DomainSlug"),`
    * [EduFrame.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L14) — `shared EduFrame.Contents = Value.ReplaceType(NavTable, NavTableType);`
    * [EduFrame.pq line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L110) — `type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L143) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [EduFrame.pq line 228](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L228) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 251](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L251) — `OAuth = [`
    * [EduFrame.pq line 253](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L253) — `StartLogin = StartLogin,`
    * [EduFrame.pq line 254](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L254) — `FinishLogin = FinishLogin,`
    * [EduFrame.pq line 312](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L312) — `codeParameter = if (grant_type = "authorization_code") then [ code = code ] else [ refresh_token = code ], // This way can can handle RefreshLogin automatically using the same method`
    * [EduFrame.pq line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L320) — `Response = Web.Contents("https://api.eduframe.nl/login/oauth2/token", [`
    * [Requests.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L19) — `result = Web.Contents(url, AddAuthHeader(options)),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Requests.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L74) — `List.Combine(List.Generate(`
    * [Requests.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L12) — `else Json.Document(content) meta [Next=GetNextLink(content)],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L5) — `client_id = Text.FromBinary(Extension.Contents("client_id"));`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 322](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L322) — `Headers = [`
    * [Requests.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L20) — `status = Value.Metadata(result)[Response.Status]`
    * [Requests.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L20) — `status = Value.Metadata(result)[Response.Status]`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L180) — `let base_query_params = if query <> null then query else [] in`
    * [Requests.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L9) — `content = Value.WaitFor(Fetcher(url, query), timeout, 10)`
    * [Requests.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L8) — `timeout = (iteration) => if iteration = 0 then #duration(0, 0, 0, 0) else #duration(0, 0, 1, 5), // Wait 65 seconds before trying again. Adds up to 5:30 minutes delay total which is our rate limiting duration.`
    * [Requests.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L8) — `timeout = (iteration) => if iteration = 0 then #duration(0, 0, 0, 0) else #duration(0, 0, 1, 5), // Wait 65 seconds before trying again. Adds up to 5:30 minutes delay total which is our rate limiting duration.`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [EduFrame.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L14) — `shared EduFrame.Contents = Value.ReplaceType(NavTable, NavTableType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [EduFrame.pq line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L320) — `Response = Web.Contents("https://api.eduframe.nl/login/oauth2/token", [`
    * [Requests.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L19) — `result = Web.Contents(url, AddAuthHeader(options)),`
