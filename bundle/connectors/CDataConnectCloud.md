---
type: Power Query Connector
title: CData Connect Cloud
description: Connect to CData Connect Cloud
tags: [oauth]
x-pqkb-publisher: CData
x-pqkb-version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq
  title: CDataConnectCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm
  title: CDataConnectCloudRest.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm
  title: CDataConnectCloudRestV2.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm
  title: CDataConnectCloudService.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm
  title: CDataConnectCloudServiceV2.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm
  title: OAuth.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm
  title: Utilities.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CDataConnectCloud/3.1.0/CDataConnectCloud_3.1.0.pqx
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
| CData | 3.1.0 | OAuth |

# Source files

* [CDataConnectCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq)
* [CDataConnectCloudRest.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm)
* [CDataConnectCloudRestV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm)
* [CDataConnectCloudService.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudService.pqm)
* [CDataConnectCloudServiceV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Diagnostics.pqm)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/OAuth.pqm)
* [Utilities.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CDataConnectCloud.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CDataConnectCloud.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CDataConnectCloud.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L55) |
| Have a TestConnection handler. | MUST | Review | No data source kind found. |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Review | No shared function with a data source kind found. |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CDataConnectCloud.pq line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L23) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Utilities.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/Utilities.pqm#L14) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CDataConnectCloud.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L12) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [CDataConnectCloudRest.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L24) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [CDataConnectCloud.pq line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CDataConnectCloud/CDataConnectCloud.pq#L71) |
