---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad, errors, odata, packaging, parameter-metadata]
x-pqkb-publisher: Microsoft
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq
  title: IntuneV2.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneV2/2.0.0/IntuneV2_2.0.0.pqx
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
| Microsoft | 2.0.0 | Aad |

# Source files

* [IntuneV2.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L14) — `Documentation.FieldCaption = Extension.LoadString("asuUriCaption"),`
    * [IntuneV2.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L9) — `shared IntuneV2.Contents = Value.ReplaceType(IntuneV2DwImpl, IntuneV2DwType) ;`
    * [IntuneV2.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L12) — `IntuneV2DwType = type function (`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [IntuneV2.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L56) — `feed = OData.Feed(dataWarehouseAsuUri, null, [Query = queryString, Implementation="2.0", ODataVersion = 4])`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L14) — `Documentation.FieldCaption = Extension.LoadString("asuUriCaption"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [IntuneV2.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L9) — `shared IntuneV2.Contents = Value.ReplaceType(IntuneV2DwImpl, IntuneV2DwType) ;`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [IntuneV2.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L59) — `else error Error.Record("Expression.Error", Extension.LoadString("invalidDataWarehouseUriError"), [ Uri = dataWarehouseAsuUri ]);`
    * [IntuneV2.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L59) — `else error Error.Record("Expression.Error", Extension.LoadString("invalidDataWarehouseUriError"), [ Uri = dataWarehouseAsuUri ]);`
