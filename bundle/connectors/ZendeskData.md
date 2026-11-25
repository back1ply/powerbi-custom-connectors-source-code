---
type: Power Query Connector
title: ZendeskData
description: Power BI connector source for ZendeskData.
tags: [navigation, oauth, oauth2, packaging, pagination, parameter-metadata, schema, web-requests]
x-pqkb-publisher: Zendesk
x-pqkb-version: 2.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm
  title: GetSchemaForEntity.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq
  title: zendesk.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZendeskData/2.0.1/ZendeskData_2.0.1.pqx
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
| Zendesk | 2.0.1 | OAuth |

# Source files

* [GetSchemaForEntity.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm)
* [zendesk.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Table.ChangeType.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L66) — `withType = Value.ReplaceType(changedRecordTypes, tableType)`
    * [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm#L23) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm#L19) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [zendesk.pq line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L69) — `Documentation.FieldCaption = Extension.LoadString("ZendeskFunctionTypeCaption"),`
    * [zendesk.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L65) — `shared ZendeskData.Contents = Value.ReplaceType(ZendeskNavTable, ZendeskFunctionType);`
    * [zendesk.pq line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L67) — `ZendeskFunctionType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Table.ToNavigationTable.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm#L13) — `NavigationTable.NameColumn = nameColumn,`
    * [zendesk.pq line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L157) — `navTable = Table.ToNavigationTable(withTicketCommentsEntity, {"Key"}, "Key", "Data", "ItemKind", "ItemName", "IsLeaf")`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [zendesk.pq line 248](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L248) — `OAuth = [`
    * [zendesk.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L249) — `StartLogin = StartLogin,`
    * [zendesk.pq line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L250) — `FinishLogin = FinishLogin,`
    * [zendesk.pq line 323](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L323) — `grant_type = "authorization_code",`
    * [zendesk.pq line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L102) — `source = Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
    * [zendesk.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L211) — `Table.GenerateByPage(`
    * [zendesk.pq line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L226) — `page = if (hasMore = true) then GetPage(nextLink, schema) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [zendesk.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L8) — `client_id = Text.FromBinary(Extension.Contents("client_id"));`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
    * [zendesk.pq line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L215) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
    * [zendesk.pq line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L105) — `Headers = [#"X-Zendesk-Power-BI-Connector" = "v2"]`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [GetSchemaForEntity.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm#L4) — `TagsType = type table [name = text, count = Int64.Type],`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L44) — `changedPrimitives = Table.TransformColumnTypes(reordered, primitiveTransforms),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm#L23) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm#L19) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [zendesk.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L65) — `shared ZendeskData.Contents = Value.ReplaceType(ZendeskNavTable, ZendeskFunctionType);`
    * [zendesk.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L144) — `withData = Table.AddColumn(rename, "Data", each GetEntity(fullURL, GetEntityFromEntityName([Key])), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [GetSchemaForEntity.pqm line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm#L367) — `try SchemaTable{[Entity = entity]}[Type] otherwise  null//error "Couldn't find entity: '" & entity & "'"`
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [zendesk.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L46) — `try EntityNameTable{[EntityName = entityName]}[Entity] otherwise  error "Couldn't find entity: '" & entityName & "'";`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [zendesk.pq line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L102) — `source = Web.Contents(`
