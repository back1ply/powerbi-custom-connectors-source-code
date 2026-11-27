---
type: Power Query Connector
title: Workforce Dimensions
description: Connect to Workforce Dimensions
tags: [usernamepassword]
x-pqkb-publisher: Kronos
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m
  title: WorkforceDimensions.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WorkforceDimensions/1.0.3/WorkforceDimensions_1.0.3.pqx
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
| Kronos | 1.0.3 | UsernamePassword |

# Source files

* [WorkforceDimensions.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [WorkforceDimensions.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [WorkforceDimensions.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [WorkforceDimensions.m line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L47) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for WorkforceDimensions. [WorkforceDimensions.m line 420](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L420) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: WorkforceDimensions.Contents. [WorkforceDimensions.m line 41](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L41) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [WorkforceDimensions.m line 436](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L436) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [WorkforceDimensions.m line 440](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L440) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [WorkforceDimensions.m line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L47) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [WorkforceDimensions.m line 82](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkforceDimensions/WorkforceDimensions.m#L82) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
