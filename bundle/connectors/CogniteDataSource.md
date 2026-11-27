---
type: Power Query Connector
title: Cognite Data Fusion (REST API)
description: Connect to Cognite Data Fusion (CDF)
tags: [oauth]
x-pqkb-publisher: CogniteDataSource
x-pqkb-version: 1.1.3
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq
  title: CogniteDataSource.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CogniteDataSource/1.1.3/CogniteDataSource_1.1.3.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-27T12:12:40Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| CogniteDataSource | 1.1.3 | OAuth |

# Source files

* [CogniteDataSource.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.ToNavigationTable.pqm)
* [Value.ToText.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Value.ToText.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CogniteDataSource.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CogniteDataSource.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CogniteDataSource.pq line 56](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L56) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CogniteDataSource. [CogniteDataSource.pq line 192](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L192) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CogniteDataSource.Contents. [CogniteDataSource.pq line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L49) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CogniteDataSource.pq line 229](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L229) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [CogniteDataSource.pq line 301](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L301) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CogniteDataSource.pq line 56](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L56) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [CogniteDataSource.pq line 1159](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L1159) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [CogniteDataSource.pq line 1197](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L1197) |
