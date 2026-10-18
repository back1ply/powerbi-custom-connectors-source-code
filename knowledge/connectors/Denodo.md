---
type: Power Query Connector
title: Denodo
description: Connect to Denodo
tags: [aad, credentials, diagnostics, errors, navigation, odbc, packaging, schema, usernamepassword, windows]
publisher: Denodo
version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m
  title: DenodoForPowerBI.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Validation.pqm
  title: Validation.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Denodo/1.1.2/Denodo_1.1.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Denodo | 1.1.2 | Aad, UsernamePassword, Windows |

# Source files

* [DenodoForPowerBI.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Diagnostics.pqm)
* [Validation.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Validation.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [DenodoForPowerBI.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L101)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Diagnostics.pqm#L32)
* [Navigation tables and connection checks](../patterns/navigation.md): [DenodoForPowerBI.m line 556](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L556)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [DenodoForPowerBI.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L209)
* [Resources and modular source loading](../patterns/packaging.md): [DenodoForPowerBI.m line 595](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L595)
* [Schema and type enforcement](../patterns/schema.md): [DenodoForPowerBI.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L26)
* [Structured errors and HTTP status handling](../patterns/errors.md): [DenodoForPowerBI.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L75), [Validation.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Validation.pqm#L50)
