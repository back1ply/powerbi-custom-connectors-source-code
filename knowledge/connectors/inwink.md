---
type: Power Query Connector
title: inwink
description: Connect to inwink
tags: [diagnostics, errors, navigation, oauth2, packaging, pagination, response-metadata, schema]
publisher: inwink
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm
  title: auth.startlogin.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq
  title: inwink.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/inwink/1.0.0/inwink_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| inwink | 1.0.0 | Not declared |

# Source files

* [auth.startlogin.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm)
* [inwink.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [inwink.pq line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L92)
* [Navigation tables and connection checks](../patterns/navigation.md): [inwink.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L22)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [auth.startlogin.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm#L25)
* [Page generation and cursor traversal](../patterns/pagination.md): [inwink.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L364)
* [Resources and modular source loading](../patterns/packaging.md): [inwink.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L38)
* [Response and pagination metadata](../patterns/response-metadata.md): [inwink.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L367)
* [Schema and type enforcement](../patterns/schema.md): [inwink.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L50)
* [Structured errors and HTTP status handling](../patterns/errors.md): [auth.startlogin.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm#L21)
