---
type: Power Query Connector
title: FifteenFive
description: Power BI connector source for FifteenFive.
tags: [key]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq
  title: FifteenFive.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FifteenFive/1.0.1/FifteenFive_1.0.1.pqx
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
| Microsoft | 1.0.1 | Key |

# Source files

* [FifteenFive.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [FifteenFive.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [FifteenFive.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [FifteenFive.pq line 983](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L983) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for FifteenFive. [FifteenFive.pq line 999](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L999) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: FifteenFive.Contents. [FifteenFive.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [FifteenFive.pq line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L1011) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [FifteenFive.pq line 1014](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L1014) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [FifteenFive.pq line 976](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L976) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [FifteenFive.pq line 983](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L983) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [FifteenFive.pq line 838](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FifteenFive/FifteenFive.pq#L838) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
