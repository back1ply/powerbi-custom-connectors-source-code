---
type: Power Query Connector
title: FactSet RMS
description: Connect to FactSet RMS
tags: [navigation, packaging, schema, usernamepassword, web-requests]
x-pqkb-publisher: FactSet
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m
  title: FactSetRMS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetRMS/1.1.0/FactSetRMS_1.1.0.pqx
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
| FactSet | 1.1.0 | UsernamePassword |

# Source files

* [FactSetRMS.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m)

# Pattern evidence

* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [FactSetRMS.m line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L63) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [FactSetRMS.m line 612](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L612) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [FactSetRMS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L14) — `Label = Extension.LoadString("APIKeyAuthenticationLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [FactSetRMS.m line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L224) — `FactSetRMS.GetNotes = Value.ReplaceType(GetNotesImpl, GetNotesType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [FactSetRMS.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetRMS/FactSetRMS.m#L66) — `Record.ToTable(Json.Document(Text.FromBinary(Web.Contents(API_HOST & "group", [Headers = headers]))))`
