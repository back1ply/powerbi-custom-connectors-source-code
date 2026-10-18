---
type: Power Query Connector
title: SumTotal
description: Connect to SumTotal
tags: [errors, navigation, oauth, oauth2, odata, packaging, pagination, response-metadata, schema]
publisher: SumTotal
version: 3.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq
  title: SumTotal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SumTotal/3.0.0/SumTotal_3.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SumTotal | 3.0.0 | OAuth |

# Source files

* [SumTotal.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [SumTotal.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L180)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [SumTotal.pq line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L183)
* [OData feeds](../patterns/odata.md): [SumTotal.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L65)
* [Page generation and cursor traversal](../patterns/pagination.md): [SumTotal.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L137)
* [Resources and modular source loading](../patterns/packaging.md): [SumTotal.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L259)
* [Response and pagination metadata](../patterns/response-metadata.md): [SumTotal.pq line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L140)
* [Schema and type enforcement](../patterns/schema.md): [SumTotal.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L21)
* [Structured errors and HTTP status handling](../patterns/errors.md): [SumTotal.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L218)
