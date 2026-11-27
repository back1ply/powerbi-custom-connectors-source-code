---
type: Power Query Connector
title: SoftOne BI
description: Connect to Soft1 / Atlantis
tags: [oauth]
x-pqkb-publisher: SoftOne
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m
  title: SoftOneBI.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SoftOneBI/1.0.0/SoftOneBI_1.0.0.pqx
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
| SoftOne | 1.0.0 | OAuth |

# Source files

* [SoftOneBI.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SoftOneBI.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SoftOneBI.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SoftOneBI.m line 29](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L29) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SoftOneBI. [SoftOneBI.m line 215](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L215) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SoftOneBI.Contents. [SoftOneBI.m line 24](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L24) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [SoftOneBI.m line 233](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L233) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SoftOneBI.m line 237](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L237) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [SoftOneBI.m line 50](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L50) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SoftOneBI.m line 17](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L17) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [SoftOneBI.m line 43](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SoftOneBI/SoftOneBI.m#L43) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
