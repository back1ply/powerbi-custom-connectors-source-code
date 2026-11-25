---
type: Power Query Connector
title: Topcon Aptix Insights
description: Get Help
tags: [credentials, key, odata, packaging, parameter-metadata]
x-pqkb-publisher: AptixInsights
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq
  title: AptixInsights.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AptixInsights/1.0.2/AptixInsights_1.0.2.pqx
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
| AptixInsights | 1.0.2 | Key |

# Source files

* [AptixInsights.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AptixInsights.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L39) — `credential = Extension.CurrentCredential(),`
    * [AptixInsights.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L40) — `token = credential[Key],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AptixInsights.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L20) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
    * [AptixInsights.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L9) — `shared AptixInsights.Feed = Value.ReplaceType(AptixInsightsImpl, AptixInsightsType);`
    * [AptixInsights.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L17) — `AptixInsightsType = type function (`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [AptixInsights.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L50) — `source = OData.Feed(url, headers, serviceOptions)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AptixInsights.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AptixInsights/AptixInsights.pq#L20) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
