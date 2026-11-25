---
type: Power Query Connector
title: OpenSearch Project
description: Connect to OpenSearch
tags: [credentials, errors, implicit, key, odbc, packaging, parameter-metadata, schema, usernamepassword]
x-pqkb-publisher: Amazon
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m
  title: OpenSearchProject.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OpenSearchProject/1.0.1/OpenSearchProject_1.0.1.pqx
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
| Amazon | 1.0.1 | Implicit, Key, UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OdbcConstants.pqm)
* [OpenSearchProject.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [OpenSearchProject.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L38) — `Credential = Extension.CurrentCredential(),`
    * [OpenSearchProject.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L39) — `AuthenticationMode = Credential[AuthenticationKind],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [OpenSearchProject.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L17) — `Documentation.FieldCaption = "Server",`
    * [OpenSearchProject.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L12) — `shared OpenSearchProject.Contents = Value.ReplaceType(OpenSearchProjectImpl, OpenSearchProjectType);`
    * [OpenSearchProject.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L15) — `OpenSearchProjectType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [OpenSearchProject.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L154) — `OdbcDatasource = Odbc.DataSource(FullConnectionString, OdbcOptions)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [OpenSearchProject.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L222) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [OpenSearchProject.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L12) — `shared OpenSearchProject.Contents = Value.ReplaceType(OpenSearchProjectImpl, OpenSearchProjectType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [OpenSearchProject.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L174) — `error Error.Record("DataSource.Error", "The OpenSearch SQL ODBC driver is not installed. Please install the driver")`
    * [OpenSearchProject.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OpenSearchProject/OpenSearchProject.m#L174) — `error Error.Record("DataSource.Error", "The OpenSearch SQL ODBC driver is not installed. Please install the driver")`
