---
type: Power Query Connector
title: Amazon OpenSearch Service
description: Connect to OpenSearch
tags: [credentials, errors, implicit, key, odbc, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Amazon
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m
  title: AmazonOpenSearchService.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonOpenSearchService/1.0.1/AmazonOpenSearchService_1.0.1.pqx
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

* [AmazonOpenSearchService.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AmazonOpenSearchService.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L38) — `Credential = Extension.CurrentCredential(),`
    * [AmazonOpenSearchService.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L39) — `AuthenticationMode = Credential[AuthenticationKind],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AmazonOpenSearchService.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L17) — `Documentation.FieldCaption = "Server",`
    * [AmazonOpenSearchService.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L12) — `shared AmazonOpenSearchService.Contents = Value.ReplaceType(AmazonOpenSearchServiceImpl, AmazonOpenSearchServiceType);`
    * [AmazonOpenSearchService.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L15) — `AmazonOpenSearchServiceType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [AmazonOpenSearchService.m line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L154) — `OdbcDatasource = Odbc.DataSource(FullConnectionString, OdbcOptions)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AmazonOpenSearchService.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L222) — `Label = Extension.LoadString("DataSourceLabel")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AmazonOpenSearchService.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L174) — `error Error.Record("DataSource.Error", "The OpenSearch SQL ODBC driver is not installed. Please install the driver")`
    * [AmazonOpenSearchService.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L174) — `error Error.Record("DataSource.Error", "The OpenSearch SQL ODBC driver is not installed. Please install the driver")`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
