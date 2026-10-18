---
type: Power Query Connector
title: Delta Sharing
description: Import Data from Delta Sharing Server
tags: [buffering, credentials, errors, key, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema]
publisher: Databricks
version: 1.1.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq
  title: DeltaSharing.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DeltaSharing/1.1.4/DeltaSharing_1.1.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Databricks | 1.1.4 | Key, OAuth |

# Source files

* [DeltaSharing.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/Table.ToNavigationTable.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [DeltaSharing.pq line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L432)
* [Credential access](../patterns/credentials.md): [DeltaSharing.pq line 464](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L464)
* [Navigation tables and connection checks](../patterns/navigation.md): [DeltaSharing.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L16)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [DeltaSharing.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L25)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [DeltaSharing.pq line 195](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L195)
* [Resources and modular source loading](../patterns/packaging.md): [DeltaSharing.pq line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L36)
* [Response and pagination metadata](../patterns/response-metadata.md): [DeltaSharing.pq line 355](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L355)
* [Retries, delays, and polling](../patterns/retry-polling.md): [DeltaSharing.pq line 335](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L335)
* [Schema and type enforcement](../patterns/schema.md): [DeltaSharing.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L6), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [DeltaSharing.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L49)
