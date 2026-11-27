---
type: Power Query Connector
title: Planview ProjectPlace
description: Connect to Planview ProjectPlace
tags: [oauth]
x-pqkb-publisher: Planview
x-pqkb-version: 3.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m
  title: PlanviewProjectplace.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PlanviewProjectplace/3.0.0/PlanviewProjectplace_3.0.0.pqx
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
| Planview | 3.0.0 | OAuth |

# Source files

* [PlanviewProjectplace.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [PlanviewProjectplace.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [PlanviewProjectplace.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [PlanviewProjectplace.m line 140](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L140) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for PlanviewProjectplace. [PlanviewProjectplace.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L7) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: PlanviewProjectplace.Contents. [PlanviewProjectplace.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [PlanviewProjectplace.m line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L19) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [PlanviewProjectplace.m line 22](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L22) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [PlanviewProjectplace.m line 133](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L133) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [PlanviewProjectplace.m line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L14) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
