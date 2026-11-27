---
type: Power Query Connector
title: SIS-CC SDMX
description: Get data from an SDMX RESTful web service that supports the CSV format.
tags: [implicit]
x-pqkb-publisher: SISCC
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m
  title: SDMX.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SDMX/1.0.5/SDMX_1.0.5.pqx
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
| SISCC | 1.0.5 | Implicit |

# Source files

* [SDMX.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SDMX.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SDMX.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SDMX.m line 17](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L17) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SDMX. [SDMX.m line 68](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L68) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SDMX.Contents. [SDMX.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [SDMX.m line 79](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L79) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SDMX.m line 83](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L83) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SDMX.m line 17](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SDMX/SDMX.m#L17) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
