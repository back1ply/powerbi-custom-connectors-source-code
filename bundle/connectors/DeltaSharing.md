---
type: Power Query Connector
title: Delta Sharing
description: Import Data from Delta Sharing Server
tags: [key, oauth]
x-pqkb-publisher: Databricks
x-pqkb-version: 1.1.4
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq
  title: DeltaSharing.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DeltaSharing/1.1.4/DeltaSharing_1.1.4.pqx
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
| Databricks | 1.1.4 | Key, OAuth |

# Source files

* [DeltaSharing.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [DeltaSharing.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [DeltaSharing.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [DeltaSharing.pq line 229](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L229) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for DeltaSharing. [DeltaSharing.pq line 15](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L15) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: DeltaSharing.Contents. [DeltaSharing.pq line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [DeltaSharing.pq line 216](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L216) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [DeltaSharing.pq line 296](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L296) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [DeltaSharing.pq line 36](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L36) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [DeltaSharing.pq line 587](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L587) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [DeltaSharing.pq line 595](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DeltaSharing/DeltaSharing.pq#L595) |
