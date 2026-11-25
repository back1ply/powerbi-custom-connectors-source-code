---
type: Power Query Connector
title: QubolePresto
description: Connect to QubolePresto
tags: [credentials, diagnostics, implicit, odbc, packaging, schema]
x-pqkb-publisher: Qubole
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m
  title: QubolePresto.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QubolePresto/1.0.1/QubolePresto_1.0.1.pqx
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
| Qubole | 1.0.1 | Implicit |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/OdbcConstants.pqm)
* [QubolePresto.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [QubolePresto.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L92) — `Credential = Extension.CurrentCredential(),`
    * [QubolePresto.m line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L94) — `if (Credential[AuthenticationKind]? = "Implicit") then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value, delayed),`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [QubolePresto.m line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L190) — `OdbcDatasource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [QubolePresto.m line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L221) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/Diagnostics.pqm#L188) — `if base = type table then "table" else`
    * [QubolePresto.m line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/QubolePresto/QubolePresto.m#L145) — `Value.ReplaceType(toTable, Value.Type(types)),`
