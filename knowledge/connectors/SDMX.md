---
type: Power Query Connector
title: SIS-CC SDMX
description: Get data from an SDMX RESTful web service that supports the CSV format.
tags: [buffering, implicit, navigation, packaging, schema]
publisher: SISCC
version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m
  title: SDMX.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SDMX/1.0.5/SDMX_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SISCC | 1.0.5 | Implicit |

# Source files

* [SDMX.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [SDMX.m line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L55)
* [Navigation tables and connection checks](../patterns/navigation.md): [SDMX.m line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L69)
* [Resources and modular source loading](../patterns/packaging.md): [SDMX.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L17)
* [Schema and type enforcement](../patterns/schema.md): [SDMX.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L5)
