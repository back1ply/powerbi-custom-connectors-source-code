---
type: Power Query Connector
title: LEAP
description: Connect to LEAP
tags: [buffering, credentials, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, retry-polling, web-requests]
x-pqkb-publisher: LEAP
x-pqkb-version: 1.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m
  title: LEAP.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LEAP/1.3.0/LEAP_1.3.0.pqx
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
| LEAP | 1.3.0 | OAuth |

# Source files

* [LEAP.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [LEAP.m line 743](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L743) — `buffered = Binary.Buffer(result),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [LEAP.m line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L99) — `parts = Json.Document(Base64Url.Decode(Text.Split(Extension.CurrentCredential()[access_token], "."){1})),`
    * [LEAP.m line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L99) — `parts = Json.Document(Base64Url.Decode(Text.Split(Extension.CurrentCredential()[access_token], "."){1})),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [LEAP.m line 1504](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L1504) — `Documentation.FieldCaption = "LEAP: Endpoint",`
    * [LEAP.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L41) — `shared LEAP.Contents = Value.ReplaceType(LEAPNavTable, LEAPMetadataType);`
    * [LEAP.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L44) — `LEAPMetadataType = type function ()`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [LEAP.m line 253](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L253) — `navTable = Table.ToNavigationTable(table, {"Key"}, "Name" ,"Data", "ItemKind", "ItemName", "IsLeaf")`
    * [LEAP.m line 1546](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L1546) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [LEAP.m line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L74) — `OAuth = [`
    * [LEAP.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L75) — `StartLogin = StartLogin,`
    * [LEAP.m line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L76) — `FinishLogin = FinishLogin,`
    * [LEAP.m line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L204) — `grant_type = grantType,`
    * [LEAP.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L102) — `result = Web.Contents(baseUrl, [`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [LEAP.m line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L176) — `code_challenge = codeVerifier,`
    * [LEAP.m line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L197) — `codeVerifier =  [code_verifier = verifier],`
    * [LEAP.m line 1591](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L1591) — `S256.Encode = (s) => Binary.ToText(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(s, TextEncoding.Ascii)), BinaryEncoding.Base64);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [LEAP.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L47) — `Documentation.Description = Extension.LoadString("LEAPContentDescription"),`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [LEAP.m line 725](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L725) — `let waitForResult = Value.WaitFor(`
    * [LEAP.m line 750](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L750) — `(iteration) => #duration(0, 0, 0, Number.Power(10, iteration)),15)`
    * [LEAP.m line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L61) — `result = if path = "AgeingBalances" or path = "Balances" or path = "ArchivedBalances" or path = "InvoicedStaff" or path = "OfficeInvoices" or path = "AgedWIP" or path = "AgedDisbursements" or path = "AgedDebtors" or path = "StaffInvoicedFunds" or path = "StaffReceiptedFunds"`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [LEAP.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LEAP/LEAP.m#L102) — `result = Web.Contents(baseUrl, [`
