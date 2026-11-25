---
type: Power Query Connector
title: Linkar PICK Style / MultiValue Databases
description: Connect to PICK Style / MultiValue Databases
tags: [usernamepassword]
x-pqkb-publisher: Kosday Solutions
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq
  title: LinkarConnector.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Linkar/1.0.1/Linkar_1.0.1.pqx
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
| Kosday Solutions | 1.0.1 | UsernamePassword |

# Source files

* [LinkarConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [LinkarConnector.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [LinkarConnector.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [LinkarConnector.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L80) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Linkar. [LinkarConnector.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L13) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Linkar.Contents. [LinkarConnector.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [LinkarConnector.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L38) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [LinkarConnector.pq line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L42) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [LinkarConnector.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L54) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [LinkarConnector.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L32) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [LinkarConnector.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Linkar/LinkarConnector.pq#L155) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
