---
type: Power Query Connector
title: ClickHouse Arrow Flight
description: Connect to ClickHouse over Arrow Flight SQL
tags: [usernamepassword]
x-pqkb-publisher: ClickHouse
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq
  title: ClickHouseArrowFlight.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm
  title: ClickHouseSqlGenerator.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/FlightSqlAdbcConfig.pqm
  title: FlightSqlAdbcConfig.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm
  title: TypeInfo.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ClickHouseArrowFlight/1.0.0/ClickHouseArrowFlight_1.0.0.pqx
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
| ClickHouse | 1.0.0 | UsernamePassword |

# Source files

* [ClickHouseArrowFlight.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq)
* [ClickHouseSqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseSqlGenerator.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/Diagnostics.pqm)
* [FlightSqlAdbcConfig.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/FlightSqlAdbcConfig.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/SqlGeneratorCommon.pqm)
* [TypeInfo.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/TypeInfo.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ClickHouseArrowFlight.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L7) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ClickHouseArrowFlight.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L6) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [ClickHouseArrowFlight.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L20) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ClickHouseArrowFlight. [ClickHouseArrowFlight.pq line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L73) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ClickHouseArrowFlight.Database, ClickHouseArrowFlight.ValidateConnection. [ClickHouseArrowFlight.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L15) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [ClickHouseArrowFlight.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L109) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ClickHouseArrowFlight.pq line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L114) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [ClickHouseArrowFlight.pq line 240](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L240) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ClickHouseArrowFlight.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L96) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [ClickHouseArrowFlight.pq line 412](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L412) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [ClickHouseArrowFlight.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L11) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [ClickHouseArrowFlight.pq line 200](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ClickHouseArrowFlight/ClickHouseArrowFlight.pq#L200) |
