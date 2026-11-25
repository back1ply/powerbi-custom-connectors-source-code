---
type: Power Query Connector
title: Data Virtuality LDW
description: Connect to Data Virtuality LDW
tags: [credentials, errors, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Data Virtuality
x-pqkb-version: 3.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m
  title: DataVirtuality.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DataVirtuality/3.0.1/DataVirtuality_3.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Data Virtuality | 3.0.1 | UsernamePassword |

# Source files

* [DataVirtuality.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [DataVirtuality.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L42) — `Credential = Extension.CurrentCredential(),`
    * [DataVirtuality.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L47) — `UID = Credential[Username],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DataVirtuality.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L13) — `Documentation.FieldCaption = "Server",`
    * [DataVirtuality.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L8) — `shared DataVirtuality.Database = Value.ReplaceType(DataVirtualityImpl, DataVirtualityType);`
    * [DataVirtuality.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L11) — `DataVirtualityType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [DataVirtuality.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L53) — `OdbcDataSource = Odbc.DataSource(ConnectionString, Options & [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [DataVirtuality.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L25) — `Documentation.Name = Extension.LoadString("DataSourceLabel"),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DataVirtuality.m line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L150) — `error Error.Record(DataSourceMissingClientLibrary, Text.Format("The Data Virtuality ODBC Driver is not installed. Please download the installer from #{0} and install the driver.", { DriverDownloadUrl }),DriverDownloadUrl)`
    * [DataVirtuality.m line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/DataVirtuality/DataVirtuality.m#L144) — `error Extension.CredentialError(Credential.AccessDenied, errorRecord[Message])`
