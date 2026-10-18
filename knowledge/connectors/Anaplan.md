---
type: Power Query Connector
title: AnaplanConnector
description: Connect to AnaplanConnectorV2
tags: [buffering, credentials, diagnostics, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, usernamepassword, web-requests]
publisher: Anaplan
version: 2.9.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq
  title: Anaplan.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/TraceContext.pqm
  title: TraceContext.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Anaplan/2.9.0/Anaplan_2.9.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Anaplan | 2.9.0 | OAuth, UsernamePassword |

# Source files

* [Anaplan.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Diagnostics.pqm)
* [TraceContext.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/TraceContext.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Anaplan.pq line 172](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L172)
* [Credential access](../patterns/credentials.md): [Anaplan.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L81)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [Anaplan.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L219)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Anaplan.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L54)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Anaplan.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L68)
* [Resources and modular source loading](../patterns/packaging.md): [Anaplan.pq line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L234), [TraceContext.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/TraceContext.pqm#L21)
* [Response and pagination metadata](../patterns/response-metadata.md): [Anaplan.pq line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L173)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Anaplan.pq line 637](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L637)
* [Schema and type enforcement](../patterns/schema.md): [Anaplan.pq line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L287)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Anaplan.pq line 120](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L120)
* [Web requests and relative paths](../patterns/web-requests.md): [Anaplan.pq line 667](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L667)
