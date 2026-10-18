---
type: Power Query Connector
title: Tenforce (Smart)List
description: Connect to Tenforce
tags: [buffering, diagnostics, errors, navigation, packaging, response-metadata, schema, usernamepassword, windows]
publisher: TenForce
version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m
  title: Tenforce.m
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/TypeMappingTable.pqm
  title: TypeMappingTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Tenforce/1.0.4/Tenforce_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| TenForce | 1.0.4 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ToNavigationTable.pqm)
* [Tenforce.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m)
* [TypeMappingTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/TypeMappingTable.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Tenforce.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L80)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Tenforce.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L14)
* [Resources and modular source loading](../patterns/packaging.md): [Tenforce.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L25)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm#L12)
* [Schema and type enforcement](../patterns/schema.md): [Table.ChangeType.pqm line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm#L60), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ToNavigationTable.pqm#L20), [Tenforce.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L9)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm#L27)
