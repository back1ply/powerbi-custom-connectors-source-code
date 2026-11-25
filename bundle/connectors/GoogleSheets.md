---
type: Power Query Connector
title: Google Sheets
description: Power BI connector source for Google Sheets.
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq
  title: GoogleSheets.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/GoogleSheets/1.0.6/GoogleSheets_1.0.6.pqx
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
| Microsoft | 1.0.6 | OAuth |

# Source files

* [GoogleSheets.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L95) — `Documentation.FieldCaption = Extension.LoadString("url_Caption"),`
    * [GoogleSheets.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L80) — `shared GoogleSheets.Contents = Value.ReplaceType(GoogleSheetsImpl,GoogleSheetsType);`
    * [GoogleSheets.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L93) — `GoogleSheetsType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L124) — `nav = Table.ToNavigationTable(withIsLeaf, {"name","ItemKind"}, "name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [GoogleSheets.pq line 316](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L316) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L70) — `OAuth=[`
    * [GoogleSheets.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L9) — `StartLogin = (resourceUrl, state, display) =>`
    * [GoogleSheets.pq line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L28) — `FinishLogin = (context, callbackUri, state) =>`
    * [GoogleSheets.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L38) — `grant_type = "authorization_code",`
    * [GoogleSheets.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L34) — `Web.Contents("https://oauth2.googleapis.com/token", [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L74) — `Label = Extension.LoadString("AuthenticationLabel")]`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L256) — `jsonResponse = Json.Document(response) meta Value.Metadata(response),`
    * [GoogleSheets.pq line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L41) — `Headers = [`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L80) — `shared GoogleSheets.Contents = Value.ReplaceType(GoogleSheetsImpl,GoogleSheetsType);`
    * [GoogleSheets.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L116) — `selectrangesColumns = if ranges = null then #table(type table [name=text, SheetorRangeId=text, Data=table], {}) else Table.SelectColumns(ranges,{"name","SheetorRangeId","Data"}),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L32) — `error Error.Record("DataSource.Error", Parts[error])`
    * [GoogleSheets.pq line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L31) — `Response = if (Parts[error]? <> null) then`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [GoogleSheets.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L34) — `Web.Contents("https://oauth2.googleapis.com/token", [`
