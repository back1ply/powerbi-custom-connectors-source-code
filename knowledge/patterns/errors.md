---
type: Power Query Pattern
title: Structured errors and HTTP status handling
description: Explicit API errors and the limits of handled-status branches.
category: Schema and errors
tags: [schema-and-errors]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: ['\b(?:Error\.Record\s*\(|ManualStatusHandling\s*=)']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L134
  title: Asana/Asana.m
---

**Draft: awaiting human review.**

# Mechanism

Asana's login callback parses the callback query and checks for both `error` and `error_description` fields. When the check succeeds it raises `Error.Record` with the provider's fields and the parsed record; otherwise it accesses `parts[code]` and calls `TokenMethod`. The token response is checked using a similar two-field condition.[^example]

`TokenMethod` manually handles HTTP 400 and parses its JSON body before making that decision. `GetTasks` handles 403 separately and raises an error when its parsed response is a record containing the expected error fields. Those status lists and response-shape checks belong to different calls in the same connector.[^example]

# Adaptation and failure paths

Read the condition as written: a response containing only one of the expected fields does not satisfy the two-field check. In the callback that can lead to the subsequent code-field access instead of the intended provider error. Include incomplete error payloads in a new connector's response-contract tests rather than treating the presence of `Error.Record` as complete coverage.[^example]

Do not turn all unexpected payloads into an empty result. Decide whether an error should request fresh credentials, explain a service failure, or stop parsing a malformed response. Keep any diagnostic details useful while excluding tokens and credential values from surfaced messages.

See [web-request failure handling](web-requests.md), [GraphQL errors](graphql.md), and [diagnostics](diagnostics.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 134–145.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code], context)
    in
        result;

