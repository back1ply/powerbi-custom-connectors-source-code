---
type: Power Query Connector
title: eWay-CRM
description: Connect to eWay-CRM
tags: [oauth]
x-pqkb-publisher: eWayCRM
x-pqkb-version: 2.2.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m
  title: eWay_CRM.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/eWayCRM/2.2.0/eWayCRM_2.2.0.pqx
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
| eWayCRM | 2.2.0 | OAuth |

# Source files

* [eWay_CRM.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [eWay_CRM.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [eWay_CRM.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [eWay_CRM.m line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L216) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for eWayCRM. [eWay_CRM.m line 421](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L421) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: eWayCRM.Contents, eWayCRM.Contents2. [eWay_CRM.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [eWay_CRM.m line 1419](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L1419) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [eWay_CRM.m line 1423](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L1423) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [eWay_CRM.m line 326](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L326) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [eWay_CRM.m line 428](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L428) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [eWay_CRM.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/eWayCRM/eWay_CRM.m#L13) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
