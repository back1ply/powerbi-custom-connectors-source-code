---
type: Power Query Connector
title: Azure Resource Graph
description: Connect to Azure Resource Graph
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq
  title: AzureResourceGraph.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureResourceGraph/1.0.6/AzureResourceGraph_1.0.6.pqx
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
| Microsoft | 1.0.6 | Aad |

# Source files

* [AzureResourceGraph.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureResourceGraph.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureResourceGraph.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureResourceGraph.pq line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureResourceGraph. [AzureResourceGraph.pq line 176](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L176) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureResourceGraph.Query. [AzureResourceGraph.pq line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AzureResourceGraph.pq line 192](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L192) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureResourceGraph.pq line 195](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L195) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureResourceGraph.pq line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
