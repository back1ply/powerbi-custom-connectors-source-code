---
type: Power Query Connector
title: InformationGrid
description: Access BI services from InformationGrid
tags: [key]
x-pqkb-publisher: Luminis
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq
  title: InformationGrid.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/InformationGrid/1.0.5/InformationGrid_1.0.5.pqx
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
| Luminis | 1.0.5 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm)
* [InformationGrid.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [InformationGrid.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [InformationGrid.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L11) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for InformationGrid. [InformationGrid.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L192) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: InformationGrid.Contents. [InformationGrid.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L6) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [InformationGrid.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L211) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [InformationGrid.pq line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L215) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [InformationGrid.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L65) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L11) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [InformationGrid.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L32) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [InformationGrid.pq line 239](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/InformationGrid/InformationGrid.pq#L239) |
