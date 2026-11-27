---
type: Power Query Connector
title: LEAP
description: Connect to LEAP
tags: [oauth]
x-pqkb-publisher: LEAP
x-pqkb-version: 1.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m
  title: LEAP.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LEAP/1.3.0/LEAP_1.3.0.pqx
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
| LEAP | 1.3.0 | OAuth |

# Source files

* [LEAP.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [LEAP.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [LEAP.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [LEAP.m line 46](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L46) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for LEAP. [LEAP.m line 71](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L71) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: LEAP.Contents. [LEAP.m line 40](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L40) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [LEAP.m line 85](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L85) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [LEAP.m line 89](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L89) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [LEAP.m line 253](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L253) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [LEAP.m line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L47) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [LEAP.m line 99](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L99) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [LEAP.m line 1598](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L1598) |
