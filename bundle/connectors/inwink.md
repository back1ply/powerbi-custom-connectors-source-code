---
type: Power Query Connector
title: inwink
description: Connect to inwink
tags: []
x-pqkb-publisher: inwink
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm
  title: auth.startlogin.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq
  title: inwink.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/inwink/1.0.0/inwink_1.0.0.pqx
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
| inwink | 1.0.0 | Not declared |

# Source files

* [auth.startlogin.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/auth.startlogin.pqm)
* [inwink.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [inwink.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [inwink.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [inwink.pq line 54](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L54) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for inwink. [inwink.pq line 21](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L21) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: inwink.ScopeContents. [inwink.pq line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L49) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [inwink.pq line 36](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L36) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [inwink.pq line 40](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L40) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [inwink.pq line 325](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L325) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [inwink.pq line 38](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L38) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [inwink.pq line 433](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/inwink/inwink.pq#L433) |
