---
type: Power Query Connector
title: Celonis EMS
description: Connect to Celonis EMS
tags: [buffering, credentials, errors, key, navigation, packaging, parameter-metadata, response-metadata, table-view, web-requests]
x-pqkb-publisher: Celonis
x-pqkb-version: 2.2.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m
  title: Celonis.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Celonis/2.2.0/Celonis_2.2.0.pqx
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
| Celonis | 2.2.0 | Key |

# Source files

* [Celonis.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Celonis.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L64) — `data = Parquet.Document(Binary.Buffer(response))`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Celonis.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L5) — `APP_KEY = Extension.CurrentCredential()[Key];`
    * [Celonis.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L5) — `APP_KEY = Extension.CurrentCredential()[Key];`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Celonis.m line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L302) — `Documentation.FieldCaption = "Celonis URL",`
    * [Celonis.m line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L309) — `shared Celonis.Navigation = Value.ReplaceType(Spaces, CelonisType);`
    * [Celonis.m line 300](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L300) — `CelonisType = type function (`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Celonis.m line 159](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L159) — `nodes = Table.ToNavigationTable(add4, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Celonis.m line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L29) — `Label = Extension.LoadString("DataSourceLabel")`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Celonis.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L88) — `responseMetadata = Value.Metadata(response),`
    * [Celonis.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L60) — `response = Web.Contents(url, [Headers = [`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Celonis.m line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L94) — `then error Error.Record(status[reason], status[message], status[detail])`
    * [Celonis.m line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L56) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error "Url scheme must be HTTPS" else url;`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Celonis.m line 273](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L273) — `View = (state as record) => Table.View(null, [`
    * [Celonis.m line 274](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L274) — `GetType = () => Value.Type(Record(baseUrl, rootKey, recordKey, datasetId, keyType, 1)),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Celonis.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Celonis/Celonis.m#L60) — `response = Web.Contents(url, [Headers = [`
