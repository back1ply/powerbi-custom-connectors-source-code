---
type: Power Query Connector
title: Exasol
description: Connect to Exasol
tags: [credentials, implicit, odbc, packaging, parameter-metadata, usernamepassword, windows]
x-pqkb-publisher: Exasol
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq
  title: Exasol.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Exasol/1.1.1/Exasol_1.1.1.pqx
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
| Exasol | 1.1.1 | Implicit, UsernamePassword, Windows |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Diagnostics.pqm)
* [Exasol.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Exasol.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L85) — `currentCredentials = Extension.CurrentCredential(),`
    * [Exasol.pq line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L86) — `authenticationKind = currentCredentials[AuthenticationKind],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Exasol.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L51) — `Documentation.FieldCaption = "Connection String",`
    * [Exasol.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L32) — `Value.ReplaceType(`
    * [Exasol.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L46) — `type function (server as`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [Exasol.pq line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L113) — `Odbc.DataSource(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Exasol.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Exasol/Exasol.pq#L78) — `Documentation.Icon = Extension.Contents("Exasol32.png")`
