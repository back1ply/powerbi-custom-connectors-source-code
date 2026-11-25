---
type: Power Query Connector
title: Shortcuts Business Insights
description: Connect to Shortcuts Business Insights
tags: [credentials, hmac, key, packaging, web-requests]
x-pqkb-publisher: Shortcuts
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm
  title: Function.ExtractCommunityID.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetAccessCode.pqm
  title: Function.GetAccessCode.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm
  title: Function.GetData.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm
  title: Function.OAuthSignatureGenerator.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm
  title: Function.RandomStringGenerator.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.TimestampGenerator.pqm
  title: Function.TimestampGenerator.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq
  title: ShortcutsBI.pq
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ShortcutsBI/1.0.0/ShortcutsBI_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-02T11:27:27Z'
stale_after: '2026-11-16T11:27:27Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Shortcuts | 1.0.0 | Key |

# Source files

* [Function.ExtractCommunityID.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm)
* [Function.GetAccessCode.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetAccessCode.pqm)
* [Function.GetData.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm)
* [Function.OAuthSignatureGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm)
* [Function.RandomStringGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm)
* [Function.TimestampGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.TimestampGenerator.pqm)
* [ShortcutsBI.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [ShortcutsBI.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L30) — `powerBiKey = Extension.CurrentCredential()[Key],`
    * [ShortcutsBI.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L30) — `powerBiKey = Extension.CurrentCredential()[Key],`
* [HMAC request signing](../patterns/hmac.md)
  * **Match from a review of older source**
    * [Function.OAuthSignatureGenerator.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm#L16) — `signature = Crypto.CreateHmac(CryptoAlgorithm.SHA1, Text.ToBinary(signatureKey,BinaryEncoding.Base64), Text.ToBinary(baseString,BinaryEncoding.Base64)),`
    * [Function.OAuthSignatureGenerator.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm#L17) — `oauthSignature = Uri.EscapeDataString(Binary.ToText(signature,BinaryEncoding.Base64))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ShortcutsBI.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L7) — `binary = Extension.Contents(name),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Function.GetData.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm#L18) — `changeType = Table.TransformColumnTypes(pageTable,{{"Column1", type text}}),`
    * [Table.ToNavigationTable.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm#L23) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Function.GetAccessCode.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetAccessCode.pqm#L21) — `Auth = Json.Document(Web.Contents(`
    * [Function.GetData.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm#L29) — `siteData = Json.Document(Web.Contents(`
    * [Function.GetData.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm#L34) — `RelativePath=endpoint,`
