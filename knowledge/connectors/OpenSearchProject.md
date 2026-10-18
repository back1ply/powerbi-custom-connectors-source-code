---
type: Power Query Connector
title: OpenSearch Project
description: Connect to OpenSearch
tags: [credentials, diagnostics, errors, implicit, key, navigation, odbc, packaging, schema, usernamepassword]
publisher: Amazon
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m
  title: OpenSearchProject.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OpenSearchProject/1.0.1/OpenSearchProject_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Amazon | 1.0.1 | Implicit, Key, UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OdbcConstants.pqm)
* [OpenSearchProject.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [OpenSearchProject.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L38)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [OpenSearchProject.m line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L183)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [OpenSearchProject.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L154)
* [Resources and modular source loading](../patterns/packaging.md): [OpenSearchProject.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L222)
* [Schema and type enforcement](../patterns/schema.md): [OpenSearchProject.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L12)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OpenSearchProject.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L174)
