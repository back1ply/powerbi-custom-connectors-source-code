---
type: Power Query Connector
title: JethroDataConnector
description: Connect to JethroDataConnector
tags: [credentials, odbc, packaging, usernamepassword]
x-pqkb-publisher: Jethro
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m
  title: JethroODBC.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JethroData/1.0.2/JethroData_1.0.2.pqx
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
| Jethro | 1.0.2 | UsernamePassword |

# Source files

* [JethroODBC.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [JethroODBC.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L27) — `Credential = Extension.CurrentCredential(),`
    * [JethroODBC.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L28) — `CredentialConnectionString = if Credential[AuthenticationKind]? = "UsernamePassword" then [`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [JethroODBC.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L38) — `OdbcDatasource = Odbc.DataSource(ConnectionString,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [JethroODBC.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JethroData1.0.1/JethroODBC.m#L122) — `ButtonText = { Extension.LoadString("UIButtonText"), Extension.LoadString("UIButtonHover")},`
