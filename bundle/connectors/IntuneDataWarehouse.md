---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad, odata, packaging, parameter-metadata]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m
  title: Intune.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneDataWarehouse/1.0.2/IntuneDataWarehouse_1.0.2.pqx
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
| Microsoft | 1.0.2 | Aad |

# Source files

* [Intune.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Intune.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L19) — `Documentation.FieldCaption = "Number of days of history to retrieve",`
    * [Intune.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L14) — `shared Intune.Contents = Value.ReplaceType(IntuneDwImpl, IntuneDwType) ;`
    * [Intune.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L17) — `IntuneDwType = type function (`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [Intune.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L32) — `feed = OData.Feed(Intune.DateWarehouseUri, null, [Query = queryString])`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Intune.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L60) — `ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },`
