---
type: Power Query Connector
title: Microsoft Teams Personal Analytics
description: Connect to Microsoft Teams Personal Analytics
tags: [aad, navigation, packaging, response-metadata, schema]
publisher: Microsoft
version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq
  title: TeamsAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamsAnalytics/1.1.0/TeamsAnalytics_1.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.1.0 | Aad |

# Source files

* [TeamsAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [TeamsAnalytics.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L44)
* [Resources and modular source loading](../patterns/packaging.md): [TeamsAnalytics.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L40)
* [Response and pagination metadata](../patterns/response-metadata.md): [TeamsAnalytics.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L112)
* [Schema and type enforcement](../patterns/schema.md): [TeamsAnalytics.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L35)
