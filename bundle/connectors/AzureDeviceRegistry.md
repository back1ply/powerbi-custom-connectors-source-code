---
type: Power Query Connector
title: Azure Device Registry (ADR)
description: Connect to AzureDeviceRegistry
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq
  title: AzureDeviceRegistry.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm
  title: CommonFunctions.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/QueryHelper.pqm
  title: QueryHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureDeviceRegistry/1.0.3/AzureDeviceRegistry_1.0.3.pqx
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
| Microsoft | 1.0.3 | Aad |

# Source files

* [AzureDeviceRegistry.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq)
* [CommonFunctions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/CommonFunctions.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/Diagnostics.pqm)
* [QueryHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/QueryHelper.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureDeviceRegistry.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureDeviceRegistry.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureDeviceRegistry.pq line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L66) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureDeviceRegistry. [AzureDeviceRegistry.pq line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L36) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureDeviceRegistry.Query. [AzureDeviceRegistry.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L115) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [AzureDeviceRegistry.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L52) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureDeviceRegistry.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L55) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AzureDeviceRegistry.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L139) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureDeviceRegistry.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L47) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [AzureDeviceRegistry.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L121) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AzureDeviceRegistry.pq line 341](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L341) |
