---
type: Power Query Connector
title: Datamarts
description: Import Datamarts
tags: [aad, diagnostics, errors, navigation, packaging, parameter-metadata, response-metadata, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.12
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq
  title: PowerBIDatamarts.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PowerBIDatamarts/1.0.12/PowerBIDatamarts_1.0.12.pqx
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
| Microsoft | 1.0.12 | Aad |

# Source files

* [PowerBIDatamarts.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [PowerBIDatamarts.pq line 260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L260) — `(datasource) => Extension.CurrentCredential(),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L187) — `loggedActivityId = Diagnostics.Trace(TraceLevel.Information, [Name="Request", Data=[], SafeData=[RequestId=newActivityId, Uri=url]], newActivityId),`
    * [PowerBIDatamarts.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L187) — `loggedActivityId = Diagnostics.Trace(TraceLevel.Information, [Name="Request", Data=[], SafeData=[RequestId=newActivityId, Uri=url]], newActivityId),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L125) — `Documentation.FieldCaption = Extension.LoadString("ServerCaption"),`
    * [PowerBIDatamarts.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L96) — `shared PowerBI.Datamarts = Value.ReplaceType(DatamartsImpl,Datamarts.Type);`
    * [PowerBIDatamarts.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L129) — `DatamartsType = type function ( optional server as serverType )`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L218) — `nav = Table.ToNavigationTable(withIsLeaf, {"workspaceObjectId"}, "workspaceName", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [PowerBIDatamarts.pq line 307](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L307) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L125) — `Documentation.FieldCaption = Extension.LoadString("ServerCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L156) — `jsonResponse = Json.Document(response) meta Value.Metadata(response),`
    * [PowerBIDatamarts.pq line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L108) — `Headers = [`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 177](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L177) — `error Error.Record(`
    * [PowerBIDatamarts.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L155) — `response = Web.Contents(baseUrl, nonEmptyOptions & [ManualStatusHandling = ApiErrorStatusCodes]),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [PowerBIDatamarts.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L155) — `response = Web.Contents(baseUrl, nonEmptyOptions & [ManualStatusHandling = ApiErrorStatusCodes]),`
