---
type: Power Query Connector
title: SingleStore Direct Query Connector
description: SingleStoreDirectQueryConnector
tags: [credentials, diagnostics, errors, native-query, navigation, odbc, packaging, schema, usernamepassword, windows]
publisher: SingleStore
version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m
  title: SingleStoreODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SingleStoreODBC/1.1.1/SingleStoreODBC_1.1.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SingleStore | 1.1.1 | UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/OdbcConstants.pqm)
* [SingleStoreODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [SingleStoreODBC.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L153)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/Diagnostics.pqm#L2)
* [Native queries](../patterns/native-query.md): [SingleStoreODBC.m line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L395)
* [Navigation tables and connection checks](../patterns/navigation.md): [SingleStoreODBC.m line 446](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L446)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [SingleStoreODBC.m line 308](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L308)
* [Resources and modular source loading](../patterns/packaging.md): [SingleStoreODBC.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L16)
* [Schema and type enforcement](../patterns/schema.md): [SingleStoreODBC.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L270)
* [Structured errors and HTTP status handling](../patterns/errors.md): [SingleStoreODBC.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L162)
