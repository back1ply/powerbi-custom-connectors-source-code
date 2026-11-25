---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m
  title: Intune.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneDataWarehouse/1.0.2/IntuneDataWarehouse_1.0.2.pqx
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
| Microsoft | 1.0.2 | Aad |

# Source files

* [Intune.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Intune.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Intune.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Intune.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L19) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Intune. [Intune.m line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L37) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Intune.Contents. [Intune.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L13) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Intune.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L58) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Intune.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L62) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Intune.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L32) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Intune.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneDataWarehouse/Intune.m#L60) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
