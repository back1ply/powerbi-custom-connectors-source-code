---
type: Power Query Connector
title: Dremio
description: Import data from Dremio.
tags: [aad, anonymous, key, usernamepassword]
x-pqkb-publisher: Dremio
x-pqkb-version: 3.16.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/CACerts.pqm
  title: CACerts.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm
  title: DataTransform.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq
  title: Dremio.pq
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm
  title: DremioAdbcDataSource.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm
  title: DremioAdbcOptions.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm
  title: DremioOAuthDiscovery.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/FlightSqlAdbcConfig.pqm
  title: FlightSqlAdbcConfig.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm
  title: SqlGenerator.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Dremio/3.16.1/Dremio_3.16.1.pqx
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
| Dremio | 3.16.1 | Aad, Anonymous, Key, UsernamePassword |

# Source files

* [CACerts.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/CACerts.pqm)
* [DataTransform.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DataTransform.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Diagnostics.pqm)
* [Dremio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq)
* [DremioAdbcDataSource.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm)
* [DremioAdbcOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcOptions.pqm)
* [DremioOAuthDiscovery.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioOAuthDiscovery.pqm)
* [FlightSqlAdbcConfig.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/FlightSqlAdbcConfig.pqm)
* [SqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGenerator.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/SqlGeneratorCommon.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Dremio.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Dremio.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Dremio.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L180) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Dremio, DremioCloud, DremioTesting. [Dremio.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L47) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Dremio.Databases, Dremio.DatabasesV300, Dremio.DatabasesV370, DremioTesting.Contents, DremioCloud.Databases, DremioCloud.DatabasesByServer, DremioCloud.DatabasesByServerV330, DremioCloud.DatabasesByServerV360, DremioCloud.DatabasesByServerV370. [Dremio.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L17) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Dremio.pq line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L140) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [DremioAdbcDataSource.pqm line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/DremioAdbcDataSource.pqm#L395) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Dremio.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L72) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Dremio.pq line 320](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L320) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Dremio.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Dremio.pq line 985](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Dremio/Dremio.pq#L985) |
