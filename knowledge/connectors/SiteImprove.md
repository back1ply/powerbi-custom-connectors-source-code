---
type: Power Query Connector
title: Siteimprove
description: Connect to Siteimprove
tags: [errors, navigation, packaging, pagination, response-metadata, schema, usernamepassword]
publisher: SiteImprove
version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq
  title: Siteimprove.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SiteImprove/1.1.0/SiteImprove_1.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SiteImprove | 1.1.0 | UsernamePassword |

# Source files

* [Siteimprove.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ToNavigationTable.pqm)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Siteimprove.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L10)
* [Page generation and cursor traversal](../patterns/pagination.md): [Siteimprove.pq line 770](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L770)
* [Resources and modular source loading](../patterns/packaging.md): [Siteimprove.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L14)
* [Response and pagination metadata](../patterns/response-metadata.md): [Siteimprove.pq line 772](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L772), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm#L12)
* [Schema and type enforcement](../patterns/schema.md): [Siteimprove.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L6), [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.GenerateByPage.pqm#L20), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm#L27)
