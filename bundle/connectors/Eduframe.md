---
type: Power Query Connector
title: Eduframe
description: Power BI connector source for Eduframe.
tags: [key, oauth]
x-pqkb-publisher: Eduframe
x-pqkb-version: 2.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq
  title: EduFrame.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm
  title: Requests.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Eduframe/2.4.0/Eduframe_2.4.0.pqx
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
| Eduframe | 2.4.0 | Key, OAuth |

# Source files

* [EduFrame.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq)
* [Requests.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [EduFrame.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [EduFrame.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [EduFrame.pq line 129](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L129) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for EduFrame. [EduFrame.pq line 343](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L343) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: EduFrame.Contents. [EduFrame.pq line 18](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L18) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [EduFrame.pq line 367](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L367) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [EduFrame.pq line 370](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L370) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [EduFrame.pq line 149](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L149) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [EduFrame.pq line 129](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L129) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Requests.pqm line 29](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/Requests.pqm#L29) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [EduFrame.pq line 283](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Eduframe/EduFrame.pq#L283) |
