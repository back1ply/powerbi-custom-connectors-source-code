---
type: Power Query Connector
title: SolarwindsServiceDesk
description: Power BI connector source for SolarwindsServiceDesk.
tags: [credentials, date-filters, diagnostics, key, navigation, packaging, pagination, response-metadata, schema, web-requests]
x-pqkb-publisher: SolarwindsServiceDesk
x-pqkb-version: 1.1.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq
  title: SolarWindsServiceDesk.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SolarwindsServiceDesk/1.1.3/SolarwindsServiceDesk_1.1.3.pqx
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
| SolarwindsServiceDesk | 1.1.3 | Key |

# Source files

* [SolarWindsServiceDesk.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L139) — `key =  Extension.CurrentCredential()[Key],`
    * [SolarWindsServiceDesk.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L139) — `key =  Extension.CurrentCredential()[Key],`
* [Date-range request filters](../patterns/date-filters.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L14) — `SolarWindsServiceDesk.BasedOnUpdatedAt = (optional RangeStart as datetime, optional RangeEnd as datetime) =>`
    * [SolarWindsServiceDesk.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L14) — `SolarWindsServiceDesk.BasedOnUpdatedAt = (optional RangeStart as datetime, optional RangeEnd as datetime) =>`
    * [SolarWindsServiceDesk.pq line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L61) — `startDate = if RangeStart = null then DateTime.ToText(Date.AddMonths(today, -1), Extension.LoadString("DateFormat")) else DateTime.ToText(RangeStart, Extension.LoadString("DateFormat")),`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L63) — `tracedStartDate = Diagnostics.Trace(TraceLevel.Information, GetTraceData(version, dataType, startDate, endDate), () =>  startDate, true),`
    * [SolarWindsServiceDesk.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L63) — `tracedStartDate = Diagnostics.Trace(TraceLevel.Information, GetTraceData(version, dataType, startDate, endDate), () =>  startDate, true),`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L28) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [SolarWindsServiceDesk.pq line 274](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L274) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L93) — `listOfPages = List.Generate(`
    * [SolarWindsServiceDesk.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L122) — `page = if (nextPageNumber <> null) then GetPage(version, nextPageNumber, startDate, endDate, dataType, customFieldsNames) else null`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L3) — `AllColumns = Json.Document(Extension.Contents("Columns.json"));`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L119) — `nextPageNumber = if (previousPageNumber = null) then 1 else Value.Metadata(previousPageNumber)[NextPageNumber]?,`
    * [SolarWindsServiceDesk.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L147) — `response = Web.Contents(url, [ Headers = headers, RelativePath = dataType & ".json", Query = GetQuery(currentPage, startDate, endDate) ]),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 107](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L107) — `Value.ReplaceType(`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [SolarWindsServiceDesk.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L147) — `response = Web.Contents(url, [ Headers = headers, RelativePath = dataType & ".json", Query = GetQuery(currentPage, startDate, endDate) ]),`
    * [SolarWindsServiceDesk.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L147) — `response = Web.Contents(url, [ Headers = headers, RelativePath = dataType & ".json", Query = GetQuery(currentPage, startDate, endDate) ]),`
