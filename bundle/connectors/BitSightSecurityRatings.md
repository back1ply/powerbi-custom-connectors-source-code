---
type: Power Query Connector
title: Bitsight Security Ratings
description: Power BI connector source for Bitsight Security Ratings.
tags: [key]
x-pqkb-publisher: BitSight
x-pqkb-version: 4.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq
  title: BitSightSecurityRatings.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BitSightSecurityRatings/4.1.0/BitSightSecurityRatings_4.1.0.pqx
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
| BitSight | 4.1.0 | Key |

# Source files

* [BitSightSecurityRatings.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [BitSightSecurityRatings.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [BitSightSecurityRatings.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for BitSightSecurityRatings. [BitSightSecurityRatings.pq line 564](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L564) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: BitSightSecurityRatings.Contents. [BitSightSecurityRatings.pq line 559](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L559) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [BitSightSecurityRatings.pq line 578](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L578) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [BitSightSecurityRatings.pq line 582](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L582) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [BitSightSecurityRatings.pq line 611](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L611) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [BitSightSecurityRatings.pq line 569](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L569) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [BitSightSecurityRatings.pq line 21](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L21) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
