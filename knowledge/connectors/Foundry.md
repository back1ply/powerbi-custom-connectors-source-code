---
type: Power Query Connector
title: Palantir Foundry Datasets
description: Connect to Palantir Foundry datasets
tags: [credentials, errors, key, navigation, oauth, oauth2, odbc, packaging, pkce, schema, usernamepassword]
publisher: Palantir
version: 1.3.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m
  title: Foundry.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Foundry/1.3.1/Foundry_1.3.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Palantir | 1.3.1 | Key, OAuth, UsernamePassword |

# Source files

* [Foundry.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Foundry.m line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L95)
* [Navigation tables and connection checks](../patterns/navigation.md): [Foundry.m line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L113)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Foundry.m line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L259)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Foundry.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L65)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Foundry.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L270)
* [Resources and modular source loading](../patterns/packaging.md): [Foundry.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L11)
* [Schema and type enforcement](../patterns/schema.md): [Foundry.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Foundry.m line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L89)
