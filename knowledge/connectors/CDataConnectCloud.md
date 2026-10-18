---
type: Power Query Connector
title: CData Connect Cloud
description: Connect to CData Connect Cloud
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, pkce, schema, table-view]
publisher: CData
version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq
  title: CDataConnectCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm
  title: CDataConnectCloudRest.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm
  title: CDataConnectCloudRestV2.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm
  title: CDataConnectCloudService.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm
  title: CDataConnectCloudServiceV2.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm
  title: OAuth.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Utilities.pqm
  title: Utilities.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CDataConnectCloud/3.1.0/CDataConnectCloud_3.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| CData | 3.1.0 | OAuth |

# Source files

* [CDataConnectCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq)
* [CDataConnectCloudRest.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm)
* [CDataConnectCloudRestV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm)
* [CDataConnectCloudService.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm)
* [CDataConnectCloudServiceV2.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Diagnostics.pqm)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm)
* [Utilities.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Utilities.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Diagnostics.pqm#L3)
* [Navigation tables and connection checks](../patterns/navigation.md): [CDataConnectCloud.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L6)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [CDataConnectCloud.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L9), [CDataConnectCloudService.pqm line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L411), [CDataConnectCloudServiceV2.pqm line 499](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L499), [OAuth.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm#L19)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [OAuth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm#L37)
* [Resources and modular source loading](../patterns/packaging.md): [CDataConnectCloud.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L12), [CDataConnectCloudRest.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L8), [CDataConnectCloudRestV2.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L8), [CDataConnectCloudService.pqm line 381](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L381), [CDataConnectCloudServiceV2.pqm line 472](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L472)
* [Schema and type enforcement](../patterns/schema.md): [CDataConnectCloud.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L44), [Utilities.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Utilities.pqm#L20)
* [Structured errors and HTTP status handling](../patterns/errors.md): [CDataConnectCloudRest.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L30), [CDataConnectCloudRestV2.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L30)
* [Table.View handlers](../patterns/table-view.md): [CDataConnectCloudService.pqm line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L211), [CDataConnectCloudServiceV2.pqm line 301](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L301)
