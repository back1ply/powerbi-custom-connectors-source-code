---
type: Power Query Connector
title: Cherwell
description: Connect to Cherwell Service Management
tags: [navigation, oauth, packaging, schema]
x-pqkb-publisher: Cherwell
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm
  title: Auth.RequestToken.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m
  title: Cherwell.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Uri.ValidateUrlScheme.pqm
  title: Uri.ValidateUrlScheme.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cherwell/1.0.0/Cherwell_1.0.0.pqx
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
| Cherwell | 1.0.0 | OAuth |

# Source files

* [Auth.RequestToken.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm)
* [Cherwell.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm)
* [Uri.ValidateUrlScheme.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Uri.ValidateUrlScheme.pqm)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Cherwell.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L162) — `navTable = Table.ToNavigationTable(#"Applied nav-table columns", {"busObId"},`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [Auth.RequestToken.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm#L22) — `grant_type = grantType,`
    * [Auth.RequestToken.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm#L30) — `response = Web.Contents(`
    * [Cherwell.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L14) — `OAuth = [`
    * [Cherwell.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L15) — `StartLogin = StartLogin,`
    * [Cherwell.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L16) — `FinishLogin = FinishLogin,`
    * [Cherwell.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L119) — `json = Web.Contents(endpoint, options)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Cherwell.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L26) — `Extension.LoadString("ButtonTitle"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Cherwell.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L5) — `shared Cherwell.SavedSearches = Value.ReplaceType(SavedSearches, SavedSearchesType);`
    * [Cherwell.m line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L220) — `#"Added default grid row" = #table(type table [name = text, gridId = text], {{searchName, null}})`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [Auth.RequestToken.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm#L46) — `error Error.Record(result[error], result[error_description], result)`
    * [Auth.RequestToken.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm#L38) — `ManualStatusHandling = {400}`
    * [Cherwell.m line 433](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L433) — `checkUrl = try Uri.ValidateUrlScheme(url),`
    * [Uri.ValidateUrlScheme.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Uri.ValidateUrlScheme.pqm#L3) — `error "URL scheme must be HTTPS"`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Auth.RequestToken.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm#L30) — `response = Web.Contents(`
    * [Cherwell.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L119) — `json = Web.Contents(endpoint, options)`
