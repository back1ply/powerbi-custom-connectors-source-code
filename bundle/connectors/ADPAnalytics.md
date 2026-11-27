---
type: Power Query Connector
title: ADPAnalytics
description: Connect to ADPAnalytics
tags: [oauth]
x-pqkb-publisher: ADP
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m
  title: ADPAnalytics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ADPAnalytics/1.0.3/ADPAnalytics_1.0.3.pqx
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
| ADP | 1.0.3 | OAuth |

# Source files

* [ADPAnalytics.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ADPAnalytics.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ADPAnalytics.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ADPAnalytics. [ADPAnalytics.m line 336](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L336) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ADPAnalytics.Contents. [ADPAnalytics.m line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L14) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [ADPAnalytics.m line 351](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L351) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ADPAnalytics.m line 355](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L355) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [ADPAnalytics.m line 80](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L80) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ADPAnalytics.m line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L5) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [ADPAnalytics.m line 98](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L98) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
