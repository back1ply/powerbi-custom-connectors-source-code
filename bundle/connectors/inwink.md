---
type: Power Query Connector
title: inwink
description: Connect to inwink
tags: [navigation, oauth2, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: inwink
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm
  title: auth.startlogin.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq
  title: inwink.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/inwink/1.0.0/inwink_1.0.0.pqx
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
| inwink | 1.0.0 | Not declared |

# Source files

* [auth.startlogin.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm)
* [inwink.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [inwink.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L54) — `Documentation.FieldCaption = "inwink customer ID",`
    * [inwink.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L50) — `shared inwink.ScopeContents = Value.ReplaceType(GetScopeEntities, InwinkScopeType);`
    * [inwink.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L52) — `InwinkScopeType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [inwink.pq line 325](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L325) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [inwink.pq line 479](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L479) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [auth.startlogin.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L24) — `OAuth = [`
    * [auth.startlogin.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L25) — `StartLogin = (resourceUrl, state, display) =>`
    * [auth.startlogin.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L42) — `FinishLogin = (context, callbackUri, state) =>`
    * [auth.startlogin.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L5) — `codeParameter = if (grant_type = "authorization_code") then [ code = code ] else [ refresh_token = code ],`
    * [auth.startlogin.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L13) — `Response = Web.Contents(authSettings[auth_uri] & "/00000000-0000-0000-0000-000000000000/connect/token", [`
    * [inwink.pq line 333](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L333) — `entityTemplate = Json.Document(Web.Contents(url,[`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [inwink.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L364) — `entityData = Table.GenerateByPage((previous) =>`
    * [inwink.pq line 369](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L369) — `page = if (nextPage <> null) then GetDataPage(url, entityConf, nextPage, schema, alterRecord) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [inwink.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L38) — `ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [auth.startlogin.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L15) — `Headers=[#"Content-type" = "application/x-www-form-urlencoded",#"Accept" = "application/json"]]),`
    * [inwink.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L367) — `nextPage = if (previous = null) then 0 else Value.Metadata(previous)[NextPage]?,`
    * [inwink.pq line 334](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L334) — `Headers = [ #"Content-Type"="application/json"]`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [inwink.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L50) — `shared inwink.ScopeContents = Value.ReplaceType(GetScopeEntities, InwinkScopeType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [auth.startlogin.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm#L13) — `Response = Web.Contents(authSettings[auth_uri] & "/00000000-0000-0000-0000-000000000000/connect/token", [`
    * [inwink.pq line 333](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L333) — `entityTemplate = Json.Document(Web.Contents(url,[`
