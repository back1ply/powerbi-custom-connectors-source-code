---
type: Power Query Connector
title: Dataverse
description: Connect to Dataverse through its SQL endpoint
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.17
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq
  title: CommonDataService.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CommonDataService/1.1.17/CommonDataService_1.1.17.pqx
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
| Microsoft | 1.1.17 | Aad |

# Source files

* [CommonDataService.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CommonDataService.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L11) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CommonDataService.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L98) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CommonDataService. [CommonDataService.pq line 321](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L321) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CommonDataService.Database. [CommonDataService.pq line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L61) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CommonDataService.pq line 413](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L413) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [CommonDataService.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L145) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CommonDataService/CommonDataService.pq#L98) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
