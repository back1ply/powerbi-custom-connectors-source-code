---
type: Power Query Connector
title: Windsor
description: Connect to Windsor
tags: [oauth]
x-pqkb-publisher: Windsor
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq
  title: Windsor.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Windsor/1.0.4/Windsor_1.0.4.pqx
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
| Windsor | 1.0.4 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Icons.pqm)
* [Windsor.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Windsor.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Windsor.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Windsor.pq line 708](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L708) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Windsor. [Windsor.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L13) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Windsor.Main. [Windsor.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L34) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Windsor.pq line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L27) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Windsor.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L30) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Windsor.pq line 1022](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L1022) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Windsor.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L11) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Windsor.pq line 238](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L238) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Windsor.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Windsor/Windsor.pq#L10) |
