---
type: Power Query Connector
title: ZendeskData
description: Power BI connector source for ZendeskData.
tags: [oauth]
x-pqkb-publisher: Zendesk
x-pqkb-version: 2.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm
  title: GetSchemaForEntity.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq
  title: zendesk.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZendeskData/2.0.1/ZendeskData_2.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T22:15:39Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Zendesk | 2.0.1 | OAuth |

# Source files

* [GetSchemaForEntity.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/GetSchemaForEntity.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm)
* [zendesk.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [zendesk.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [zendesk.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [zendesk.pq line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L69) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ZendeskData. [zendesk.pq line 245](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L245) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ZendeskData.Contents. [zendesk.pq line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L64) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [zendesk.pq line 260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L260) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [zendesk.pq line 262](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L262) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Table.ToNavigationTable.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/Table.ToNavigationTable.pqm#L13) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [zendesk.pq line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L69) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [zendesk.pq line 344](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZendeskData/zendesk.pq#L344) |
