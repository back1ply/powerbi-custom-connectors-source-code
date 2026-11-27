---
type: Power Query Connector
title: Attio
description: Power BI connector source for Attio.
tags: [key]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq
  title: Attio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Attio/1.0.1/Attio_1.0.1.pqx
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
| Microsoft | 1.0.1 | Key |

# Source files

* [Attio.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Attio.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Attio.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Attio.pq line 653](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L653) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Attio. [Attio.pq line 669](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L669) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Attio.Contents. [Attio.pq line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Attio.pq line 681](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L681) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Attio.pq line 684](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L684) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Attio.pq line 646](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L646) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Attio.pq line 653](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L653) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Attio.pq line 472](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L472) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
