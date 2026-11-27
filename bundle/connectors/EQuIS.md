---
type: Power Query Connector
title: EQuIS
description: Power BI connector source for EQuIS.
tags: [aad, key, usernamepassword]
x-pqkb-publisher: EarthSoft
x-pqkb-version: 7.23.10067
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m
  title: EQuIS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/EQuIS/7.23.10067/EQuIS_7.23.10067.pqx
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
| EarthSoft | 7.23.10067 | Aad, Key, UsernamePassword |

# Source files

* [EQuIS.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [EQuIS.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L8) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [EQuIS.m line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L6) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [EQuIS.m line 112](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L112) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for EQuIS. [EQuIS.m line 32](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L32) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: EQuIS.Contents. [EQuIS.m line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L13) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [EQuIS.m line 18](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L18) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [EQuIS.m line 22](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L22) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [EQuIS.m line 142](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L142) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [EQuIS.m line 20](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L20) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [EQuIS.m line 127](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/EQuIS/EQuIS.m#L127) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
