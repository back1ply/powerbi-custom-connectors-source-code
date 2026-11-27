---
type: Power Query Connector
title: Dynatrace_Grail_DQL
description: Connect to Dynatrace_Grail_DQL
tags: [oauth]
x-pqkb-publisher: Dynatrace
x-pqkb-version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m
  title: DynatraceGrail.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DynatraceGrail/1.0.7/DynatraceGrail_1.0.7.pqx
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
| Dynatrace | 1.0.7 | OAuth |

# Source files

* [DynatraceGrail.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [DynatraceGrail.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [DynatraceGrail.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [DynatraceGrail.m line 43](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L43) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for DynatraceGrail. [DynatraceGrail.m line 346](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L346) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: DynatraceGrail.Contents. [DynatraceGrail.m line 87](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L87) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [DynatraceGrail.m line 361](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L361) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [DynatraceGrail.m line 365](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L365) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [DynatraceGrail.m line 101](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DynatraceGrail/DynatraceGrail.m#L101) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
