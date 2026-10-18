---
type: Power Query Connector
title: KylinDirectQuery
description: Connect to KylinDirectQuery
tags: [diagnostics, navigation, odbc, packaging, schema, usernamepassword]
publisher: Kyligence
version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m
  title: Kyligence.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kyligence/1.0.5/Kyligence_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Kyligence | 1.0.5 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Diagnostics.pqm)
* [Kyligence.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Kyligence.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L98)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Kyligence.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L44)
* [Resources and modular source loading](../patterns/packaging.md): [Kyligence.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L126)
* [Schema and type enforcement](../patterns/schema.md): [Kyligence.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L9)
