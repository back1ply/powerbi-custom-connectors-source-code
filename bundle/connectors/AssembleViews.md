---
type: Power Query Connector
title: Assemble Views
description: Connect to Assemble Views
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, web-requests]
x-pqkb-publisher: Autodesk
x-pqkb-version: 4.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m
  title: AssembleViews.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AssembleViews/4.1.0/AssembleViews_4.1.0.pqx
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
| Autodesk | 4.1.0 | OAuth |

# Source files

* [AssembleViews.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [AssembleViews.m line 346](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L346) — `ModelVersionDataFunctionType = Diagnostics.Trace(TraceLevel.Information, BuildModelVersionDataFunctionTypeString,`
    * [AssembleViews.m line 346](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L346) — `ModelVersionDataFunctionType = Diagnostics.Trace(TraceLevel.Information, BuildModelVersionDataFunctionTypeString,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L9) — `Documentation.FieldCaption = "Assemble Url",`
    * [AssembleViews.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L5) — `shared AssembleViews.Feed = Value.ReplaceType(NavigationTable.Nested, AssembleViewsFeedType);`
    * [AssembleViews.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L7) — `AssembleViewsFeedType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L24) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [AssembleViews.m line 997](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L997) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 792](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L792) — `OAuth = [`
    * [AssembleViews.m line 793](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L793) — `StartLogin=StartLogin,`
    * [AssembleViews.m line 794](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L794) — `FinishLogin=FinishLogin,`
    * [AssembleViews.m line 856](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L856) — `grant_type = grantType,`
    * [AssembleViews.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L143) — `source = Web.Contents(resourceUrl, options),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [AssembleViews.m line 635](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L635) — `Table.GenerateByPage((previous) =>`
    * [AssembleViews.m line 640](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L640) — `page = if (nextLink <> null) then dataFunc(nextLink) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 801](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L801) — `redirect_uri = Extension.LoadString("redirect_uri");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [AssembleViews.m line 318](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L318) — `ReplacedVersionMeta = Value.ReplaceMetadata(VersionNumbersMeta, Value.Metadata(VersionNumbersMeta) & [Documentation.AllowedValues = VersionsTable[NameAndNumber]]),`
    * [AssembleViews.m line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L163) — `Headers = GetWebRequestHeaders(url)`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AssembleViews.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L5) — `shared AssembleViews.Feed = Value.ReplaceType(NavigationTable.Nested, AssembleViewsFeedType);`
    * [AssembleViews.m line 297](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L297) — `ToTable = #table(type table[name=text,Image=text],CombineLists),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L244) — `else error Error.Record("Parameter 'viewAtDate' must be a date, datetime, or datetimezone type."),`
    * [AssembleViews.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L34) — `projectsAddData = Table.AddColumn(projectsRenameColumns, "Data", each try GetProjectFolders(resourceUrl, [Key], [Name]) otherwise null),`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [AssembleViews.m line 478](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L478) — `GetView = (state as record) => Table.View(`
    * [AssembleViews.m line 483](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L483) — `GetType = () =>`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AssembleViews.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L143) — `source = Web.Contents(resourceUrl, options),`
