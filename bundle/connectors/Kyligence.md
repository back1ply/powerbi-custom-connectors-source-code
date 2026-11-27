---
type: Power Query Connector
title: KylinDirectQuery
description: Connect to KylinDirectQuery
tags: [usernamepassword]
x-pqkb-publisher: Kyligence
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m
  title: Kyligence.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kyligence/1.0.6/Kyligence_1.0.6.pqx
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
| Kyligence | 1.0.6 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm)
* [Kyligence.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Kyligence.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Kyligence.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Kyligence.m line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L13) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Kyligence. [Kyligence.m line 96](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L96) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Kyligence.Database. [Kyligence.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Kyligence.m line 116](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L116) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Kyligence.m line 121](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L121) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Kyligence.m line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L44) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Kyligence.m line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L5) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Kyligence.m line 130](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L130) |
