---
type: Power Query Connector
title: Cognite Data Fusion (REST API)
description: Connect to Cognite Data Fusion (CDF)
tags: [credentials, errors, graphql, navigation, oauth, oauth2, odata, packaging, pagination, pkce, response-metadata, retry-polling, schema]
publisher: CogniteDataSource
version: 1.1.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq
  title: CogniteDataSource.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CogniteDataSource/1.1.3/CogniteDataSource_1.1.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| CogniteDataSource | 1.1.3 | OAuth |

# Source files

* [CogniteDataSource.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.ToNavigationTable.pqm)
* [Value.ToText.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Value.ToText.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [CogniteDataSource.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L314)
* [GraphQL requests](../patterns/graphql.md): [CogniteDataSource.pq line 987](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L987)
* [Navigation tables and connection checks](../patterns/navigation.md): [CogniteDataSource.pq line 208](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L208)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [CogniteDataSource.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L84)
* [OData feeds](../patterns/odata.md): [CogniteDataSource.pq line 544](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L544)
* [Page generation and cursor traversal](../patterns/pagination.md): [CogniteDataSource.pq line 696](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L696)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [CogniteDataSource.pq line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L104)
* [Resources and modular source loading](../patterns/packaging.md): [CogniteDataSource.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L56)
* [Response and pagination metadata](../patterns/response-metadata.md): [CogniteDataSource.pq line 661](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L661)
* [Retries, delays, and polling](../patterns/retry-polling.md): [CogniteDataSource.pq line 715](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L715)
* [Schema and type enforcement](../patterns/schema.md): [CogniteDataSource.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L50), [Table.GenerateByPage.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L24), [Table.ToNavigationTable.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.ToNavigationTable.pqm#L21)
* [Structured errors and HTTP status handling](../patterns/errors.md): [CogniteDataSource.pq line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L166)
