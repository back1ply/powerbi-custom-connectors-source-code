---
type: Power Query Connector
title: BQE CORE
description: Connect to BQE CORE
tags: [errors, navigation, oauth, oauth2, packaging, pagination, web-requests]
x-pqkb-publisher: BQE
x-pqkb-version: 12.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq
  title: BQECore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BQECore/12.0.0/BQECore_12.0.0.pqx
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
| BQE | 12.0.0 | OAuth |

# Source files

* [BQECore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [BQECore.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L137) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [BQECore.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L33) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [BQECore.pq line 2534](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2534) — `OAuth = [`
    * [BQECore.pq line 2535](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2535) — `StartLogin = StartLogin,`
    * [BQECore.pq line 2536](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2536) — `FinishLogin = FinishLogin,`
    * [BQECore.pq line 2579](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2579) — `grant_type = if(grantType="refresh_token") then "refresh_token" else "authorization_code",`
    * [BQECore.pq line 2209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2209) — `Web.Contents(url)`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [BQECore.pq line 466](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L466) — `List.Generate(()=>`
    * [BQECore.pq line 467](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L467) — `[Result = try GetData(url&"resourceschedule/week",1,filters,pageSize) otherwise null, page=1],`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [BQECore.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L3) — `BaseUrl = Extension.LoadString("BaseUrl");`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [BQECore.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L40) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [BQECore.pq line 2567](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2567) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [BQECore.pq line 467](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L467) — `[Result = try GetData(url&"resourceschedule/week",1,filters,pageSize) otherwise null, page=1],`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [BQECore.pq line 2209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2209) — `Web.Contents(url)`
