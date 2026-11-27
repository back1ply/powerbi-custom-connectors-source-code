---
type: Power Query Connector
title: BQE CORE
description: Connect to BQE CORE
tags: [oauth]
x-pqkb-publisher: BQE
x-pqkb-version: 12.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq
  title: BQECore.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BQECore/12.0.1/BQECore_12.0.1.pqx
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
| BQE | 12.0.1 | OAuth |

# Source files

* [BQECore.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [BQECore.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [BQECore.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for BQECore. [BQECore.pq line 2531](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2531) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: BQECore.Contents. [BQECore.pq line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L14) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [BQECore.pq line 2602](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2602) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [BQECore.pq line 2606](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L2606) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [BQECore.pq line 20](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L20) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [BQECore.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BQECore/BQECore.pq#L3) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
