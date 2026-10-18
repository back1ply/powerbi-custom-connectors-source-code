---
type: Power Query Pattern
title: Response and pagination metadata
description: Pagination state versus HTTP response metadata.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bValue\.Metadata\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L54
  title: AzureResourceGraph/AzureResourceGraph.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: c5dbb335bd62c600687e6baf2aa408c92f0bc5489a3085e5430763cccb7c587d
  sources_sha256:
    example: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

AzureResourceGraph stores a continuation token on its returned table with `meta [SkipToken = nextSkipToken]`. The next page callback reads that field using `Value.Metadata(previous)[SkipToken]?`. For the first page it uses an empty string as the initial token; a null continuation token stops further page requests.[^example]

The same source uses `Value.Metadata(result)[Response.Status]` on a `Web.Contents` response inside `WaitForResult`. These are different metadata contracts: one is page state attached by the connector, while the other is status information read from a response. The presence of `Value.Metadata` alone does not identify HTTP-header handling.[^example]

# Adaptation and failure paths

Keep metadata attachment and retrieval together when studying a paging helper. If an intermediate transformation loses the table metadata, a later continuation read no longer has the state shown here. Inspect the final returned expression, including its `meta` suffix, instead of looking only at the table-building steps.[^example]

Distinguish a deliberately absent continuation token from a malformed response or failed page conversion. The optional `SkipToken` lookup returns null when the field is missing, which the callback treats as completion. Check the producer's invariants before using the same convention for another API.[^example]

See [pagination](pagination.md), [web requests](web-requests.md), and [retries](retry-polling.md).

# Examples

The following excerpt is copied from `AzureResourceGraph/AzureResourceGraph.pq`, lines 54–65.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        let
            // if previous is null, then this is our first page of data
            nextToken = if (previous = null) then "" else Value.Metadata(previous)[SkipToken]?,
            // if NextToken was set to null by the previous call, we know we have no more 
            delay = Number.RandomBetween(1, 3),
            page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null
        in
            page
    );

GetPage = (query as text, skipToken as text, optional scope as nullable text, optional subscription as text, optional managementGroup as text, optional options as record) as table =>
    let
```

[^example]: AzureResourceGraph/AzureResourceGraph.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **73** connectors in this archive.

* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L23)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L173)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 318](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L318)
* [Attio](../connectors/Attio.md): [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L109)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L302)
* [Automy Analytics](../connectors/AutomyDataAnalytics.md): [AutomyDataAnalytics.pq line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L86)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [Table.ChangeType.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L16)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L191), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Table.ChangeType.pqm#L12)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [AzureDeviceRegistry.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L150)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L56)
* [Solver](../connectors/BI360.md): [Solver.m line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L74), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Table.ChangeType.pqm#L12)
* [Bitbucket](../connectors/Bitbucket.md): [Bitbucket.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitbucket/Bitbucket.pq#L146)
* [Bitsight Security Ratings](../connectors/BitSightSecurityRatings.md): [BitSightSecurityRatings.pq line 1819](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1819)
* [Bloomberg](../connectors/Bloomberg.md): [Data-Handler.pqm line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L164)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 365](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L365), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Table.ChangeType.pqm#L12)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L88)
* [Cherwell](../connectors/Cherwell.md): [Cherwell.m line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L165)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 246](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L246)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 661](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L661)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L211)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L187)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 593](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L593), [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm#L8)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 355](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L355)
* [Dremio](../connectors/Dremio.md): [SqlGeneratorCommon.pqm line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGeneratorCommon.pqm#L296)
* [Eduframe](../connectors/Eduframe.md): [Requests.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L20)
* [SQL database](../connectors/FabricSql.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L4)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [api-factset-analytics-request.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L32), [api-factset-analytics-util.pqm line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L97), [request-long-running.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L18), [request-request.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm#L47), [util-oauth.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L40)
* [FHIR](../connectors/Fhir.md): [Diagnostics.pqm line 276](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Diagnostics.pqm#L276), [Fhir.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L219), [Folding.pqm line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Folding.pqm#L141)
* [Funnel](../connectors/Funnel.md): [DataLoading.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L29)
* [Google Sheets](../connectors/GoogleSheets.md): [GoogleSheets.pq line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L256)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L131), [OAuth.pqm line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L102), [ParametricFilter.pqm line 561](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L561), [SelectList.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L18), [Typecast.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L18), [UoM.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L21)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 1283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1283)
* [InformationGrid](../connectors/InformationGrid.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Table.ChangeType.pqm#L12)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L187)
* [inwink](../connectors/inwink.md): [inwink.pq line 367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L367)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L175)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L185)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 813](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L813)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [CommonHelpers.pqm line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L116), [kxkdbinsightsenterprise.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L278)
* [Lakehouse](../connectors/LakeHouse.md): [DualTable.View.pqm line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DualTable.View.pqm#L79), [LakeHouse.pq line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L76), [MDSync.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L34), [SparkComputeUtils.pqm line 267](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkComputeUtils.pqm#L267), [SqlGeneratorCommon.pqm line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SqlGeneratorCommon.pqm#L290), [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L4)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 602](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L602)
* [MicrosoftAzureDataManagerForEnergy](../connectors/MicrosoftAzureDataManagerForEnergy.md): [MicrosoftAzureDataManagerForEnergy.pq line 100](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L100)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 889](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L889)
* [OneLake Files](../connectors/OneLakeFile.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L4)
* [OneLakeSql](../connectors/OneLakeSql.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L4)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 808](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L808)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L227)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L156)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L12), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L4)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L49)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L71)
* [Samsara](../connectors/Samsara.md): [Samsara.Client.Depage.pqm line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Depage.pqm#L49), [Samsara.Client.Retry.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Retry.pqm#L51), [Samsara.Client.StartRun.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.StartRun.pqm#L33)
* [Siteimprove](../connectors/SiteImprove.md): [Siteimprove.pq line 772](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L772), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Table.ChangeType.pqm#L12)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L250)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L178)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L119)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L140)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 305](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L305)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [FetchResource.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm#L30), [SurveyMonkey.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L32)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 352](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L352)
* [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md): [TeamDesk.m line 272](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L272)
* [Microsoft Teams Personal Analytics](../connectors/TeamsAnalytics.md): [TeamsAnalytics.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L112)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Table.ChangeType.pqm#L12)
* [Azure Time Series Insights](../connectors/TimeSeriesInsights.md): [TimeSeriesInsightsConnector.m line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L165)
* [Usercube](../connectors/Usercube.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm#L12), [Usercube.m line 181](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L181)
* [Vena](../connectors/Vena.md): [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L66), [Vena.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L142)
* [Warehouse](../connectors/Warehouse.md): [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L55), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L4)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L191)
* [PQExtension1](../connectors/Witivio.md): [Witivio.pq line 207](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L207)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [Diagnostics.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm#L178), [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Table.ChangeType.pqm#L12), [WorkplaceAnalytics.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L279)
* [Wrike](../connectors/Wrike.md): [wrike.m line 352](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L352)
* [ZendeskData](../connectors/ZendeskData.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/Table.ChangeType.pqm#L12), [zendesk.pq line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L215)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L64)

<!-- seen-in:end -->
