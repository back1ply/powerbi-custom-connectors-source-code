---
type: Power Query Connector
title: Azure Database for PostgreSQL
description: Connect to Azure Database for PostgreSQL
tags: [aad, credentials, errors, navigation, packaging, schema, usernamepassword]
publisher: Microsoft
version: 1.3.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq
  title: AzurePostgreSQL.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzurePostgreSQL/1.3.2/AzurePostgreSQL_1.3.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.3.2 | Aad, UsernamePassword |

# Source files

* [AzurePostgreSQL.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AzurePostgreSQL.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L33)
* [Navigation tables and connection checks](../patterns/navigation.md): [AzurePostgreSQL.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L150)
* [Resources and modular source loading](../patterns/packaging.md): [AzurePostgreSQL.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L47)
* [Schema and type enforcement](../patterns/schema.md): [AzurePostgreSQL.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L22)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AzurePostgreSQL.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L84)
