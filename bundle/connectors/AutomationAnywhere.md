---
type: Power Query Connector
title: AutomationAnywhere
description: Connect to Automation Anywhere
tags: [usernamepassword]
x-pqkb-publisher: Automation Anywhere
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m
  title: AutomationAnywhere.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutomationAnywhere/1.0.4/AutomationAnywhere_1.0.4.pqx
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
| Automation Anywhere | 1.0.4 | UsernamePassword |

# Source files

* [AutomationAnywhere.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AutomationAnywhere.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AutomationAnywhere.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AutomationAnywhere.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L12) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AutomationAnywhere. [AutomationAnywhere.m line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L124) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AutomationAnywhere.Feed. [AutomationAnywhere.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AutomationAnywhere.m line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L141) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AutomationAnywhere.m line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L145) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AutomationAnywhere.m line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L157) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AutomationAnywhere.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L15) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AutomationAnywhere.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L34) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
