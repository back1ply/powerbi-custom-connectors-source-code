---
type: Power Query Connector
title: Entersoft Business Suite
description: Connect to Entersoft Business Suite
tags: [oauth]
x-pqkb-publisher: Entersoft
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m
  title: Entersoft_Business_Suite.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/EntersoftBusinessSuite/1.0.0/EntersoftBusinessSuite_1.0.0.pqx
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
| Entersoft | 1.0.0 | OAuth |

# Source files

* [Entersoft_Business_Suite.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Entersoft_Business_Suite.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Entersoft_Business_Suite.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L2) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for EntersoftBusinessSuite. [Entersoft_Business_Suite.m line 274](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L274) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: EntersoftBusinessSuite.Contents. [Entersoft_Business_Suite.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L13) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Entersoft_Business_Suite.m line 328](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L328) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Entersoft_Business_Suite.m line 332](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L332) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Entersoft_Business_Suite.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L44) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Entersoft_Business_Suite.m line 281](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L281) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Entersoft_Business_Suite.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L130) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
