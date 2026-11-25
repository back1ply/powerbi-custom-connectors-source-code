---
type: Power Query Connector
title: BIConnector
description: Import data from OBIEE Server.
tags: [credentials, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq
  title: BIConnector.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BIConnector/1.1.0/BIConnector_1.1.0.pqx
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
| Microsoft | 1.1.0 | UsernamePassword |

# Source files

* [BIConnector.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [BIConnector.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L19) — `Credential = Extension.CurrentCredential(),`
    * [BIConnector.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L22) — `UID = Credential[Username],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [BIConnector.pq line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L66) — `Documentation.FieldCaption = "Enter the ODBC Data Source Name(DSN)*",`
    * [BIConnector.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L12) — `shared BIConnector.Contents = Value.ReplaceType(BIConnector.ContentsX, BIConnector.ContentsType);`
    * [BIConnector.pq line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L70) — `CType = type function (dsnname as type_dsnname) as table`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [BIConnector.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L39) — `OdbcDataSource = Odbc.DataSource(ConnectionString, CommonOptions & [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [BIConnector.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BIConnector/BIConnector.pq#L98) — `ButtonText = {ModuleName, Extension.LoadString("ButtonHelp")},`
