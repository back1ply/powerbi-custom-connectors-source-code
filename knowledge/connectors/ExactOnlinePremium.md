---
type: Power Query Connector
title: Exact Online Premium
description: Connect to Exact Online Premium
tags: [diagnostics, errors, navigation, oauth, oauth2, odbc, packaging, pkce, schema, web-requests]
publisher: ExactOnlinePremium
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m
  title: ExactOnlinePremium.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ExactOnlinePremium/1.0.1/ExactOnlinePremium_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ExactOnlinePremium | 1.0.1 | OAuth |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/Diagnostics.pqm)
* [ExactOnlinePremium.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [ExactOnlinePremium.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L119)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [ExactOnlinePremium.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L122), [OAuth.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L29)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [ExactOnlinePremium.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L108)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [OAuth.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L38)
* [Resources and modular source loading](../patterns/packaging.md): [ExactOnlinePremium.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L9), [OAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L3)
* [Schema and type enforcement](../patterns/schema.md): [ExactOnlinePremium.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L13)
* [Structured errors and HTTP status handling](../patterns/errors.md): [OAuth.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L54)
* [Web requests and relative paths](../patterns/web-requests.md): [ExactOnlinePremium.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L26)
