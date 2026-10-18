---
type: Power Query Connector
title: BuildingConnected & TradeTapp
description: Connect to BuildingConnected & TradeTapp
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, pagination, pkce, response-metadata, retry-polling, schema, table-view]
publisher: Autodesk
version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq
  title: BuildingConnected.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Schemas.pqm
  title: Schemas.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BuildingConnected/1.0.6/BuildingConnected_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Autodesk | 1.0.6 | OAuth |

# Source files

* [BuildingConnected.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Diagnostics.pqm)
* [Schemas.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Schemas.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ToNavigationTable.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [BuildingConnected.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L145), [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Diagnostics.pqm#L3)
* [Navigation tables and connection checks](../patterns/navigation.md): [BuildingConnected.pq line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L99)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [BuildingConnected.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L18)
* [Page generation and cursor traversal](../patterns/pagination.md): [BuildingConnected.pq line 465](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L465)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [BuildingConnected.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L39)
* [Resources and modular source loading](../patterns/packaging.md): [BuildingConnected.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L6)
* [Response and pagination metadata](../patterns/response-metadata.md): [BuildingConnected.pq line 365](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L365), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm#L12)
* [Retries, delays, and polling](../patterns/retry-polling.md): [BuildingConnected.pq line 527](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L527)
* [Schema and type enforcement](../patterns/schema.md): [BuildingConnected.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L176), [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.GenerateByPage.pqm#L23), [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ToNavigationTable.pqm#L19)
* [Structured errors and HTTP status handling](../patterns/errors.md): [BuildingConnected.pq line 82](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L82), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm#L27)
* [Table.View handlers](../patterns/table-view.md): [BuildingConnected.pq line 235](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L235)
