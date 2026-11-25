---
type: Power Query Connector
title: LinkedInLearning
description: Connect to LinkedInLearning
tags: [credentials, navigation, packaging, usernamepassword, web-requests]
x-pqkb-publisher: LinkedInLearning
x-pqkb-version: 1.0.10
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq
  title: LinkedInLearning.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LinkedInLearning/1.0.10/LinkedInLearning_1.0.10.pqx
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
| LinkedInLearning | 1.0.10 | UsernamePassword |

# Source files

* [LinkedInLearning.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [LinkedInLearning.pq line 359](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L359) — `credentials = Extension.CurrentCredential(),`
    * [LinkedInLearning.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L38) — `token = json_response[access_token]`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [LinkedInLearning.pq line 378](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L378) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [LinkedInLearning.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L17) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [LinkedInLearning.pq line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L64) — `number_list = List.Generate(() => start, each _ <= end, each _ +diff),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [LinkedInLearning.pq line 403](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L403) — `Icon16 = { Extension.Contents("LinkedInLearning16.png"), Extension.Contents("LinkedInLearning20.png"), Extension.Contents("LinkedInLearning24.png"), Extension.Contents("LinkedInLearning32.png") },`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [LinkedInLearning.pq line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L23) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [LinkedInLearning.pq line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L29) — `response = Web.Contents("https://www.linkedin.com", [`
    * [LinkedInLearning.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L30) — `RelativePath = "oauth/v2/accessToken"`
