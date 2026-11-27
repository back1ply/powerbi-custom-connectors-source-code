---
type: Power Query Connector
title: Automy Analytics
description: Obtain information on a process through a direct connection with AUTOMY
tags: [key]
x-pqkb-publisher: AceRoyalty
x-pqkb-version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq
  title: AutomyDataAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutomyDataAnalytics/1.2.1/AutomyDataAnalytics_1.2.1.pqx
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
| AceRoyalty | 1.2.1 | Key |

# Source files

* [AutomyDataAnalytics.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AutomyDataAnalytics.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AutomyDataAnalytics.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AutomyDataAnalytics. [AutomyDataAnalytics.pq line 415](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L415) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AutomyDataAnalytics.Contents. [AutomyDataAnalytics.pq line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AutomyDataAnalytics.pq line 426](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L426) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AutomyDataAnalytics.pq line 429](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L429) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AutomyDataAnalytics.pq line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L19) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AutomyDataAnalytics.pq line 15](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L15) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AutomyDataAnalytics.pq line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L10) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
