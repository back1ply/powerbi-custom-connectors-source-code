---
type: Power Query Connector
title: Profisee
description: Connect to Profisee, and get the data from Profisee data source
tags: [errors, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Profisee
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m
  title: Profisee.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm
  title: SchemaTransformTable.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Profisee/2.0.0/Profisee_2.0.0.pqx
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
| Profisee | 2.0.0 | OAuth |

# Source files

* [Profisee.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m)
* [SchemaTransformTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Profisee.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L8) — `Documentation.FieldCaption = Extension.LoadString("ProfiseeInstanceURLFieldCaption"),`
    * [Profisee.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L5) — `shared Profisee.Tables = Value.ReplaceType(ProfiseeFeedImpl, ProfiseeImplType);`
    * [Profisee.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L7) — `ProfiseeImplType  = type function (url as (Uri.Type meta [`
    * [SchemaTransformTable.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm#L50) — `withType = if (_enforceSchema = 1) then Value.ReplaceType(enforcedTypes, SchemaToTableType(schema)) else enforcedTypes`
    * [Table.GenerateByPage.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm#L17) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Profisee.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L64) — `navigationTable = Table.ToNavigationTable(entityNamesTable & GetEntitiesDQTable(baseURL, entityNames) & GetDataQualitiesTable(baseURL), {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [Profisee.m line 243](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L243) — `OAuth = [`
    * [Profisee.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L182) — `StartLogin = (resourceUrl, state, display) =>`
    * [Profisee.m line 203](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L203) — `FinishLogin = (clientApplication, dataSourcePath, context, callbackUri, state) =>`
    * [Profisee.m line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L216) — `grant_type = "refresh_token",`
    * [Profisee.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L39) — `raw = Json.Document(Web.Contents(url,  [ManualStatusHandling={400}])),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Profisee.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L130) — `Table.GenerateByPage((previous) =>`
    * [Profisee.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L135) — `page = if (nextLink <> null) then GetPage(nextLink, entitySchemaTable) else null`
    * [Table.GenerateByPage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm#L3) — `listOfPages = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Profisee.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L8) — `Documentation.FieldCaption = Extension.LoadString("ProfiseeInstanceURLFieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Profisee.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L49) — `responseMetadata = Value.Metadata(webContent),`
    * [Profisee.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L50) — `responseCode = responseMetadata[Response.Status],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Profisee.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L5) — `shared Profisee.Tables = Value.ReplaceType(ProfiseeFeedImpl, ProfiseeImplType);`
    * [SchemaTransformTable.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm#L15) — `changedPrimatives = Table.TransformColumnTypes(table, primativeTransforms)`
    * [SchemaTransformTable.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/SchemaTransformTable.pqm#L26) — `type table (toType),`
    * [Table.GenerateByPage.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.GenerateByPage.pqm#L17) — `Value.ReplaceType(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Profisee.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L40) — `output = if Record.HasFields(raw, "errors") and raw[errors]<>null and List.Count(Record.FieldValues(raw[errors])) > 0 then error Error.Record(raw[title], "", List.First(List.First(Record.FieldValues(raw[errors])))) else raw`
    * [Profisee.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L39) — `raw = Json.Document(Web.Contents(url,  [ManualStatusHandling={400}])),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Profisee.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Profisee/Profisee.m#L39) — `raw = Json.Document(Web.Contents(url,  [ManualStatusHandling={400}])),`
