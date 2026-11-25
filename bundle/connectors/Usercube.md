---
type: Power Query Connector
title: Usercube
description: Connect to Usercube
tags: [credentials, errors, navigation, packaging, pagination, parameter-metadata, response-metadata, schema, table-view, usernamepassword, web-requests]
x-pqkb-publisher: Usercube
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m
  title: Usercube.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Usercube/1.0.0/Usercube_1.0.0.pqx
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
| Usercube | 1.0.0 | UsernamePassword |

# Source files

* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm)
* [Usercube.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Usercube.m line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L241) — `client_id = Extension.CurrentCredential()[Username],`
    * [Usercube.m line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L204) — `#"Authorization" = tokenRecord[token_type] & " " & tokenRecord[access_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Usercube.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L11) — `Documentation.FieldCaption = "Server URL",`
    * [Usercube.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L5) — `shared Usercube.Universes = Value.ReplaceType(UniversesNavTable, UniversesNavTableType);`
    * [Usercube.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L7) — `UniversesNavTableType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
    * [Usercube.m line 82](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L82) — `navTableWithMeta = Table.ToNavigationTable(navTable, {"Name"}, "DisplayName", "Items", "ItemKind", "ItemName", "IsLeaf")`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
    * [Usercube.m line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L185) — `allData = Table.GenerateByPage(getNextPage),`
    * [Usercube.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L182) — `page = if (previous = null or continuationToken <> null) then getPage(continuationToken) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Usercube.m line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L51) — `ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
    * [Usercube.m line 181](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L181) — `continuationToken = if (previous = null or top <> null) then null else Value.Metadata(previous)[ContinuationToken]?,`
    * [Usercube.m line 203](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L203) — `Headers = [`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L44) — `changedPrimitives = Table.TransformColumnTypes(reordered, primitiveTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm#L20) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Usercube.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L5) — `shared Usercube.Universes = Value.ReplaceType(UniversesNavTable, UniversesNavTableType);`
    * [Usercube.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L135) — `dataTableType = type table Type.ForRecord(`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Usercube.m line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L213) — `ManualStatusHandling = {401}`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [Usercube.m line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L111) — `View = (state as record) => Table.View(null, [`
    * [Usercube.m line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L112) — `GetType = () => GetDataTableType(tableDescription),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Usercube.m line 198](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L198) — `response = Web.Contents(serverUrl, [`
    * [Usercube.m line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L199) — `RelativePath = relativePath,`
