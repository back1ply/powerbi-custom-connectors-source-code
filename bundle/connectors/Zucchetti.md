---
type: Power Query Connector
title: Zucchetti
description: Power BI connector source for Zucchetti.
tags: [navigation, packaging, parameter-metadata, schema, usernamepassword, web-requests]
x-pqkb-publisher: Zuchetti
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m
  title: Zucchetti.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Zucchetti/1.0.1/Zucchetti_1.0.1.pqx
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
| Zuchetti | 1.0.1 | UsernamePassword |

# Source files

* [Zucchetti.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Zucchetti.m line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L83) — `Documentation.FieldCaption = "URL",`
    * [Zucchetti.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L9) — `shared Zucchetti.Contents =  Value.ReplaceType(ZucchettiImpl, ZucchettiType);`
    * [Zucchetti.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L81) — `ZucchettiType = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Zucchetti.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L21) — `NavTable = Table.ToNavigationTable(addLeaf,  {"idproced"}, "dsproced", "Data", "ItemKind", "ItemKind", "IsLeaf")`
    * [Zucchetti.m line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L113) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Zucchetti.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L60) — `Label = Extension.LoadString("Title")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Zucchetti.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L9) — `shared Zucchetti.Contents =  Value.ReplaceType(ZucchettiImpl, ZucchettiType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Zucchetti.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L13) — `Origine = Csv.Document(Web.Contents(_url, [Headers=[Accept="text/html"], RelativePath="servlet/PBIConnector?queryToEx=ConnectorList&template=ConnectorList&env="& Environment &""]),[Delimiter=",", Columns=5, Encoding=TextEncoding.Utf8, QuoteStyle=QuoteStyle.None]),`
    * [Zucchetti.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L13) — `Origine = Csv.Document(Web.Contents(_url, [Headers=[Accept="text/html"], RelativePath="servlet/PBIConnector?queryToEx=ConnectorList&template=ConnectorList&env="& Environment &""]),[Delimiter=",", Columns=5, Encoding=TextEncoding.Utf8, QuoteStyle=QuoteStyle.None]),`
