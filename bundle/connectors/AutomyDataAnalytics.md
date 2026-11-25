---
type: Power Query Connector
title: Automy Analytics
description: Obtain information on a process through a direct connection with AUTOMY
tags: [credentials, key, navigation, packaging, response-metadata, schema, web-requests]
x-pqkb-publisher: AceRoyalty
x-pqkb-version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq
  title: AutomyDataAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutomyDataAnalytics/1.2.1/AutomyDataAnalytics_1.2.1.pqx
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
| AceRoyalty | 1.2.1 | Key |

# Source files

* [AutomyDataAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L10) — `credential = Extension.CurrentCredential(),`
    * [AutomyDataAnalytics.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L11) — `token = credential[Key],`
* [Date-range request filters](../patterns/date-filters.md)
  * **Uncertain match (older review)**
    * [AutomyDataAnalytics.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L93) — `FormDataFunction.Contents = (FormId as text, optional RangeStart as nullable datetime, optional RangeEnd as nullable datetime) =>`
    * [AutomyDataAnalytics.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L93) — `FormDataFunction.Contents = (FormId as text, optional RangeStart as nullable datetime, optional RangeEnd as nullable datetime) =>`
    * [AutomyDataAnalytics.pq line 106](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L106) — `startText = if RangeStart <> null then DateTime.ToText(RangeStart, "yyyy-MM-dd'T'HH:mm:ss'Z'", "en-US") else null,`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L19) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [AutomyDataAnalytics.pq line 452](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L452) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L15) — `{Extension.LoadString("generic"),   "generic",   CreateGenericTable(), "Database",    "Database",    false},`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L86) — `responseCode = Value.Metadata(content)[Response.Status],`
    * [AutomyDataAnalytics.pq line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L79) — `[Headers=`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 458](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L458) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AutomyDataAnalytics.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L85) — `content = Web.Contents(BaseUrl&"?reportType="&ReportType&"&dataType="&DataType, header),`
