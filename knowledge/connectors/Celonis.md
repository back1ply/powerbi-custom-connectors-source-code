---
type: Power Query Connector
title: Celonis EMS
description: Connect to Celonis EMS
tags: [buffering, credentials, errors, key, navigation, packaging, response-metadata, schema, table-view]
publisher: Celonis
version: 2.2.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m
  title: Celonis.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Celonis/2.2.0/Celonis_2.2.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Celonis | 2.2.0 | Key |

# Source files

* [Celonis.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Table.ToNavigationTable.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Celonis.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L64)
* [Credential access](../patterns/credentials.md): [Celonis.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L5)
* [Navigation tables and connection checks](../patterns/navigation.md): [Celonis.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L25)
* [Resources and modular source loading](../patterns/packaging.md): [Celonis.m line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L29)
* [Response and pagination metadata](../patterns/response-metadata.md): [Celonis.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L88)
* [Schema and type enforcement](../patterns/schema.md): [Celonis.m line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L309), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Celonis.m line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L87)
* [Table.View handlers](../patterns/table-view.md): [Celonis.m line 273](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L273)
