---
type: Power Query Connector
title: Entersoft Business Suite
description: Connect to Entersoft Business Suite
tags: [credentials, navigation, oauth, packaging, web-requests]
x-pqkb-publisher: Entersoft
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m
  title: Entersoft_Business_Suite.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/EntersoftBusinessSuite/1.0.0/EntersoftBusinessSuite_1.0.0.pqx
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
| Entersoft | 1.0.0 | OAuth |

# Source files

* [Entersoft_Business_Suite.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Entersoft_Business_Suite.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L130) — `skey = Extension.CurrentCredential()[access_token],`
    * [Entersoft_Business_Suite.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L130) — `skey = Extension.CurrentCredential()[access_token],`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Entersoft_Business_Suite.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L44) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Entersoft_Business_Suite.m line 263](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L263) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [Entersoft_Business_Suite.m line 277](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L277) — `OAuth = [`
    * [Entersoft_Business_Suite.m line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L278) — `StartLogin = StartLogin,`
    * [Entersoft_Business_Suite.m line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L279) — `FinishLogin = FinishLogin,`
    * [Entersoft_Business_Suite.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L132) — `wb = Web.Contents(url, [Headers = [#"Authorization" = "Bearer " & skey]]),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [Entersoft_Business_Suite.m line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L212) — `List.Combine(List.Generate( () =>`
    * [Entersoft_Business_Suite.m line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L202) — `pqoptions = Json.FromValue([#"WithCount" = "false", #"Page" = pageNo, #"PageSize" = ES_PQ_PAGESIZE]),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Entersoft_Business_Suite.m line 281](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L281) — `Label = Extension.LoadString("AuthenticationLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Entersoft_Business_Suite.m line 269](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L269) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Entersoft_Business_Suite.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L132) — `wb = Web.Contents(url, [Headers = [#"Authorization" = "Bearer " & skey]]),`
