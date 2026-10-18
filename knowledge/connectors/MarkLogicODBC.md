---
type: Power Query Connector
title: MarkLogic
description: MarkLogic
tags: [credentials, diagnostics, errors, navigation, odbc, packaging, schema, usernamepassword]
publisher: MarkLogic
version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m
  title: MarkLogicODBC.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MarkLogicODBC/1.0.6/MarkLogicODBC_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| MarkLogic | 1.0.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/Diagnostics.pqm)
* [MarkLogicODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [MarkLogicODBC.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L132)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [MarkLogicODBC.m line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L347)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [MarkLogicODBC.m line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L315)
* [Resources and modular source loading](../patterns/packaging.md): [MarkLogicODBC.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L358)
* [Schema and type enforcement](../patterns/schema.md): [MarkLogicODBC.m line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L90)
* [Structured errors and HTTP status handling](../patterns/errors.md): [MarkLogicODBC.m line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L139)
