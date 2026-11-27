---
type: Power Query Connector
title: Supermetrics
description: Power BI connector source for Supermetrics.
tags: [oauth]
x-pqkb-publisher: Supermetrics
x-pqkb-version: 3.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m
  title: Supermetrics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Supermetrics/3.4.0/Supermetrics_3.4.0.pqx
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
| Supermetrics | 3.4.0 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Icons.pqm)
* [Supermetrics.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Supermetrics.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Supermetrics.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Supermetrics.m line 475](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L475) |
| Have a TestConnection handler. | MUST | Review | No data source kind found. |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Review | No shared function with a data source kind found. |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Supermetrics.m line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L19) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Supermetrics.m line 23](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L23) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Supermetrics.m line 43](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L43) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Supermetrics.m line 15](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L15) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Supermetrics.m line 272](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L272) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Supermetrics.m line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L6) |
