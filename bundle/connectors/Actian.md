---
type: Power Query Connector
title: Actian
description: Connect to Actian X Vector, Avalanche, or Ingres
tags: [credentials, diagnostics, errors, odbc, packaging, usernamepassword, windows]
x-pqkb-publisher: Actian
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m
  title: Actian.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Actian/1.0.1/Actian_1.0.1.pqx
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
| Actian | 1.0.1 | UsernamePassword, Windows |

# Source files

* [Actian.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/OdbcConstants.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Actian.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L117) — `Credential = Extension.CurrentCredential(),`
    * [Actian.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L119) — `if Credential[AuthenticationKind]? = "UsernamePassword" then`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Actian.m line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L218) — `OdbcDatasource = Odbc.DataSource(ConnectionString, [`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Actian.m line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L212) — `Contents = Text.FromBinary(Extension.Contents("DNS_List.txt")),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Actian.m line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L127) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [Actian.m line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Actian.m#L127) — `error Error.Record("Error", "Unhandled authentication kind: " & Credential[AuthenticationKind]?),`
    * [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Actian/Diagnostics.pqm#L2) — `Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),`
