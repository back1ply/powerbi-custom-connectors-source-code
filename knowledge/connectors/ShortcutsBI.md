---
type: Power Query Connector
title: Shortcuts Business Insights
description: Connect to Shortcuts Business Insights
tags: [credentials, hmac, key, navigation, packaging, schema, web-requests]
publisher: Shortcuts
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm
  title: Function.ExtractCommunityID.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetAccessCode.pqm
  title: Function.GetAccessCode.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetData.pqm
  title: Function.GetData.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm
  title: Function.OAuthSignatureGenerator.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm
  title: Function.RandomStringGenerator.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.TimestampGenerator.pqm
  title: Function.TimestampGenerator.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq
  title: ShortcutsBI.pq
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ShortcutsBI/1.0.0/ShortcutsBI_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Shortcuts | 1.0.0 | Key |

# Source files

* [Function.ExtractCommunityID.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm)
* [Function.GetAccessCode.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetAccessCode.pqm)
* [Function.GetData.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetData.pqm)
* [Function.OAuthSignatureGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm)
* [Function.RandomStringGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm)
* [Function.TimestampGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.TimestampGenerator.pqm)
* [ShortcutsBI.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Table.ToNavigationTable.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [ShortcutsBI.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L30)
* [HMAC request signing](../patterns/hmac.md): [Function.OAuthSignatureGenerator.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm#L16)
* [Navigation tables and connection checks](../patterns/navigation.md): [ShortcutsBI.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L88)
* [Resources and modular source loading](../patterns/packaging.md): [ShortcutsBI.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L7)
* [Schema and type enforcement](../patterns/schema.md): [Table.ToNavigationTable.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Table.ToNavigationTable.pqm#L23)
* [Web requests and relative paths](../patterns/web-requests.md): [Function.GetData.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetData.pqm#L34)
