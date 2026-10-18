---
type: Power Query Connector
title: Kyvos ODBC
description: Kyvos ODBC
tags: [credentials, diagnostics, errors, navigation, oauth, oauth2, odbc, packaging, pkce, schema, usernamepassword]
publisher: Kyvos
version: 1.0.8
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq
  title: KyvosODBC.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/KyvosODBC/1.0.8/KyvosODBC_1.0.8.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Kyvos | 1.0.8 | OAuth, UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/Diagnostics.pqm)
* [KyvosODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/OdbcConstants.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [KyvosODBC.pq line 399](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L399)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/Diagnostics.pqm#L3)
* [Navigation tables and connection checks](../patterns/navigation.md): [KyvosODBC.pq line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L287)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [KyvosODBC.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L138)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [KyvosODBC.pq line 517](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L517)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [KyvosODBC.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L175)
* [Resources and modular source loading](../patterns/packaging.md): [KyvosODBC.pq line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L309)
* [Schema and type enforcement](../patterns/schema.md): [KyvosODBC.pq line 377](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L377)
* [Structured errors and HTTP status handling](../patterns/errors.md): [KyvosODBC.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L147)
