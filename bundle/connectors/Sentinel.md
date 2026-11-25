---
type: Power Query Connector
title: Sentinel
description: Power BI connector source for Sentinel.
tags: [aad, packaging, parameter-metadata]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq
  title: Sentinel.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Sentinel/1.0.2/Sentinel_1.0.2.pqx
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
| Microsoft | 1.0.2 | Aad |

# Source files

* [Sentinel.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [Sentinel.pq line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L105) — `(dataSource) => Extension.CurrentCredential(),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L11) — `Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.Cluster.Name"),`
    * [Sentinel.pq line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L119) — `shared MicrosoftSentinel.Contents =  Value.ReplaceType(MicrosoftSentinelImpl, _MicrosoftSentinel.ContentsDocs);`
    * [Sentinel.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L60) — `t = type function (`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L11) — `Documentation.FieldCaption = Extension.LoadString("MicrosoftSentinel.Contents.Cluster.Name"),`
