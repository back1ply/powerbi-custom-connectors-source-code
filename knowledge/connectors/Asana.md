---
type: Power Query Connector
title: Asana
description: Connect to Asana
tags: [credentials, errors, navigation, oauth, oauth2, packaging, pkce, schema, table-view, web-requests]
publisher: Asana
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m
  title: Asana.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Asana/1.0.2/Asana_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Asana | 1.0.2 | OAuth |

# Source files

* [Asana.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Table.ToNavigationTable.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Asana.m line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L194)
* [Navigation tables and connection checks](../patterns/navigation.md): [Asana.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L32)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Asana.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L85)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Asana.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L117)
* [Resources and modular source loading](../patterns/packaging.md): [Asana.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L4)
* [Schema and type enforcement](../patterns/schema.md): [Asana.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L12), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Asana.m line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L136)
* [Table.View handlers](../patterns/table-view.md): [Asana.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L39)
* [Web requests and relative paths](../patterns/web-requests.md): [Asana.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L182)
