---
type: Power Query Connector
title: Viva Insights
description: Connect to Viva Insights Data
tags: [aad, buffering, diagnostics, errors, navigation, packaging, pagination, response-metadata, retry-polling, schema, table-view]
publisher: Microsoft
version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq
  title: WorkplaceAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WorkplaceAnalytics/3.1.0/WorkplaceAnalytics_3.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 3.1.0 | Aad |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm)
* [WorkplaceAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [WorkplaceAnalytics.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L278)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [WorkplaceAnalytics.pq line 752](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L752)
* [Page generation and cursor traversal](../patterns/pagination.md): [WorkplaceAnalytics.pq line 557](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L557)
* [Resources and modular source loading](../patterns/packaging.md): [WorkplaceAnalytics.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L217)
* [Response and pagination metadata](../patterns/response-metadata.md): [Diagnostics.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm#L178), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L12), [WorkplaceAnalytics.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L279)
* [Retries, delays, and polling](../patterns/retry-polling.md): [WorkplaceAnalytics.pq line 416](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L416)
* [Schema and type enforcement](../patterns/schema.md): [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L58), [WorkplaceAnalytics.pq line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L89)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L27), [WorkplaceAnalytics.pq line 205](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L205)
* [Table.View handlers](../patterns/table-view.md): [WorkplaceAnalytics.pq line 573](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L573)
