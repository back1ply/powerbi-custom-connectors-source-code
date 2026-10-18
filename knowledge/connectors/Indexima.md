---
type: Power Query Connector
title: Indexima
description: Connect to Indexima Data Hub
tags: [credentials, diagnostics, errors, native-query, navigation, odbc, packaging, schema, usernamepassword]
publisher: Indexima
version: 1.7.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m
  title: Indexima.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Indexima/1.7.6/Indexima_1.7.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Indexima | 1.7.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Diagnostics.pqm)
* [Indexima.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Indexima.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L105)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Diagnostics.pqm#L2)
* [Native queries](../patterns/native-query.md): [Indexima.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L162)
* [Navigation tables and connection checks](../patterns/navigation.md): [Indexima.m line 280](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L280)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Indexima.m line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L249)
* [Resources and modular source loading](../patterns/packaging.md): [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L39)
* [Schema and type enforcement](../patterns/schema.md): [Indexima.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L34)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Indexima.m line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L123)
