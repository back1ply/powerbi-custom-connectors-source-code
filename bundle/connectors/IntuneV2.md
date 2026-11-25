---
type: Power Query Connector
title: Intune Data Warehouse
description: Connect to Intune Data Warehouse
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq
  title: IntuneV2.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntuneV2/2.0.0/IntuneV2_2.0.0.pqx
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
| Microsoft | 2.0.0 | Aad |

# Source files

* [IntuneV2.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [IntuneV2.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [IntuneV2.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L14) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for IntuneV2. [IntuneV2.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L62) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: IntuneV2.Contents. [IntuneV2.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [IntuneV2.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L74) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [IntuneV2.pq line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L77) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [IntuneV2.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L56) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntuneV2/IntuneV2.pq#L14) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
