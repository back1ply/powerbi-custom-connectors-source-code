---
type: Power Query Connector
title: ZendeskData
description: Power BI connector source for ZendeskData.
tags: [errors, navigation, oauth, oauth2, packaging, pagination, response-metadata, schema]
publisher: Zendesk
version: 2.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/GetSchemaForEntity.pqm
  title: GetSchemaForEntity.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq
  title: zendesk.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZendeskData/2.0.1/ZendeskData_2.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Zendesk | 2.0.1 | OAuth |

# Source files

* [GetSchemaForEntity.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/GetSchemaForEntity.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ToNavigationTable.pqm)
* [zendesk.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [zendesk.pq line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L157)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [zendesk.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L249)
* [Page generation and cursor traversal](../patterns/pagination.md): [zendesk.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L211)
* [Resources and modular source loading](../patterns/packaging.md): [zendesk.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L8)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm#L12), [zendesk.pq line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L215)
* [Schema and type enforcement](../patterns/schema.md): [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.GenerateByPage.pqm#L23), [Table.ToNavigationTable.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ToNavigationTable.pqm#L19), [zendesk.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L65)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm#L27)
