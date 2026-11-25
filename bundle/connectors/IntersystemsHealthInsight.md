---
type: Power Query Connector
title: InterSystems Health Insight
description: Connect to InterSystems Health Insight
tags: [usernamepassword]
x-pqkb-publisher: IntersystemsHealthInsight
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq
  title: IntersystemsHealthInsight.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/IntersystemsHealthInsight/1.0.4/IntersystemsHealthInsight_1.0.4.pqx
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
| IntersystemsHealthInsight | 1.0.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/Diagnostics.pqm)
* [IntersystemsHealthInsight.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [IntersystemsHealthInsight.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [IntersystemsHealthInsight.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [IntersystemsHealthInsight.pq line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L42) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for IntersystemsHealthInsight. [IntersystemsHealthInsight.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L19) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: IntersystemsHealthInsight.Database. [IntersystemsHealthInsight.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L15) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [IntersystemsHealthInsight.pq line 198](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L198) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [IntersystemsHealthInsight.pq line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L188) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [IntersystemsHealthInsight.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L21) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [IntersystemsHealthInsight.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L93) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [IntersystemsHealthInsight.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L10) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [IntersystemsHealthInsight.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L290) |
