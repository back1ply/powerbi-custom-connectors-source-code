---
type: Power Query Connector
title: Data Virtuality LDW
description: Connect to Data Virtuality LDW
tags: [credentials, errors, navigation, odbc, packaging, schema, usernamepassword]
publisher: Data Virtuality
version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m
  title: DataVirtuality.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DataVirtuality/3.0.1/DataVirtuality_3.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Data Virtuality | 3.0.1 | UsernamePassword |

# Source files

* [DataVirtuality.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [DataVirtuality.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L42)
* [Navigation tables and connection checks](../patterns/navigation.md): [DataVirtuality.m line 206](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L206)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [DataVirtuality.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L53)
* [Resources and modular source loading](../patterns/packaging.md): [DataVirtuality.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L25)
* [Schema and type enforcement](../patterns/schema.md): [DataVirtuality.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L8)
* [Structured errors and HTTP status handling](../patterns/errors.md): [DataVirtuality.m line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L150)
