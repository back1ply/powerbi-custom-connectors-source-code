---
type: Power Query Connector
title: QubolePresto
description: Connect to QubolePresto
tags: [credentials, diagnostics, errors, implicit, navigation, odbc, packaging, schema]
publisher: Qubole
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m
  title: QubolePresto.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QubolePresto/1.0.1/QubolePresto_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Qubole | 1.0.1 | Implicit |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/OdbcConstants.pqm)
* [QubolePresto.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [QubolePresto.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L92)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [QubolePresto.m line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L210)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [QubolePresto.m line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L190)
* [Resources and modular source loading](../patterns/packaging.md): [QubolePresto.m line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L221)
* [Schema and type enforcement](../patterns/schema.md): [QubolePresto.m line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L145)
* [Structured errors and HTTP status handling](../patterns/errors.md): [QubolePresto.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L105)
