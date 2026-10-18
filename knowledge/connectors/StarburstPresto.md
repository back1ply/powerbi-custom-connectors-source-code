---
type: Power Query Connector
title: StarburstPresto
description: Power BI connector source for StarburstPresto.
tags: [aad, credentials, errors, key, navigation, oauth, oauth2, odbc, packaging, pkce, schema, usernamepassword, windows]
publisher: Starburst
version: 5.4.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq
  title: StarburstEnterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/StarburstPresto/5.4.4/StarburstPresto_5.4.4.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Starburst | 5.4.4 | Aad, Key, OAuth, UsernamePassword, Windows |

# Source files

* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/OdbcConstants.pqm)
* [StarburstEnterprise.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [StarburstEnterprise.pq line 196](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L196)
* [Navigation tables and connection checks](../patterns/navigation.md): [StarburstEnterprise.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L51)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [StarburstEnterprise.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L38)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [StarburstEnterprise.pq line 425](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L425)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [StarburstEnterprise.pq line 518](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L518)
* [Resources and modular source loading](../patterns/packaging.md): [StarburstEnterprise.pq line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L133)
* [Schema and type enforcement](../patterns/schema.md): [StarburstEnterprise.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L21)
* [Structured errors and HTTP status handling](../patterns/errors.md): [StarburstEnterprise.pq line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L493)