TokenMethod = (grantType, tokenField, code, context) =>
    let
        queryString = [
            grant_type = grantType,
```

[^example]: Asana/Asana.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **94** connectors in this archive.

* [Actian](../connectors/Actian.md): [Actian.m line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L127)
* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L20)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [AmazonOpenSearchService.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L174)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 120](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L120)
* [Asana](../connectors/Asana.md): [Asana.m line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L136)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L244)
* [AtScale cubes](../connectors/AtScale.md): [AtScale.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L103)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 106](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L106)
* [Automy Analytics](../connectors/AutomyDataAnalytics.md): [AutomyDataAnalytics.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L83)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [Table.ChangeType.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L32)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L190), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm#L27)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [AzureDeviceRegistry.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L214)
* [Azure HorizonDB Database](../connectors/AzureHorizonDB.md): [AzureHorizonDB.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L84)
* [Azure Database for PostgreSQL](../connectors/AzurePostgreSQL.md): [AzurePostgreSQL.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L84)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L94)
* [Solver](../connectors/BI360.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Table.ChangeType.pqm#L27)
* [Bloomberg](../connectors/Bloomberg.md): [Auth.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L28), [Bloomberg.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L102), [Data-Handler.pqm line 298](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L298), [Utils.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L127)
* [BQE CORE](../connectors/BQECore.md): [BQECore.pq line 2567](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L2567)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 82](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L82), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm#L27)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [CDataConnectCloudRest.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L30), [CDataConnectCloudRestV2.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L30)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L87)
* [Cherwell](../connectors/Cherwell.md): [Auth.RequestToken.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Auth.RequestToken.pqm#L38)
* [ClickHouse](../connectors/ClickHouse.md): [ClickHouseConnector.pq line 488](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L488)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L242)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L166)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L202)
* [CosmosDB](../connectors/CosmosDB.md): [CosmosDB.m line 410](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L410)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L186)
* [Azure Databricks](../connectors/Databricks.md): [AdvancedOptions.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm#L11), [Databricks.pq line 247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L247)
* [Data Virtuality LDW](../connectors/DataVirtuality.md): [DataVirtuality.m line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L150)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L49)
* [Denodo](../connectors/Denodo.md): [DenodoForPowerBI.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L75), [Validation.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Validation.pqm#L50)
* [Dremio](../connectors/Dremio.md): [Dremio.pq line 961](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L961), [DremioAdbcDataSource.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L15), [DremioAdbcOptions.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm#L45), [DremioOAuthDiscovery.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioOAuthDiscovery.pqm#L55)
* [Dynatrace_Grail_DQL](../connectors/DynatraceGrail.md): [DynatraceGrail.m line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L407)
* [Eduframe](../connectors/Eduframe.md): [Requests.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L17)
* [EQuIS](../connectors/EQuIS.md): [EQuIS.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L85)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [OAuth.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L54)
* [SQL database](../connectors/FabricSql.md): [FabricSql.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L242), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L124)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31), [api-factset-analytics-util.pqm line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L90), [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111), [request-long-running.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L59), [request-request.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm#L40), [util-oauth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L37)
* [FHIR](../connectors/Fhir.md): [Fhir.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L213), [Folding.pqm line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Folding.pqm#L146)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L89)
* [Funnel](../connectors/Funnel.md): [DataLoading.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L27), [NavigationTable.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L76)
* [Google Sheets](../connectors/GoogleSheets.md): [GoogleSheets.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L32)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L92), [OAuth.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L46), [ParametricFilter.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L83), [SelectList.pqm line 324](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L324), [UoM.pqm line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L123)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L123)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 383](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L383)
* [InformationGrid](../connectors/InformationGrid.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm#L27)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 103](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L103)
* [Intune Data Warehouse](../connectors/IntuneV2.md): [IntuneV2.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L59)
* [inwink](../connectors/inwink.md): [auth.startlogin.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm#L21)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L91)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L165)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 229](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L229)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [AuthHelpers.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L42), [kxkdbinsightsenterprise.pq line 353](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L353)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L147)
* [Lakehouse](../connectors/LakeHouse.md): [LakeHouse.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L192), [MDSync.pqm line 460](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L460), [SparkCompute.pqm line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkCompute.pqm#L411), [SparkComputeUtils.pqm line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkComputeUtils.pqm#L210), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.pqm#L124)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L105)
* [MarkLogic](../connectors/MarkLogicODBC.md): [MarkLogicODBC.m line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L139)
* [Microsoft Graph Security](../connectors/MicrosoftGraphSecurity.md): [MicrosoftGraphSecurity.m line 223](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L223)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1011)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [MongoDBAtlasODBC.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L17)
* [OneLake Files](../connectors/OneLakeFile.md): [OneLakeFile.pq line 177](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L177), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L124)
* [OneLakeSql](../connectors/OneLakeSql.md): [OneLakeSql.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L115), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L124)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 779](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L779)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [OpenSearchProject.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L174)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L222)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L155)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [PowerPlatformDataflows.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L249), [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L27), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L66), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L48)
* [ProductInsightsConnector](../connectors/ProductInsights.md): [ProductInsightsConnector.m line 530](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L530)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L39)
* [QubolePresto](../connectors/QubolePresto.md): [QubolePresto.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L105)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L45)
* [Samsara](../connectors/Samsara.md): [Samsara.Client.Depage.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Depage.pqm#L41), [Samsara.Client.ErrorTranslation.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.ErrorTranslation.pqm#L32), [Samsara.Client.Retry.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Retry.pqm#L45), [Samsara.Client.StartRun.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.StartRun.pqm#L20), [Samsara.Metrics.Timer.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Metrics.Timer.pqm#L17), [Samsara.Table.Discover.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Table.Discover.pqm#L8)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L162)
* [Siteimprove](../connectors/SiteImprove.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm#L27)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L34)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 148](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L148)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L493)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L218)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L162)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [SurveyMonkey.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L30)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L350)
* [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md): [TeamDesk.m line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L256)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm#L27)
* [Azure Time Series Insights](../connectors/TimeSeriesInsights.md): [TimeSeriesInsightsConnector.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L162)
* [Usercube](../connectors/Usercube.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm#L27), [Usercube.m line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L213)
* [Vena](../connectors/Vena.md): [Utils.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L42)
* [Vessel Insight](../connectors/VesselInsight.md): [VIAuth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L56), [VIServices.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm#L76), [VesselInsight.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L135), [VoyageServices.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm#L22)
* [Warehouse](../connectors/Warehouse.md): [OutputInterceptor.pqm line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L110), [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L66), [Warehouse.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L314), [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L48), [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L124)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L136)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L27), [WorkplaceAnalytics.pq line 205](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L205)
* [Wrike](../connectors/Wrike.md): [wrike.m line 421](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L421)
* [ZendeskData](../connectors/ZendeskData.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm#L27)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L62)

<!-- seen-in:end -->
