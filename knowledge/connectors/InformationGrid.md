---
type: Power Query Connector
title: InformationGrid
description: Access BI services from InformationGrid
tags: [credentials, diagnostics, errors, key, navigation, packaging, response-metadata, schema]
publisher: Luminis
version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq
  title: InformationGrid.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/InformationGrid/1.0.5/InformationGrid_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Luminis | 1.0.5 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Diagnostics.pqm)
* [InformationGrid.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ToNavigationTable.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [InformationGrid.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L35)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [InformationGrid.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L65)
* [Resources and modular source loading](../patterns/packaging.md): [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L11)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm#L12)
* [Schema and type enforcement](../patterns/schema.md): [InformationGrid.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L7), [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.GenerateByPage.pqm#L20), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm#L27)
