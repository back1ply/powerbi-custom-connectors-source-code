---
type: Power Query Connector
title: Planview OKR
description: Connect to Planview OKR
tags: [oauth]
x-pqkb-publisher: Planview
x-pqkb-version: 2.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m
  title: PlanviewOKR.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PlanviewOKR/2.0.2/PlanviewOKR_2.0.2.pqx
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
| Planview | 2.0.2 | OAuth |

# Source files

* [PlanviewOKR.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [PlanviewOKR.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [PlanviewOKR.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [PlanviewOKR.m line 180](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L180) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for PlanviewOKR. [PlanviewOKR.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L7) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: PlanviewOKR.Contents. [PlanviewOKR.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [PlanviewOKR.m line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L19) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [PlanviewOKR.m line 22](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L22) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [PlanviewOKR.m line 173](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L173) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [PlanviewOKR.m line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L14) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
