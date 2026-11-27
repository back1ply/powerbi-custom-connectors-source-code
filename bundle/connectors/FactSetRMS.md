---
type: Power Query Connector
title: FactSet RMS
description: Connect to FactSet RMS
tags: [usernamepassword]
x-pqkb-publisher: FactSet
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m
  title: FactSetRMS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetRMS/1.1.0/FactSetRMS_1.1.0.pqx
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
| FactSet | 1.1.0 | UsernamePassword |

# Source files

* [FactSetRMS.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [FactSetRMS.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [FactSetRMS.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [FactSetRMS.m line 249](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L249) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for FactSetRMS. [FactSetRMS.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L8) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: FactSetRMS.Functions. [FactSetRMS.m line 35](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L35) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [FactSetRMS.m line 22](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L22) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [FactSetRMS.m line 26](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L26) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [FactSetRMS.m line 63](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L63) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [FactSetRMS.m line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L14) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
