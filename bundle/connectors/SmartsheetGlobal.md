---
type: Power Query Connector
title: SmartsheetGlobal
description: Power BI connector source for SmartsheetGlobal.
tags: [oauth]
x-pqkb-publisher: Smartsheet
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq
  title: SmartsheetGlobal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SmartsheetGlobal/1.1.1/SmartsheetGlobal_1.1.1.pqx
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
| Smartsheet | 1.1.1 | OAuth |

# Source files

* [SmartsheetGlobal.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SmartsheetGlobal.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SmartsheetGlobal.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SmartsheetGlobal.pq line 553](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L553) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SmartsheetGlobal. [SmartsheetGlobal.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L10) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SmartsheetGlobal.Query, SmartsheetGlobal.Contents. [SmartsheetGlobal.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [SmartsheetGlobal.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L49) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SmartsheetGlobal.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L52) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [SmartsheetGlobal.pq line 468](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L468) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SmartsheetGlobal.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L51) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [SmartsheetGlobal.pq line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L163) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
