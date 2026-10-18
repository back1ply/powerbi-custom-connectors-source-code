---
type: Power Query Connector
title: BQE CORE
description: Connect to BQE CORE
tags: [errors, navigation, oauth, oauth2, packaging, schema]
publisher: BQE
version: 12.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq
  title: BQECore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BQECore/12.0.0/BQECore_12.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| BQE | 12.0.0 | OAuth |

# Source files

* [BQECore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [BQECore.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L137)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [BQECore.pq line 2535](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L2535)
* [Resources and modular source loading](../patterns/packaging.md): [BQECore.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L3)
* [Schema and type enforcement](../patterns/schema.md): [BQECore.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L16)
* [Structured errors and HTTP status handling](../patterns/errors.md): [BQECore.pq line 2567](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L2567)
