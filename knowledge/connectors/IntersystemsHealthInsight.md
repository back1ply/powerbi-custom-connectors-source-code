---
type: Power Query Connector
title: InterSystems Health Insight
description: Connect to InterSystems Health Insight
tags: [buffering, credentials, diagnostics, errors, navigation, odbc, packaging, response-metadata, schema, usernamepassword]
publisher: IntersystemsHealthInsight
version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq
  title: IntersystemsHealthInsight.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntersystemsHealthInsight/1.0.4/IntersystemsHealthInsight_1.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| IntersystemsHealthInsight | 1.0.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/Diagnostics.pqm)
* [IntersystemsHealthInsight.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/OdbcConstants.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [IntersystemsHealthInsight.pq line 440](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L440)
* [Credential access](../patterns/credentials.md): [IntersystemsHealthInsight.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L93)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [IntersystemsHealthInsight.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L22)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [IntersystemsHealthInsight.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L137)
* [Resources and modular source loading](../patterns/packaging.md): [IntersystemsHealthInsight.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L21)
* [Response and pagination metadata](../patterns/response-metadata.md): [IntersystemsHealthInsight.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L187)
* [Schema and type enforcement](../patterns/schema.md): [IntersystemsHealthInsight.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L16)
* [Structured errors and HTTP status handling](../patterns/errors.md): [IntersystemsHealthInsight.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L103)
