---
type: Power Query Connector
title: Digital Construction Works Insights
description: Get Help
tags: [key]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m
  title: DCWInsights.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DCWInsights/1.0.3/DCWInsights_1.0.3.pqx
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
| Microsoft | 1.0.3 | Key |

# Source files

* [DCWInsights.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [DCWInsights.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [DCWInsights.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [DCWInsights.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L14) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for DCWInsights. [DCWInsights.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L36) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: DCWInsights.Feed. [DCWInsights.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [DCWInsights.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L47) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [DCWInsights.m line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L51) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [DCWInsights.m line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L31) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [DCWInsights.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L14) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [DCWInsights.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DCWInsights/DCWInsights.m#L11) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
