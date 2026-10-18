---
type: Power Query Connector
title: Exasol
description: Connect to Exasol
tags: [credentials, diagnostics, implicit, navigation, odbc, packaging, schema, usernamepassword, windows]
publisher: Exasol
version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq
  title: Exasol.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Exasol/1.1.1/Exasol_1.1.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Exasol | 1.1.1 | Implicit, UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Diagnostics.pqm)
* [Exasol.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Exasol.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L85)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Exasol.pq line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L210)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Exasol.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L113)
* [Resources and modular source loading](../patterns/packaging.md): [Exasol.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L16)
* [Schema and type enforcement](../patterns/schema.md): [Exasol.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L32)
