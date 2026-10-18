---
type: Power Query Connector
title: Cognite Data Fusion (OData)
description: Connect to Cognite Data Fusion (CDF)
tags: [aad, credentials, errors, navigation, odata, packaging, response-metadata, schema]
publisher: Cognite
version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq
  title: Cognite.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cognite/1.0.9/Cognite_1.0.9.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Cognite | 1.0.9 | Aad |

# Source files

* [Cognite.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq)
* [Value.ToText.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Value.ToText.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Cognite.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L129)
* [Navigation tables and connection checks](../patterns/navigation.md): [Cognite.pq line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L87)
* [OData feeds](../patterns/odata.md): [Cognite.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L147)
* [Resources and modular source loading](../patterns/packaging.md): [Cognite.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L52)
* [Response and pagination metadata](../patterns/response-metadata.md): [Cognite.pq line 246](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L246)
* [Schema and type enforcement](../patterns/schema.md): [Cognite.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L48)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Cognite.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L242)
