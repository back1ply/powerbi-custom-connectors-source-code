---
type: Power Query Connector
title: JethroDataConnector
description: Connect to JethroDataConnector
tags: [credentials, navigation, odbc, packaging, usernamepassword]
publisher: Jethro
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m
  title: JethroODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JethroData/1.0.2/JethroData_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Jethro | 1.0.2 | UsernamePassword |

# Source files

* [JethroODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [JethroODBC.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L27)
* [Navigation tables and connection checks](../patterns/navigation.md): [JethroODBC.m line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L109)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [JethroODBC.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L38)
* [Resources and modular source loading](../patterns/packaging.md): [JethroODBC.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L122)
