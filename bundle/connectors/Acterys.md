---
type: Power Query Connector
title: 'Acterys: Model Automation & Planning'
description: Connect to Acterys
tags: [aad]
x-pqkb-publisher: Managility
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq
  title: Acterys.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Acterys/1.0.1/Acterys_1.0.1.pqx
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
| Managility | 1.0.1 | Aad |

# Source files

* [Acterys.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Acterys.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Acterys.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Acterys. [Acterys.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L211) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Acterys.Contents. [Acterys.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Acterys.pq line 225](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L225) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Acterys.pq line 229](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L229) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Acterys.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L57) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Acterys.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Acterys/Acterys.pq#L219) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
