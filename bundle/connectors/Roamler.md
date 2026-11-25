---
type: Power Query Connector
title: Roamler
description: Roamler
tags: [credentials, key, navigation, packaging, web-requests]
x-pqkb-publisher: Roamler
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m
  title: Roamler.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Roamler/1.0.0/Roamler_1.0.0.pqx
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
| Roamler | 1.0.0 | Key |

# Source files

* [Roamler.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Roamler.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L8) — `#"X-Roamler-Api-Key" = Extension.CurrentCredential()[Key],`
    * [Roamler.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L8) — `#"X-Roamler-Api-Key" = Extension.CurrentCredential()[Key],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Uncertain match (older review)**
    * [Roamler.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L135) — `Documentation.FieldCaption = "JobId",`
    * [Roamler.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L49) — `shared Roamler.Contents =  Value.ReplaceType(RoamlerNavTable, type function () as any);`
    * [Roamler.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L49) — `shared Roamler.Contents =  Value.ReplaceType(RoamlerNavTable, type function () as any);`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Roamler.m line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L74) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Roamler.m line 357](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L357) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Roamler.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L18) — `Label = Extension.LoadString("DataSourceLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Roamler.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L49) — `shared Roamler.Contents =  Value.ReplaceType(RoamlerNavTable, type function () as any);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Roamler.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L53) — `source  = Web.Contents(CustomerApiUrl & path, [ Headers = DefaultRequestHeaders, ManualCredentials = true ]),`
