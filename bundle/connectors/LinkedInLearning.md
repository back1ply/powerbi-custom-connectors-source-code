---
type: Power Query Connector
title: LinkedInLearning
description: Connect to LinkedInLearning
tags: [usernamepassword]
x-pqkb-publisher: LinkedInLearning
x-pqkb-version: 1.0.10
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq
  title: LinkedInLearning.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LinkedInLearning/1.0.10/LinkedInLearning_1.0.10.pqx
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
| LinkedInLearning | 1.0.10 | UsernamePassword |

# Source files

* [LinkedInLearning.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [LinkedInLearning.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [LinkedInLearning.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for LinkedInLearning. [LinkedInLearning.pq line 383](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L383) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: LinkedInLearning.Contents. [LinkedInLearning.pq line 354](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L354) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [LinkedInLearning.pq line 398](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L398) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [LinkedInLearning.pq line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L4) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [LinkedInLearning.pq line 359](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/LinkedInLearning/LinkedInLearning.pq#L359) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
