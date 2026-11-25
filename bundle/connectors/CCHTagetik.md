---
type: Power Query Connector
title: Wolters Kluwer CCH Tagetik
description: Connect to Wolters Kluwer CCH Tagetik
tags: [usernamepassword]
x-pqkb-publisher: CCHTagetik
x-pqkb-version: 1.4.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq
  title: CCHTagetik.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CCHTagetik/1.4.2/CCHTagetik_1.4.2.pqx
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
| CCHTagetik | 1.4.2 | UsernamePassword |

# Source files

* [CCHTagetik.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CCHTagetik.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CCHTagetik.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CCHTagetik.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L54) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CCHTagetik. [CCHTagetik.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L6) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CCHTagetik.Contents, CCHTagetik.Contents2, CCHTagetik.Contents3, CCHTagetik.Contents4. [CCHTagetik.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L49) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [CCHTagetik.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L30) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [CCHTagetik.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L35) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [CCHTagetik.pq line 1074](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L1074) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CCHTagetik.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L21) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [CCHTagetik.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L292) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [CCHTagetik.pq line 1080](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L1080) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
