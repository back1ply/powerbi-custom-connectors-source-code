---
type: Power Query Connector
title: Azure Cost Management
description: Connect to Azure Cost Management
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.42
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq
  title: AzureCostManagement.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCostManagement/1.0.42/AzureCostManagement_1.0.42.pqx
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
| Microsoft | 1.0.42 | Aad |

# Source files

* [AzureCostManagement.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureCostManagement.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L4) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureCostManagement.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L3) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureCostManagement.pq line 2349](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2349) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureCostManagement. [AzureCostManagement.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L151) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureCostManagement.Contents, AzureCostManagement.Tables. [AzureCostManagement.pq line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L108) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureCostManagement.pq line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L118) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AzureCostManagement.pq line 421](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L421) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureCostManagement.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L117) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [AzureCostManagement.pq line 2284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2284) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [AzureCostManagement.pq line 2445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L2445) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AzureCostManagement.pq line 3014](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCostManagement/AzureCostManagement.pq#L3014) |
