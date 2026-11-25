---
type: Power Query Connector
title: Sentinel
description: Power BI connector source for Sentinel.
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq
  title: Sentinel.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Sentinel/1.0.2/Sentinel_1.0.2.pqx
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

* [Sentinel.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Sentinel.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Sentinel.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L11) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MicrosoftSentinel. [Sentinel.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L121) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MicrosoftSentinel.Contents. [Sentinel.pq line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L118) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Sentinel.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L139) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Sentinel.pq line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L143) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L11) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Sentinel.pq line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Sentinel/Sentinel.pq#L105) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
