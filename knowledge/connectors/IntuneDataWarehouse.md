---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad, navigation, odata, packaging, schema]
publisher: Microsoft
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m
  title: Intune.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneDataWarehouse/1.0.2/IntuneDataWarehouse_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | Aad |

# Source files

* [Intune.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Intune.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L42)
* [OData feeds](../patterns/odata.md): [Intune.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L32)
* [Resources and modular source loading](../patterns/packaging.md): [Intune.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L60)
* [Schema and type enforcement](../patterns/schema.md): [Intune.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L14)
