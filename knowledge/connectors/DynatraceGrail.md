---
type: Power Query Connector
title: Dynatrace_Grail_DQL
description: Connect to Dynatrace_Grail_DQL
tags: [errors, navigation, oauth, oauth2, packaging, pkce, schema]
publisher: Dynatrace
version: 1.0.7
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m
  title: DynatraceGrail.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/DynatraceGrail/1.0.7/DynatraceGrail_1.0.7.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Dynatrace | 1.0.7 | OAuth |

# Source files

* [DynatraceGrail.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [DynatraceGrail.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L101)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [DynatraceGrail.m line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L350)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [DynatraceGrail.m line 385](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L385)
* [Resources and modular source loading](../patterns/packaging.md): [DynatraceGrail.m line 445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L445)
* [Schema and type enforcement](../patterns/schema.md): [DynatraceGrail.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L88)
* [Structured errors and HTTP status handling](../patterns/errors.md): [DynatraceGrail.m line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L407)
