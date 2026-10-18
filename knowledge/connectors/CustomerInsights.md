---
type: Power Query Connector
title: Dynamics 365 Customer Insights
description: Connect to Dynamics 365 Customer Insights
tags: [aad, errors, navigation, packaging, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 1.0.14
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m
  title: CustomerInsights.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CustomerInsights/1.0.14/CustomerInsights_1.0.14.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.14 | Aad |

# Source files

* [CustomerInsights.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [CustomerInsights.m line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L46)
* [Resources and modular source loading](../patterns/packaging.md): [CustomerInsights.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L58)
* [Response and pagination metadata](../patterns/response-metadata.md): [CustomerInsights.m line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L187)
* [Retries, delays, and polling](../patterns/retry-polling.md): [CustomerInsights.m line 359](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L359)
* [Schema and type enforcement](../patterns/schema.md): [CustomerInsights.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L42)
* [Structured errors and HTTP status handling](../patterns/errors.md): [CustomerInsights.m line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L186)
* [Table.View handlers](../patterns/table-view.md): [CustomerInsights.m line 237](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L237)
