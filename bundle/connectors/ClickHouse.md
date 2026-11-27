---
type: Power Query Connector
title: ClickHouse
description: Connect to ClickHouse
tags: [usernamepassword]
x-pqkb-publisher: ClickHouse
x-pqkb-version: 1.1.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq
  title: ClickHouseConnector.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ClickHouse/1.1.6/ClickHouse_1.1.6.pqx
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
| ClickHouse | 1.1.6 | UsernamePassword |

# Source files

* [ClickHouseConnector.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ClickHouseConnector.pq line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ClickHouseConnector.pq line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L5) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [ClickHouseConnector.pq line 130](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L130) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ClickHouse. [ClickHouseConnector.pq line 403](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L403) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ClickHouse.Database. [ClickHouseConnector.pq line 122](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L122) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [ClickHouseConnector.pq line 432](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L432) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ClickHouseConnector.pq line 437](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L437) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [ClickHouseConnector.pq line 367](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L367) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ClickHouseConnector.pq line 427](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L427) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [ClickHouseConnector.pq line 252](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L252) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [ClickHouseConnector.pq line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L13) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [ClickHouseConnector.pq line 637](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ClickHouse/ClickHouseConnector.pq#L637) |
