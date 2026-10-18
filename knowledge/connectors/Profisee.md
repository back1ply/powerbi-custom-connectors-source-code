---
type: Power Query Connector
title: Profisee
description: Connect to Profisee, and get the data from Profisee data source
tags: [errors, navigation, oauth, oauth2, packaging, pagination, response-metadata, schema]
publisher: Profisee
version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m
  title: Profisee.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/SchemaTransformTable.pqm
  title: SchemaTransformTable.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Profisee/2.0.0/Profisee_2.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Profisee | 2.0.0 | OAuth |

# Source files

* [Profisee.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m)
* [SchemaTransformTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/SchemaTransformTable.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.ToNavigationTable.pqm)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Profisee.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L64)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Profisee.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L182)
* [Page generation and cursor traversal](../patterns/pagination.md): [Profisee.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L130)
* [Resources and modular source loading](../patterns/packaging.md): [Profisee.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L8)
* [Response and pagination metadata](../patterns/response-metadata.md): [Profisee.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L49)
* [Schema and type enforcement](../patterns/schema.md): [Profisee.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L5), [SchemaTransformTable.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/SchemaTransformTable.pqm#L50), [Table.GenerateByPage.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.GenerateByPage.pqm#L17), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Profisee.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L39)
