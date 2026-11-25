---
type: Power Query Connector
title: Vessel Insight
description: Connect to Vessel Insight
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, schema, web-requests]
x-pqkb-publisher: Kognitwin
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm
  title: Documentation.galoreCustomDataQueryType.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm
  title: Documentation.galoreEdgeDataQueryType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm
  title: Documentation.voyage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm
  title: Documentation.voyageAis.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm
  title: Documentation.voyageHistory.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.createNavTableDataRow.pqm
  title: Table.createNavTableDataRow.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm
  title: Util.convertNumericTimestampToDateTime.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm
  title: VIAuth.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm
  title: VIServices.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m
  title: VesselInsight.m
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm
  title: VoyageServices.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/VesselInsight/1.0.6/VesselInsight_1.0.6.pqx
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
| Kognitwin | 1.0.6 | OAuth |

# Source files

* [Documentation.galoreCustomDataQueryType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm)
* [Documentation.galoreEdgeDataQueryType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm)
* [Documentation.voyage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm)
* [Documentation.voyageAis.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm)
* [Documentation.voyageHistory.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm)
* [Table.createNavTableDataRow.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.createNavTableDataRow.pqm)
* [Util.convertNumericTimestampToDateTime.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm)
* [VIAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm)
* [VIServices.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm)
* [VesselInsight.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m)
* [VoyageServices.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Documentation.galoreCustomDataQueryType.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm#L3) — `Documentation.FieldCaption = "TQL Query",`
    * [Documentation.galoreCustomDataQueryType.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm#L1) — `type function(`
    * [Documentation.galoreEdgeDataQueryType.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm#L3) — `Documentation.FieldCaption = "Interval",`
    * [Documentation.galoreEdgeDataQueryType.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm#L1) — `type function(`
    * [Documentation.voyage.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm#L3) — `Documentation.FieldCaption = "Comma separated IMOs",`
    * [Documentation.voyage.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm#L1) — `type function(`
    * [Documentation.voyageAis.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm#L3) — `Documentation.FieldCaption = "Location Code",`
    * [Documentation.voyageAis.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm#L1) — `type function(`
    * [Documentation.voyageHistory.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm#L3) — `Documentation.FieldCaption = "Comma Separated IMOs",`
    * [Documentation.voyageHistory.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm#L1) — `type function(`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [VesselInsight.m line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L93) — `functionReturnExplained = Value.ReplaceType(functionReturn, galoreCustomDataQueryType)`
    * [VoyageServices.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L64) — `functionResponse = Value.ReplaceType(functionReturn, voyageIMOType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
    * [VesselInsight.m line 408](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L408) — `navtableResult = Table.ToNavigationTable(`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [VIAuth.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L13) — `VIAuth.StartLogin = (resourceUrl, state, display) =>`
    * [VIAuth.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L45) — `VIAuth.FinishLogin = (context, callbackUri, state) =>`
    * [VIAuth.pqm line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L81) — `grant_type = grantType,`
    * [VIAuth.pqm line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L93) — `tokenResponse = Web.Contents(tokenEndpointUrl, [`
    * [VIServices.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L23) — `views = Json.Document(Web.Contents(assetViewUrl, [Headers = headers])),`
    * [VesselInsight.m line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L431) — `OAuth = [`
    * [VesselInsight.m line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L432) — `StartLogin = VIAuth.StartLogin,`
    * [VesselInsight.m line 433](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L433) — `FinishLogin = VIAuth.FinishLogin,`
    * [VoyageServices.pqm line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L43) — `Web.Contents(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Uncertain match (older review)**
    * [VIAuth.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L31) — `code_challenge = codeChallenge,     // the code_challenge`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [VIAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L3) — `config = Json.Document( Extension.Contents( "config.json") ),`
    * [VIServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L2) — `config = Json.Document(Extension.Contents("config.json")),`
    * [VesselInsight.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L22) — `Extension.LoadString("TreeNodeGaloreDataLabel"), "Galore_Data_Root", dataNodesRootTable, "Folder", false`
    * [VoyageServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L2) — `config = Json.Document(Extension.Contents("config.json")),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [VIServices.pqm line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L150) — `FinalTable = Table.TransformColumnTypes(tableText, typeTransformations),`
    * [VesselInsight.m line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L93) — `functionReturnExplained = Value.ReplaceType(functionReturn, galoreCustomDataQueryType)`
    * [VoyageServices.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L64) — `functionResponse = Value.ReplaceType(functionReturn, voyageIMOType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [VIAuth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L56) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [VIAuth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L56) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [VIServices.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L76) — `{Error.Record("Transformation Failed - " & firstNode[attributes][legacyNodeId])}`
    * [VIServices.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L44) — `initialResponse = try Web.Contents(galoreUrl, [Headers = headers]) otherwise null,`
    * [VesselInsight.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L135) — `Error.Record(`
    * [VesselInsight.m line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L134) — `error`
    * [VoyageServices.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L22) — `Error.Record(`
    * [VoyageServices.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L13) — `validateText = try VoyageServices.ValidateInput(commaSeparatedIMOs, {"0".."9", ","}),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [VIAuth.pqm line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L93) — `tokenResponse = Web.Contents(tokenEndpointUrl, [`
    * [VIServices.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L23) — `views = Json.Document(Web.Contents(assetViewUrl, [Headers = headers])),`
    * [VoyageServices.pqm line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm#L43) — `Web.Contents(`
