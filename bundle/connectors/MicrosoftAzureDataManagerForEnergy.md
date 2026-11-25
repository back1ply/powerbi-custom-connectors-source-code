---
type: Power Query Connector
title: MicrosoftAzureDataManagerForEnergy
description: Power BI connector source for MicrosoftAzureDataManagerForEnergy.
tags: [aad, navigation, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq
  title: MicrosoftAzureDataManagerForEnergy.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrosoftAzureDataManagerForEnergy/1.0.1/MicrosoftAzureDataManagerForEnergy_1.0.1.pqx
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
| Microsoft | 1.0.1 | Aad |

# Source files

* [MicrosoftAzureDataManagerForEnergy.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L16) — `Documentation.FieldCaption = Extension.LoadString("serviceNameFieldCaption"),`
    * [MicrosoftAzureDataManagerForEnergy.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L12) — `shared MicrosoftAzureDataManagerForEnergy.Search = Value.ReplaceType(MicrosoftAzureDataManagerForEnergyImpl, MicrosoftAzureDataManagerForEnergyType);`
    * [MicrosoftAzureDataManagerForEnergy.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L14) — `MicrosoftAzureDataManagerForEnergyType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L74) — `navigationTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [MicrosoftAzureDataManagerForEnergy.pq line 312](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L312) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L108) — `Table.GenerateByPage(`
    * [MicrosoftAzureDataManagerForEnergy.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L98) — `page = GetSearchResultPage(endpoint, dataPartition, kind, query, runningCount, "", limit)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L16) — `Documentation.FieldCaption = Extension.LoadString("serviceNameFieldCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L100) — `Value.Metadata(page)[totalNumberOfRecords];`
    * [MicrosoftAzureDataManagerForEnergy.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L132) — `Headers = [#"Content-Type"="application/json", #"data-partition-id"=dataPartition],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L12) — `shared MicrosoftAzureDataManagerForEnergy.Search = Value.ReplaceType(MicrosoftAzureDataManagerForEnergyImpl, MicrosoftAzureDataManagerForEnergyType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [MicrosoftAzureDataManagerForEnergy.pq line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L131) — `results = Json.Document(Web.Contents(endpoint,[`
