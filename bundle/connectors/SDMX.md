---
type: Power Query Connector
title: SIS-CC SDMX
description: Get data from an SDMX RESTful web service that supports the CSV format.
tags: [buffering, implicit, packaging, parameter-metadata, web-requests]
x-pqkb-publisher: SISCC
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m
  title: SDMX.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SDMX/1.0.5/SDMX_1.0.5.pqx
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
| SISCC | 1.0.5 | Implicit |

# Source files

* [SDMX.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [SDMX.m line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L55) — `NewHeaderNames = List.Buffer( List.Transform( OriginalHeaders, each if try Number.From(Text.AfterDelimiter(_, ":")) = null otherwise false  then _ else Text.TrimStart( Text.AfterDelimiter(_, ":" )))),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [SDMX.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L17) — `Documentation.FieldCaption = Extension.LoadString("FunctionParameterURL"),`
    * [SDMX.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L5) — `shared SDMX.Contents =  Value.ReplaceType( GetData, GetDataType);`
    * [SDMX.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L15) — `GetDataType = type function (`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SDMX.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L17) — `Documentation.FieldCaption = Extension.LoadString("FunctionParameterURL"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [SDMX.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L5) — `shared SDMX.Contents =  Value.ReplaceType( GetData, GetDataType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [SDMX.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L41) — `Custom1 = Web.Contents(url, [Headers=myHeaders]),`
