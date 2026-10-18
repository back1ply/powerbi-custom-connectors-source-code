---
type: Power Query Connector
title: AtScale cubes
description: Import/DirectQuery cube data from AtScale.
tags: [credentials, errors, navigation, packaging, schema, usernamepassword]
publisher: Microsoft
version: 3.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq
  title: AtScale.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AtScale/3.0.4/AtScale_3.0.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 3.0.4 | UsernamePassword |

# Source files

* [AtScale.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AtScale.pq line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L24)
* [Navigation tables and connection checks](../patterns/navigation.md): [AtScale.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L11)
* [Resources and modular source loading](../patterns/packaging.md): [AtScale.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L15)
* [Schema and type enforcement](../patterns/schema.md): [AtScale.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L8)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AtScale.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L103)
