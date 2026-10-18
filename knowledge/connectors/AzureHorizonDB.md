---
type: Power Query Connector
title: Azure HorizonDB Database
description: Import or connect to an Azure HorizonDB Database
tags: [aad, credentials, errors, navigation, packaging, schema, usernamepassword]
publisher: Microsoft
version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq
  title: AzureHorizonDB.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureHorizonDB/1.0.3/AzureHorizonDB_1.0.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.3 | Aad, UsernamePassword |

# Source files

* [AzureHorizonDB.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AzureHorizonDB.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L33)
* [Navigation tables and connection checks](../patterns/navigation.md): [AzureHorizonDB.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L150)
* [Resources and modular source loading](../patterns/packaging.md): [AzureHorizonDB.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L47)
* [Schema and type enforcement](../patterns/schema.md): [AzureHorizonDB.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L22)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AzureHorizonDB.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L84)
