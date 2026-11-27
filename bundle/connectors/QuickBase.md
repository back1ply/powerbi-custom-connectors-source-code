---
type: Power Query Connector
title: qbconnector
description: Connect to qbconnector
tags: [key]
x-pqkb-publisher: QuickBase
x-pqkb-version: 1.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m
  title: qbconnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QuickBase/1.4.0/QuickBase_1.4.0.pqx
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
| QuickBase | 1.4.0 | Key |

# Source files

* [qbconnector.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [qbconnector.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L8) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [qbconnector.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L7) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [qbconnector.m line 20](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L20) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for QuickBase. [qbconnector.m line 428](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L428) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: QuickBase.Contents. [qbconnector.m line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L10) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [qbconnector.m line 441](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L441) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [qbconnector.m line 445](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L445) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [qbconnector.m line 96](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L96) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [qbconnector.m line 12](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L12) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [qbconnector.m line 32](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/QuickBase/qbconnector.m#L32) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
