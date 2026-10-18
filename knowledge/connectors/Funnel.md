---
type: Power Query Connector
title: Funnel
description: Power BI connector source for Funnel.
tags: [credentials, errors, navigation, oauth, oauth2, packaging, response-metadata, schema]
publisher: Funnel
version: 5.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm
  title: DataLoading.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq
  title: Funnel.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm
  title: NavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Funnel/5.0.1/Funnel_5.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Funnel | 5.0.1 | OAuth |

# Source files

* [DataLoading.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm)
* [Funnel.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq)
* [NavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [DataLoading.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L18)
* [Navigation tables and connection checks](../patterns/navigation.md): [Funnel.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L10), [NavigationTable.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L47)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Funnel.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L13), [OAuth.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm#L16)
* [Resources and modular source loading](../patterns/packaging.md): [DataLoading.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L10), [Funnel.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L16), [NavigationTable.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L4), [OAuth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm#L4)
* [Response and pagination metadata](../patterns/response-metadata.md): [DataLoading.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L29)
* [Schema and type enforcement](../patterns/schema.md): [DataLoading.pqm line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L119), [Funnel.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L5), [NavigationTable.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L51)
* [Structured errors and HTTP status handling](../patterns/errors.md): [DataLoading.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L27), [NavigationTable.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L76)
