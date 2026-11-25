---
type: Power Query Connector
title: Bitsight Security Ratings
description: Power BI connector source for Bitsight Security Ratings.
tags: [key, navigation, packaging, schema, web-requests]
x-pqkb-publisher: BitSight
x-pqkb-version: 4.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq
  title: BitSightSecurityRatings.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/BitSightSecurityRatings/4.1.0/BitSightSecurityRatings_4.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| BitSight | 4.1.0 | Key |

# Source files

* [BitSightSecurityRatings.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [BitSightSecurityRatings.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L21) — `apiKey = Binary.ToText(Text.ToBinary(Extension.CurrentCredential()[Key] & ":"), BinaryEncoding.Base64);`
    * [BitSightSecurityRatings.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L21) — `apiKey = Binary.ToText(Text.ToBinary(Extension.CurrentCredential()[Key] & ":"), BinaryEncoding.Base64);`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [BitSightSecurityRatings.pq line 611](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L611) — `BitsightSecurityRatingsAPITable = Table.ToNavigationTable(BitsightSecurityRatingsAPIItems,{"Key"},"Name","Data","ItemKind","ItemName","IsLeaf"),`
    * [BitSightSecurityRatings.pq line 2190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L2190) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [BitSightSecurityRatings.pq line 1816](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1816) — `Table.GenerateByPage((previous) =>`
    * [BitSightSecurityRatings.pq line 1821](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1821) — `page = if (nextLink <> null) then`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [BitSightSecurityRatings.pq line 569](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L569) — `KeyLabel = Extension.LoadString("TokenFormLabel"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [BitSightSecurityRatings.pq line 1819](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1819) — `nextLink = if (previous = null) then url else Value.Metadata(previous)[NextLink]?,`
    * [BitSightSecurityRatings.pq line 890](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L890) — `source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders ]),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [BitSightSecurityRatings.pq line 894](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L894) — `withSchema = if (schema <> null) then SchemaTransformTable(company_details, schema) else company_details,`
    * [BitSightSecurityRatings.pq line 643](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L643) — `withData =  Table.AddColumn(rename, "Data", each GetEntity([url], [endpoint], [flag], company_guid, [Name], affects_rating_findings), type table),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [BitSightSecurityRatings.pq line 890](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L890) — `source = Web.Contents(url & company_guid, [ Headers = DefaultRequestHeaders ]),`
