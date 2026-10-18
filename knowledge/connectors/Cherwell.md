---
type: Power Query Connector
title: Cherwell
description: Connect to Cherwell Service Management
tags: [errors, navigation, oauth, oauth2, packaging, response-metadata, schema]
publisher: Cherwell
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Auth.RequestToken.pqm
  title: Auth.RequestToken.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m
  title: Cherwell.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Uri.ValidateUrlScheme.pqm
  title: Uri.ValidateUrlScheme.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cherwell/1.0.0/Cherwell_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Cherwell | 1.0.0 | OAuth |

# Source files

* [Auth.RequestToken.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Auth.RequestToken.pqm)
* [Cherwell.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Table.ToNavigationTable.pqm)
* [Uri.ValidateUrlScheme.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Uri.ValidateUrlScheme.pqm)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [Cherwell.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L8)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Cherwell.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L15)
* [Resources and modular source loading](../patterns/packaging.md): [Cherwell.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L26)
* [Response and pagination metadata](../patterns/response-metadata.md): [Cherwell.m line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L165)
* [Schema and type enforcement](../patterns/schema.md): [Cherwell.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L5), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Auth.RequestToken.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Auth.RequestToken.pqm#L38)
