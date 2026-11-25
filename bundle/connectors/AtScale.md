---
type: Power Query Connector
title: AtScale cubes
description: Import/DirectQuery cube data from AtScale.
tags: [credentials, errors, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq
  title: AtScale.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AtScale/3.0.4/AtScale_3.0.4.pqx
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
| Microsoft | 3.0.4 | UsernamePassword |

# Source files

* [AtScale.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AtScale.pq line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L24) — `(datasource) => Extension.CurrentCredential(),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AtScale.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L34) — `Documentation.FieldCaption = Extension.LoadString("ServerParameterCaption"),`
    * [AtScale.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L8) — `shared AtScale.Cubes = Value.ReplaceType(AtScaleImpl, AtScaleType);`
    * [AtScale.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L32) — `AtScaleType = type function (`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AtScale.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L15) — `Label = Extension.LoadString("AuthenticationLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AtScale.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L8) — `shared AtScale.Cubes = Value.ReplaceType(AtScaleImpl, AtScaleType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AtScale.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L103) — `error Error.Record("Expression.Error", InvalidKeyText)`
    * [AtScale.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AtScale/AtScale.pq#L103) — `error Error.Record("Expression.Error", InvalidKeyText)`
