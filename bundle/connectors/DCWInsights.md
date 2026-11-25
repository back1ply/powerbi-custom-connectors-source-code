---
type: Power Query Connector
title: Digital Construction Works Insights
description: Get Help
tags: [credentials, key, odata, parameter-metadata]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m
  title: DCWInsights.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DCWInsights/1.0.3/DCWInsights_1.0.3.pqx
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
| Microsoft | 1.0.3 | Key |

# Source files

* [DCWInsights.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [DCWInsights.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L26) — `credential = Extension.CurrentCredential(),`
    * [DCWInsights.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L27) — `token = credential[Key],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DCWInsights.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L14) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
    * [DCWInsights.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L9) — `shared DCWInsights.Feed = Value.ReplaceType(DCWInsightsImpl, DCWInsightsType);`
    * [DCWInsights.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L13) — `DCWInsightsType = type function(url as (type text meta [`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [DCWInsights.m line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L31) — `source = OData.Feed(url, headers, serviceOptions)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Uncertain match (older review)**
    * [DCWInsights.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L14) — `Documentation.FieldCaption = Extension.LoadString("UrlFieldCaption"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [DCWInsights.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L9) — `shared DCWInsights.Feed = Value.ReplaceType(DCWInsightsImpl, DCWInsightsType);`
