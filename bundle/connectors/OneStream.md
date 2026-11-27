---
type: Power Query Connector
title: OneStream
description: Connect to OneStream
tags: [oauth]
x-pqkb-publisher: OneStream
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq
  title: OneStream.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneStream/1.0.4/OneStream_1.0.4.pqx
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
| OneStream | 1.0.4 | OAuth |

# Source files

* [OneStream.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [OneStream.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [OneStream.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [OneStream.pq line 48](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L48) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for OneStream. [OneStream.pq line 833](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L833) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: OneStream.Navigation. [OneStream.pq line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L44) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [OneStream.pq line 921](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L921) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [OneStream.pq line 925](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L925) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [OneStream.pq line 74](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L74) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [OneStream.pq line 842](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/OneStream/OneStream.pq#L842) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
