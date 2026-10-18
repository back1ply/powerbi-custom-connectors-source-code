---
type: Power Query Connector
title: Bloomberg
description: Power BI connector source for Bloomberg.
tags: [buffering, diagnostics, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, table-view]
publisher: Bloomberg
version: 2.0.12
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm
  title: Auth.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m
  title: Bloomberg.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Configuration.pqm
  title: Configuration.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm
  title: Data-Handler.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm
  title: Folding.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/JWT.pqm
  title: JWT.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm
  title: Utils.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bloomberg/2.0.12/Bloomberg_2.0.12.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Bloomberg | 2.0.12 | OAuth |

# Source files

* [Auth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm)
* [Bloomberg.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m)
* [Configuration.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Configuration.pqm)
* [Data-Handler.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm)
* [Folding.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm)
* [JWT.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/JWT.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Folding.pqm line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L216)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm#L13)
* [Navigation tables and connection checks](../patterns/navigation.md): [Bloomberg.m line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L141), [Utils.pqm line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L296)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Auth.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L83), [Bloomberg.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L38)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Auth.pqm line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L91)
* [Resources and modular source loading](../patterns/packaging.md): [Auth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L4), [Bloomberg.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L21), [Data-Handler.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L4), [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm#L4), [Folding.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L4), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L4)
* [Response and pagination metadata](../patterns/response-metadata.md): [Data-Handler.pqm line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L164)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Data-Handler.pqm line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L70), [Utils.pqm line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L111)
* [Schema and type enforcement](../patterns/schema.md): [Bloomberg.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L7), [Utils.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L50)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Auth.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L28), [Bloomberg.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L102), [Data-Handler.pqm line 298](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L298), [Utils.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L127)
* [Table.View handlers](../patterns/table-view.md): [Folding.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L37)
