---
type: Power Query Connector
title: Microsoft Graph Security
description: Connect to Microsoft Graph Security API
tags: [errors, navigation, oauth, oauth2, odata, packaging, schema]
publisher: Microsoft
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m
  title: MicrosoftGraphSecurity.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrosoftGraphSecurity/1.0.2/MicrosoftGraphSecurity_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | OAuth |

# Source files

* [MicrosoftGraphSecurity.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [MicrosoftGraphSecurity.m line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L73)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [MicrosoftGraphSecurity.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L130)
* [OData feeds](../patterns/odata.md): [MicrosoftGraphSecurity.m line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L112)
* [Resources and modular source loading](../patterns/packaging.md): [MicrosoftGraphSecurity.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L4)
* [Schema and type enforcement](../patterns/schema.md): [MicrosoftGraphSecurity.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L50), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [MicrosoftGraphSecurity.m line 223](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L223)
