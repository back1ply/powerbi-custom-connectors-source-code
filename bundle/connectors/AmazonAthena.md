---
type: Power Query Connector
title: AmazonAthena
description: Connect to Athena
tags: [aad, credentials, implicit, odbc, packaging, parameter-metadata]
x-pqkb-publisher: Amazon
x-pqkb-version: 1.2.8
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m
  title: AmazonAthena.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonAthena/1.2.8/AmazonAthena_1.2.8.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-02T11:27:27Z'
stale_after: '2026-11-16T11:27:27Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Amazon | 1.2.8 | Aad, Implicit |

# Source files

* [AmazonAthena.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AmazonAthena.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L53) — `Credential = Extension.CurrentCredential(),`
    * [AmazonAthena.m line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L54) — `AuthKind = Credential[AuthenticationKind],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AmazonAthena.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L23) — `Documentation.FieldCaption = "DSN",`
    * [AmazonAthena.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L18) — `shared AmazonAthena.Databases = Value.ReplaceType(AthenaImpl, AthenaType);`
    * [AmazonAthena.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L20) — `AthenaType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [AmazonAthena.m line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L124) — `Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AmazonAthena.m line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L76) — `error Extension.LoadString("MissingRoleError")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [AmazonAthena.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L18) — `shared AmazonAthena.Databases = Value.ReplaceType(AthenaImpl, AthenaType);`
