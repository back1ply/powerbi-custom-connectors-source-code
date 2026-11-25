---
type: Power Query Connector
title: Wolters Kluwer CCH Tagetik
description: Connect to Wolters Kluwer CCH Tagetik
tags: [packaging, parameter-metadata, schema, usernamepassword]
x-pqkb-publisher: CCHTagetik
x-pqkb-version: 1.4.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq
  title: CCHTagetik.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CCHTagetik/1.4.2/CCHTagetik_1.4.2.pqx
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
| CCHTagetik | 1.4.2 | UsernamePassword |

# Source files

* [CCHTagetik.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [CCHTagetik.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L292) — `ClientId = Extension.CurrentCredential()[Username],`
    * [CCHTagetik.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L292) — `ClientId = Extension.CurrentCredential()[Username],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Uncertain match (older review)**
    * [CCHTagetik.pq line 1080](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L1080) — `then Diagnostics.Trace(TraceLevel.Error, "Environment not found. Please verify the input parameters provided.", () => error "Environment not found. Please verify the input parameters provided.", true)`
    * [CCHTagetik.pq line 1080](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L1080) — `then Diagnostics.Trace(TraceLevel.Error, "Environment not found. Please verify the input parameters provided.", () => error "Environment not found. Please verify the input parameters provided.", true)`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CCHTagetik.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L54) — `Documentation.FieldCaption = "URL",`
    * [CCHTagetik.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L50) — `shared CCHTagetik.Contents = Value.ReplaceType(CCHTagetikNavTable, CCHTagetikType);`
    * [CCHTagetik.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L52) — `CCHTagetikType =  type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Uncertain match (older review)**
    * [CCHTagetik.pq line 1074](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L1074) — `navTable = Table.ToNavigationTable(base, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),`
    * [CCHTagetik.pq line 7518](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L7518) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [CCHTagetik.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L21) — `Label =Extension.LoadString ("AuthenticationLabel")`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CCHTagetik.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L50) — `shared CCHTagetik.Contents = Value.ReplaceType(CCHTagetikNavTable, CCHTagetikType);`
    * [CCHTagetik.pq line 322](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L322) — `type table [`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [CCHTagetik.pq line 319](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L319) — `Table.View(null,`
    * [CCHTagetik.pq line 321](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L321) — `GetType = () =>`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [CCHTagetik.pq line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L299) — `Web.Contents(`
    * [CCHTagetik.pq line 328](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CCHTagetik/CCHTagetik.pq#L328) — `Source_PBIConnectorVersion = try Json.Document(Web.Contents(outputURL, [Headers = Credentials_Header,RelativePath="Datasource_AWT009()", Timeout=#duration(0,0,30,0)]))`
