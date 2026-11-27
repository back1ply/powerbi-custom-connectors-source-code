---
type: Power Query Connector
title: BIConnector
description: Import data from OBIEE Server.
tags: [usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq
  title: BIConnector.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BIConnector/1.1.0/BIConnector_1.1.0.pqx
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
| Microsoft | 1.1.0 | UsernamePassword |

# Source files

* [BIConnector.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [BIConnector.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [BIConnector.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [BIConnector.pq line 66](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L66) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for BIConnector. [BIConnector.pq line 81](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L81) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function BIConnector.Contents (kind BIConnector) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [BIConnector.pq line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L11) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [BIConnector.pq line 101](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L101) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [BIConnector.pq line 99](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L99) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [BIConnector.pq line 39](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L39) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [BIConnector.pq line 98](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L98) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [BIConnector.pq line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L19) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
