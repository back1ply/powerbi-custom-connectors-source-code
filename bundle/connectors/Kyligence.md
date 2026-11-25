---
type: Power Query Connector
title: KylinDirectQuery
description: Connect to KylinDirectQuery
tags: [diagnostics, odbc, packaging, parameter-metadata, schema, usernamepassword]
x-pqkb-publisher: Kyligence
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m
  title: Kyligence.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kyligence/1.0.5/Kyligence_1.0.5.pqx
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
| Kyligence | 1.0.5 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm)
* [Kyligence.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Kyligence.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L13) — `Documentation.FieldCaption = "Server",`
    * [Kyligence.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L9) — `shared Kyligence.Database = Value.ReplaceType(KyligenceImpl, KyligenceType);`
    * [Kyligence.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L11) — `KyligenceType = type function (`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Kyligence.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L44) — `OdbcDataSource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Kyligence.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L126) — `Icon16 = { Extension.Contents("Kyligence16.png"), Extension.Contents("Kyligence20.png"), Extension.Contents("Kyligence24.png"), Extension.Contents("Kyligence32.png") },`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [Kyligence.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kyligence/Kyligence.m#L9) — `shared Kyligence.Database = Value.ReplaceType(KyligenceImpl, KyligenceType);`
