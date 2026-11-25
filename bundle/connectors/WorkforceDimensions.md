---
type: Power Query Connector
title: Workforce Dimensions
description: Connect to Workforce Dimensions
tags: [packaging, parameter-metadata, usernamepassword, web-requests]
x-pqkb-publisher: Kronos
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m
  title: WorkforceDimensions.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WorkforceDimensions/1.0.3/WorkforceDimensions_1.0.3.pqx
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
| Kronos | 1.0.3 | UsernamePassword |

# Source files

* [WorkforceDimensions.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [WorkforceDimensions.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L96) — `credentials = Extension.CurrentCredential(),`
    * [WorkforceDimensions.m line 322](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L322) — `Headers=[#"Content-type" = "application/json",#"Accept" = "application/json", #"Authorization" = authTokenResponse[access_token], #"appkey" = connectionDetails[appkey]]`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [WorkforceDimensions.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L47) — `Documentation.FieldCaption = Extension.LoadString("ConfigurationServerUrlCaption"),`
    * [WorkforceDimensions.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L42) — `shared WorkforceDimensions.Contents = Value.ReplaceType(WorkforceDimensionsImpl, WorkforceDimensionsType);`
    * [WorkforceDimensions.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L45) — `WorkforceDimensionsType = type function (`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [WorkforceDimensions.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L47) — `Documentation.FieldCaption = Extension.LoadString("ConfigurationServerUrlCaption"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [WorkforceDimensions.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L42) — `shared WorkforceDimensions.Contents = Value.ReplaceType(WorkforceDimensionsImpl, WorkforceDimensionsType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [WorkforceDimensions.m line 319](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L319) — `response = Web.Contents(url,`
