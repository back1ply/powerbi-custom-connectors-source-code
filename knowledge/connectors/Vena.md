---
type: Power Query Connector
title: Vena
description: Connect to Vena
tags: [buffering, credentials, errors, navigation, packaging, response-metadata, retry-polling, schema, usernamepassword, web-requests]
publisher: Vena
version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Main.pqm
  title: Main.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm
  title: Utils.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq
  title: Vena.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Vena/1.1.1/Vena_1.1.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Vena | 1.1.1 | UsernamePassword |

# Source files

* [Main.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Main.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm)
* [Vena.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Utils.pqm line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L108)
* [Credential access](../patterns/credentials.md): [Vena.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L52)
* [Navigation tables and connection checks](../patterns/navigation.md): [Main.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Main.pqm#L34), [Vena.pq line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L210)
* [Resources and modular source loading](../patterns/packaging.md): [Vena.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L63)
* [Response and pagination metadata](../patterns/response-metadata.md): [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L66), [Vena.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L142)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Utils.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L178)
* [Schema and type enforcement](../patterns/schema.md): [Utils.pqm line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L290), [Vena.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L14)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Utils.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L42)
* [Web requests and relative paths](../patterns/web-requests.md): [Vena.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L122)
