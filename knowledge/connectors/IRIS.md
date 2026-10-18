---
type: Power Query Connector
title: InterSystems IRIS
description: Connect to InterSystems IRIS
tags: [buffering, credentials, diagnostics, errors, navigation, odbc, packaging, response-metadata, schema, usernamepassword]
publisher: InterSystems
version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m
  title: Iris_PowerBI_Connector.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IRIS/1.1.2/IRIS_1.1.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| InterSystems | 1.1.2 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Diagnostics.pqm)
* [Iris_PowerBI_Connector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/OdbcConstants.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Iris_PowerBI_Connector.m line 414](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L414)
* [Credential access](../patterns/credentials.md): [Iris_PowerBI_Connector.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L81)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Iris_PowerBI_Connector.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L18)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Iris_PowerBI_Connector.m line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L125)
* [Resources and modular source loading](../patterns/packaging.md): [Iris_PowerBI_Connector.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L17)
* [Response and pagination metadata](../patterns/response-metadata.md): [Iris_PowerBI_Connector.m line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L175)
* [Schema and type enforcement](../patterns/schema.md): [Iris_PowerBI_Connector.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L14)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Iris_PowerBI_Connector.m line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L91)
