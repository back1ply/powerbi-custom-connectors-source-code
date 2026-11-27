---
type: Power Query Connector
title: Data Virtuality LDW
description: Connect to Data Virtuality LDW
tags: [usernamepassword]
x-pqkb-publisher: Data Virtuality
x-pqkb-version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m
  title: DataVirtuality.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DataVirtuality/3.0.1/DataVirtuality_3.0.1.pqx
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
| Data Virtuality | 3.0.1 | UsernamePassword |

# Source files

* [DataVirtuality.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [DataVirtuality.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [DataVirtuality.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [DataVirtuality.m line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L13) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for DataVirtuality. [DataVirtuality.m line 205](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L205) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: DataVirtuality.Database. [DataVirtuality.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [DataVirtuality.m line 232](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L232) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [DataVirtuality.m line 235](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L235) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [DataVirtuality.m line 53](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L53) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [DataVirtuality.m line 25](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L25) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [DataVirtuality.m line 42](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L42) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [DataVirtuality.m line 244](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L244) |
