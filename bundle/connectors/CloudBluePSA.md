---
type: Power Query Connector
title: CloudBluePSA
description: Power BI connector source for CloudBluePSA.
tags: [credentials, key, packaging, parameter-metadata]
x-pqkb-publisher: CloudBluePSA
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m
  title: CloudBluePSAConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CloudBluePSA/1.0.1/CloudBluePSA_1.0.1.pqx
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
| CloudBluePSA | 1.0.1 | Key |

# Source files

* [CloudBluePSAConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [CloudBluePSAConnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L33) — `apiKey = Extension.CurrentCredential()[Key],`
    * [CloudBluePSAConnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L33) — `apiKey = Extension.CurrentCredential()[Key],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CloudBluePSAConnector.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9) — `Documentation.FieldCaption = Extension.LoadString("URLTextboxLabel"),`
    * [CloudBluePSAConnector.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L5) — `shared CloudBluePSA.Feed = Value.ReplaceType(CloudBluePSAImpl, CloudBluePSAType);`
    * [CloudBluePSAConnector.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L7) — `CloudBluePSAType = type function(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CloudBluePSAConnector.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9) — `Documentation.FieldCaption = Extension.LoadString("URLTextboxLabel"),`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [CloudBluePSAConnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L45) — `#"Invoked Custom Function" = Table.AddColumn(#"Changed Type", "Data", each Function.InvokeAfter(() => getPage(modifiedURL, [Column1]),#duration(0,0,0,3)))`
    * [CloudBluePSAConnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L45) — `#"Invoked Custom Function" = Table.AddColumn(#"Changed Type", "Data", each Function.InvokeAfter(() => getPage(modifiedURL, [Column1]),#duration(0,0,0,3)))`
    * [CloudBluePSAConnector.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L41) — `pageCount = if remainder > 0 then totalCount + 1 else totalCount,`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [CloudBluePSAConnector.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L5) — `shared CloudBluePSA.Feed = Value.ReplaceType(CloudBluePSAImpl, CloudBluePSAType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [CloudBluePSAConnector.m line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L35) — `source = Json.Document(Web.Contents(modifiedURL, [ManualCredentials = true])),`
