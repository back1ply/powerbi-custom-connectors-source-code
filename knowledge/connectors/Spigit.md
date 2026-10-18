---
type: Power Query Connector
title: Planview IdeaPlace
description: Connect to Planview IdeaPlace
tags: [navigation, oauth, oauth2, odata, packaging, schema]
publisher: Planview
version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m
  title: Spigit.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Spigit/2.0.0/Spigit_2.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Planview | 2.0.0 | OAuth |

# Source files

* [Spigit.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Spigit.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L12)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Spigit.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L13)
* [OData feeds](../patterns/odata.md): [Spigit.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L132)
* [Resources and modular source loading](../patterns/packaging.md): [Spigit.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L14)
* [Schema and type enforcement](../patterns/schema.md): [Spigit.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L5)
