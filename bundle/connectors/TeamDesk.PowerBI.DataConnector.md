---
type: Power Query Connector
title: TeamDesk.PowerBI.DataConnector
description: Power BI connector source for TeamDesk.PowerBI.DataConnector.
tags: [credentials, errors, key, navigation, packaging, pagination, parameter-metadata, response-metadata, usernamepassword, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m
  title: TeamDesk.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamDesk/1.0.2/TeamDesk_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T17:23:17Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | Key, UsernamePassword |

# Source files

* [TeamDesk.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 266](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L266) — `,	credentials = Extension.CurrentCredential()`
    * [TeamDesk.m line 267](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L267) — `,	headers = if credentials[AuthenticationKind] = "Key" then [ Authorization = "Bearer " & credentials[Key] ] else null`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L42) — `Documentation.FieldCaption = Extension.LoadString("ParamUrlCaption"),`
    * [TeamDesk.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L40) — `shared TeamDesk.Database = Value.ReplaceType(DatabaseImpl, type function (`
    * [TeamDesk.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L40) — `shared TeamDesk.Database = Value.ReplaceType(DatabaseImpl, type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L157) — `Table.ToNavigationTable(objects, { "Key" }, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"))(tentry[recordName]),`
    * [TeamDesk.m line 359](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L359) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L215) — `List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L11) — `Label = Extension.LoadString("DataSourceName"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 272](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L272) — `if Value.Metadata(webResponse)[Response.Status] >= 400 then // HTTP Error`
    * [TeamDesk.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L268) — `,	webResponse = Web.Contents(apiURL, [ Query = query, Headers = headers, ManualStatusHandling = {400,403,404,405,409,500,503} ])`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [TeamDesk.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L40) — `shared TeamDesk.Database = Value.ReplaceType(DatabaseImpl, type function (`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L256) — `Error.Record(resourceId, Text.Format(Extension.LoadString(resourceId), args))`
    * [TeamDesk.m line 169](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L169) — `,	tableChecked = if table = null then error GetError("ErrNoTableName") else table`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [TeamDesk.m line 268](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L268) — `,	webResponse = Web.Contents(apiURL, [ Query = query, Headers = headers, ManualStatusHandling = {400,403,404,405,409,500,503} ])`
