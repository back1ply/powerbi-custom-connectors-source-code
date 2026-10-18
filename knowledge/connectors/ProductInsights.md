---
type: Power Query Connector
title: ProductInsightsConnector
description: Connect to ProductInsightsConnector
tags: [aad, errors, navigation, oauth2, packaging, schema]
publisher: Microsoft
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m
  title: ProductInsightsConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ProductInsights/1.0.2/ProductInsights_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | Aad |

# Source files

* [ProductInsightsConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [ProductInsightsConnector.m line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L166)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [ProductInsightsConnector.m line 506](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L506)
* [Resources and modular source loading](../patterns/packaging.md): [ProductInsightsConnector.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L4)
* [Schema and type enforcement](../patterns/schema.md): [ProductInsightsConnector.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L153)
* [Structured errors and HTTP status handling](../patterns/errors.md): [ProductInsightsConnector.m line 530](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L530)
