---
type: Power Query Connector
title: SumTotal
description: Connect to SumTotal
tags: [errors, oauth, oauth2, odata, packaging, parameter-metadata, web-requests]
x-pqkb-publisher: SumTotal
x-pqkb-version: 3.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq
  title: SumTotal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SumTotal/3.0.0/SumTotal_3.0.0.pqx
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
| SumTotal | 3.0.0 | OAuth |

# Source files

* [SumTotal.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L25) — `Documentation.FieldCaption = "Customer Environment Url",`
    * [SumTotal.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L21) — `shared SumTotal.ODataFeed = Value.ReplaceType(SumTotalNavTable, SumTotalType);`
    * [SumTotal.pq line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L23) — `SumTotalType = type function (`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L182) — `OAuth = [`
    * [SumTotal.pq line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L183) — `StartLogin = StartLogin,`
    * [SumTotal.pq line 184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L184) — `FinishLogin = FinishLogin,`
    * [SumTotal.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L230) — `grant_type = grantType,`
    * [SumTotal.pq line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L126) — `response = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L117) — `odataEntities = OData.Feed(odataUrl, null, [Implementation = "2.0", Query = combinedFilters])`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L259) — `Icon16 = { Extension.Contents("SumTotal.PowerBIConnector16.png"), Extension.Contents("SumTotal.PowerBIConnector20.png"), Extension.Contents("SumTotal.PowerBIConnector24.png"), Extension.Contents("SumTotal.PowerBIConnector32.png") },`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L218) — `error Error.Record(Parts[error], Parts[error_description], Parts)`
    * [SumTotal.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L218) — `error Error.Record(Parts[error], Parts[error_description], Parts)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [SumTotal.pq line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SumTotal/SumTotal.pq#L126) — `response = Web.Contents(url, [ Headers = DefaultRequestHeaders ]),`
