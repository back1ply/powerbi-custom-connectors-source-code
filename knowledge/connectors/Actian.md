---
type: Power Query Connector
title: Actian
description: Connect to Actian X Vector, Avalanche, or Ingres
tags: [credentials, diagnostics, errors, navigation, odbc, packaging, schema, usernamepassword, windows]
publisher: Actian
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m
  title: Actian.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Actian/1.0.1/Actian_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Actian | 1.0.1 | UsernamePassword, Windows |

# Source files

* [Actian.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Actian.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L117)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Actian.m line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L252)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Actian.m line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L218)
* [Resources and modular source loading](../patterns/packaging.md): [Actian.m line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L212)
* [Schema and type enforcement](../patterns/schema.md): [Actian.m line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L166)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Actian.m line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L127)
