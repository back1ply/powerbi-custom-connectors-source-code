---
type: Power Query Connector
title: IndustrialConnector
description: Connect to IndustrialConnector
tags: []
x-pqkb-publisher: IntelligentPlant
x-pqkb-version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq
  title: IndustrialAppStore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IndustrialAppStore/3.0.1/IndustrialAppStore_3.0.1.pqx
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
| IntelligentPlant | 3.0.1 | Not declared |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm)
* [IndustrialAppStore.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [IndustrialAppStore.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [IndustrialAppStore.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [IndustrialAppStore.pq line 80](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L80) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for IndustrialAppStore. [IndustrialAppStore.pq line 283](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L283) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: IndustrialAppStore.NavigationTable. [IndustrialAppStore.pq line 303](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L303) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [IndustrialAppStore.pq line 1141](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1141) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [IndustrialAppStore.pq line 1146](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1146) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [IndustrialAppStore.pq line 317](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L317) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [IndustrialAppStore.pq line 1532](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1532) |
