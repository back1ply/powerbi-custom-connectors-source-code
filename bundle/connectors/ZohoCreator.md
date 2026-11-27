---
type: Power Query Connector
title: Zoho Creator
description: Connect to Zoho Creator
tags: [oauth]
x-pqkb-publisher: Zoho
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m
  title: ZohoCreator.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZohoCreator/2.0.0/ZohoCreator_2.0.0.pqx
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
| Zoho | 2.0.0 | OAuth |

# Source files

* [ZohoCreator.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ZohoCreator.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ZohoCreator.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [ZohoCreator.m line 90](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L90) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ZohoCreator. [ZohoCreator.m line 120](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L120) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ZohoCreator.Contents. [ZohoCreator.m line 85](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L85) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [ZohoCreator.m line 223](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L223) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ZohoCreator.m line 227](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L227) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ZohoCreator.m line 225](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L225) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
