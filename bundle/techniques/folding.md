---
type: Power Query Technique Matrix
title: 'Techniques: folding'
description: 'Archived connectors by answer to: Does it fold queries to the source, and how?'
generated:
  by: process:pqkb-build
  at: '2026-11-26T19:15:54Z'
---

# folding

Which archived connectors use each answer of the connector checklist (`knowledge/checklist.yaml`), with the first cited source line. **✓** marks hand-checked labels; the rest are model-generated profiles (about 95% exact against hand labels), so open the cited line before relying on one. This shows what certified connectors do, which is evidence rather than advice: Microsoft's guidance and the `write-connector` skill say what to do.

## folding: Does it fold queries to the source, and how? ([Learn](https://learn.microsoft.com/en-us/power-query/native-query-sdk))

### `none`: 67 connectors

[Anaplan](../connectors/Anaplan.md) ✓ `Anaplan.pq:563`, [Attio](../connectors/Attio.md) ✓ `Attio.pq:510`, [AzureResourceGraph](../connectors/AzureResourceGraph.md) ✓ `AzureResourceGraph.pq:120`, [Bitbucket](../connectors/Bitbucket.md) ✓ `Bitbucket.pq:126`, [GoogleSheets](../connectors/GoogleSheets.md) ✓ `GoogleSheets.pq:140`, [Linkar](../connectors/Linkar.md) ✓ `LinkarConnector.pq:179`, [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md) ✓ `SolarWindsServiceDesk.pq:136`, [SurveyMonkey](../connectors/SurveyMonkey.md) ✓ `FetchResource.pqm:26`, [ZendeskData](../connectors/ZendeskData.md) ✓ `zendesk.pq:163`, [ZohoCreator](../connectors/ZohoCreator.md) ✓ `ZohoCreator.m:56`, [ADPAnalytics](../connectors/ADPAnalytics.md), [Acterys](../connectors/Acterys.md), [AutodeskConstructionCloud](../connectors/AutodeskConstructionCloud.md), [AutomationAnywhere](../connectors/AutomationAnywhere.md), [AutomyDataAnalytics](../connectors/AutomyDataAnalytics.md), [AzureCostManagement](../connectors/AzureCostManagement.md), [AzureDeviceRegistry](../connectors/AzureDeviceRegistry.md), [BI360](../connectors/BI360.md) `Solver.m:102`, [BQECore](../connectors/BQECore.md), [BitSightSecurityRatings](../connectors/BitSightSecurityRatings.md) `BitSightSecurityRatings.pq:1`, [Bitly](../connectors/Bitly.md), [BuildingConnected](../connectors/BuildingConnected.md) `BuildingConnected.pq:227`, [CCHTagetik](../connectors/CCHTagetik.md), [Cherwell](../connectors/Cherwell.md), [CloudBluePSA](../connectors/CloudBluePSA.md), [CustomerInsights](../connectors/CustomerInsights.md) `CustomerInsights.m:237`, [DeltaSharing](../connectors/DeltaSharing.md), [DynatraceGrail](../connectors/DynatraceGrail.md), [EQuIS](../connectors/EQuIS.md) `EQuIS.m:1`, [EntersoftBusinessSuite](../connectors/EntersoftBusinessSuite.md) `Entersoft_Business_Suite.m:1`, [FactSetAnalytics](../connectors/FactSetAnalytics.md) `FactSetAnalytics.pq:119`, [FactSetRMS](../connectors/FactSetRMS.md) `FactSetRMS.m:281`, [FifteenFive](../connectors/FifteenFive.md) `FifteenFive.pq:955`, [Funnel](../connectors/Funnel.md), [IndustrialAppStore](../connectors/IndustrialAppStore.md), [InformationGrid](../connectors/InformationGrid.md), [JamfPro](../connectors/JamfPro.md), [Kognitwin](../connectors/Kognitwin.md), [LEAP](../connectors/LEAP.md), [LinkedInLearning](../connectors/LinkedInLearning.md), [MicrosoftAzureDataManagerForEnergy](../connectors/MicrosoftAzureDataManagerForEnergy.md), [OneLakeFile](../connectors/OneLakeFile.md) `OneLakeFile.pq:296`, [OneStream](../connectors/OneStream.md), [Paxata](../connectors/Paxata.md) `Paxata.m:1`, [ProductInsights](../connectors/ProductInsights.md), [Profisee](../connectors/Profisee.md), [QuickBase](../connectors/QuickBase.md), [Roamler](../connectors/Roamler.md), [SDMX](../connectors/SDMX.md) `SDMX.m:38`, [ShortcutsBI](../connectors/ShortcutsBI.md), [SmartsheetGlobal](../connectors/SmartsheetGlobal.md), [SoftOneBI](../connectors/SoftOneBI.md), [Supermetrics](../connectors/Supermetrics.md), [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md), [TeamsAnalytics](../connectors/TeamsAnalytics.md), [Tenforce](../connectors/Tenforce.md) `Tenforce.m:121`, [TimeSeriesInsights](../connectors/TimeSeriesInsights.md) `TimeSeriesInsightsConnector.m:1`, [Vena](../connectors/Vena.md) `Vena.pq:40`, [VesselInsight](../connectors/VesselInsight.md), [WebtrendsAnalytics](../connectors/WebtrendsAnalytics.md) `WebtrendsAnalytics.pq:90`, [Windsor](../connectors/Windsor.md), [Witivio](../connectors/Witivio.md) `Witivio.pq:179`, [WorkforceDimensions](../connectors/WorkforceDimensions.md), [Wrike](../connectors/Wrike.md), [Zucchetti](../connectors/Zucchetti.md), [eWayCRM](../connectors/eWayCRM.md), [inwink](../connectors/inwink.md)

### `table-view-handlers`: 19 connectors

The connector writes its own folding handlers in Table.View (OnTake, OnSelectRows, OnSort and the like), on data tables or on its navigation tables. A Table.View that adds only GetRows or OnNativeQuery is not folding; OnNativeQuery alone is native-query. Handlers built by the engine's SqlView.Generator count under custom-sql-generator.

[Asana](../connectors/Asana.md) ✓ `Asana.m:37`, [LakeHouse](../connectors/LakeHouse.md) ✓ `DualTable.View.pqm:275`, [AssembleViews](../connectors/AssembleViews.md) `AssembleViews.m:478`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:967`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:37`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:298`, [Celonis](../connectors/Celonis.md) `Celonis.m:271`, [Databricks](../connectors/Databricks.md) `Databricks.pq:1651`, [Dremio](../connectors/Dremio.md) `Dremio.pq:829`, [Eduframe](../connectors/Eduframe.md) `EduFrame.pq:205`, [FabricSql](../connectors/FabricSql.md) `FabricSql.pq:272`, [MicrostrategyDataset](../connectors/MicrostrategyDataset.md) `MicroStrategyDataset.m:496`, [OneLakeSql](../connectors/OneLakeSql.md) `OneLakeSql.pq:244`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [Samsara](../connectors/Samsara.md) `Samsara.Table.Fetch.pqm:128`, [Usercube](../connectors/Usercube.md) `Usercube.m:109`, [Warehouse](../connectors/Warehouse.md) `Warehouse.pq:340`, [WorkplaceAnalytics](../connectors/WorkplaceAnalytics.md) `WorkplaceAnalytics.pq:573`, [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md) `kxkdbinsightsenterprise.pq:188`

### `odbc-sql-capabilities`: 27 connectors

Folding through Odbc.DataSource, shaped by SqlCapabilities, SQLGetInfo, SQLGetTypeInfo, or AstVisitor overrides. An AstVisitor that rewrites LIMIT/OFFSET belongs here, not under custom-sql-generator.

[AmazonAthena](../connectors/AmazonAthena.md) ✓ `AmazonAthena.m:163`, [ClickHouse](../connectors/ClickHouse.md) ✓ `ClickHouseConnector.pq:260`, [MarkLogicODBC](../connectors/MarkLogicODBC.md) ✓ `MarkLogicODBC.m:315`, [TIBCO](../connectors/TIBCO.md) ✓ `TIBCO.ODBC.TDV.m:87`, [Actian](../connectors/Actian.md) `Actian.m:132`, [AmazonOpenSearchService](../connectors/AmazonOpenSearchService.md) `AmazonOpenSearchService.m:116`, [BIConnector](../connectors/BIConnector.md) `BIConnector.pq:43`, [CosmosDB](../connectors/CosmosDB.md) `CosmosDB.m:583`, [DataVirtuality](../connectors/DataVirtuality.md) `DataVirtuality.m:55`, [Databricks](../connectors/Databricks.md) `Databricks.pq:1651`, [Denodo](../connectors/Denodo.md) `DenodoForPowerBI.m:113`, [Dremio](../connectors/Dremio.md) `Dremio.pq:829`, [ExactOnlinePremium](../connectors/ExactOnlinePremium.md) `ExactOnlinePremium.m:89`, [Exasol](../connectors/Exasol.md) `Exasol.pq:441`, [Foundry](../connectors/Foundry.md) `Foundry.m:151`, [IRIS](../connectors/IRIS.md) `Iris_PowerBI_Connector.m:96`, [Indexima](../connectors/Indexima.md) `Indexima.m:175`, [IntersystemsHealthInsight](../connectors/IntersystemsHealthInsight.md) `IntersystemsHealthInsight.pq:106`, [JethroData1.0.1](../connectors/JethroData1.0.1.md) `JethroODBC.m:42`, [Kyligence](../connectors/Kyligence.md) `Kyligence.m:72`, [KyvosODBC](../connectors/KyvosODBC.md) `KyvosODBC.pq:434`, [MariaDB](../connectors/MariaDB.md) `MariaDB.m:145`, [MongoDBAtlasODBC](../connectors/MongoDBAtlasODBC.md) `MongoDBAtlasODBC.pq:184`, [OpenSearchProject](../connectors/OpenSearchProject.md) `OpenSearchProject.m:116`, [QubolePresto](../connectors/QubolePresto.md) `QubolePresto.m:112`, [SingleStoreODBC](../connectors/SingleStoreODBC.md) `SingleStoreODBC.m:188`, [StarburstPresto](../connectors/StarburstPresto.md) `StarburstEnterprise.pq:108`

### `native-query`: 11 connectors

Value.NativeQuery is supported, through an OnNativeQuery handler or a source function that accepts native queries.

[ClickHouseArrowFlight](../connectors/ClickHouseArrowFlight.md) ✓ `ClickHouseArrowFlight.pq:469`, [CommonDataService](../connectors/CommonDataService.md) ✓ `CommonDataService.pq:68`, [LakeHouse](../connectors/LakeHouse.md) ✓ `DualTable.View.pqm:275`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:967`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:298`, [Databricks](../connectors/Databricks.md) `Databricks.pq:1651`, [Denodo](../connectors/Denodo.md) `DenodoForPowerBI.m:113`, [Dremio](../connectors/Dremio.md) `Dremio.pq:829`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [SingleStoreODBC](../connectors/SingleStoreODBC.md) `SingleStoreODBC.m:188`, [StarburstPresto](../connectors/StarburstPresto.md) `StarburstEnterprise.pq:108`

### `custom-sql-generator`: 7 connectors

The connector writes its own SQL text generator outside the ODBC driver, usually behind Table.View handlers.

[ClickHouseArrowFlight](../connectors/ClickHouseArrowFlight.md) ✓ `ClickHouseArrowFlight.pq:469`, [LakeHouse](../connectors/LakeHouse.md) ✓ `DualTable.View.pqm:275`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:967`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:298`, [Databricks](../connectors/Databricks.md) `Databricks.pq:1651`, [Dremio](../connectors/Dremio.md) `Dremio.pq:829`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `odata-folding`: 13 connectors

The connector returns OData.Feed tables, so the OData connector folds filters, selects and paging into the request. Answer this, not none, even though the connector writes no folding code itself.

[AptixInsights](../connectors/AptixInsights.md) ✓ `AptixInsights.pq:42`, [CogniteDataSource](../connectors/CogniteDataSource.md) ✓ `CogniteDataSource.pq:544`, [PlanviewOKR](../connectors/PlanviewOKR.md) ✓ `PlanviewOKR.m:173`, [Cognite](../connectors/Cognite.md) `Cognite.pq:147`, [DCWInsights](../connectors/DCWInsights.md) `DCWInsights.m:29`, [Emigo](../connectors/Emigo.md) `Emigo.m:263`, [HexagonSmartApi](../connectors/HexagonSmartApi.md) `HexagonSmartApi.m:108`, [IntuneDataWarehouse](../connectors/IntuneDataWarehouse.md) `Intune.m:32`, [IntuneV2](../connectors/IntuneV2.md) `IntuneV2.pq:56`, [MicrosoftGraphSecurity](../connectors/MicrosoftGraphSecurity.md) `MicrosoftGraphSecurity.m:106`, [PlanviewProjectplace](../connectors/PlanviewProjectplace.md) `PlanviewProjectplace.m:133`, [Spigit](../connectors/Spigit.md) `Spigit.m:132`, [SumTotal](../connectors/SumTotal.md) `SumTotal.pq:117`

### `source-function-folding`: 13 connectors

Folding is delegated to a source function that folds on its own, such as Sql.Database. Answer this, not none.

[CommonDataService](../connectors/CommonDataService.md) ✓ `CommonDataService.pq:68`, [LakeHouse](../connectors/LakeHouse.md) ✓ `DualTable.View.pqm:275`, [PowerBIDatamarts](../connectors/PowerBIDatamarts.md) ✓ `PowerBIDatamarts.pq:263`, [AtScale](../connectors/AtScale.md) `AtScale.pq:27`, [AzureDatabaseForMySQL](../connectors/AzureDatabaseForMySQL.md) `AzureDatabaseForMySQL.pq:12`, [AzureHorizonDB](../connectors/AzureHorizonDB.md) `AzureHorizonDB.pq:31`, [AzurePostgreSQL](../connectors/AzurePostgreSQL.md) `AzurePostgreSQL.pq:31`, [FabricSql](../connectors/FabricSql.md) `FabricSql.pq:272`, [OneLakeSql](../connectors/OneLakeSql.md) `OneLakeSql.pq:244`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [Sentinel](../connectors/Sentinel.md) `Sentinel.pq:103`, [Synapse](../connectors/Synapse.md) `Synapse.pq:392`, [Warehouse](../connectors/Warehouse.md) `Warehouse.pq:340`

## folding/table-view-handlers: Which Table.View handlers are implemented?

### `on-take`: 11 connectors

[Asana](../connectors/Asana.md) ✓ `Asana.m:53`, [LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [Celonis](../connectors/Celonis.md) `Celonis.m:284`, [MicrostrategyDataset](../connectors/MicrostrategyDataset.md) `MicroStrategyDataset.m:517`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [Samsara](../connectors/Samsara.md) `Samsara.Table.Fetch.pqm:128`, [Usercube](../connectors/Usercube.md) `Usercube.m:117`, [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md) `kxkdbinsightsenterprise.pq:226`

### `on-skip`: 7 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [Celonis](../connectors/Celonis.md) `Celonis.m:284`, [MicrostrategyDataset](../connectors/MicrostrategyDataset.md) `MicroStrategyDataset.m:517`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `on-select-rows`: 11 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [Databricks](../connectors/Databricks.md) `Databricks.pq:1651`, [Dremio](../connectors/Dremio.md) `DremioAdbcDataSource.pqm:576`, [Eduframe](../connectors/Eduframe.md) `EduFrame.pq:205`, [FabricSql](../connectors/FabricSql.md) `FabricSql.pq:277`, [OneLakeSql](../connectors/OneLakeSql.md) `OneLakeSql.pq:245`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [Warehouse](../connectors/Warehouse.md) `Warehouse.pq:299`, [WorkplaceAnalytics](../connectors/WorkplaceAnalytics.md) `WorkplaceAnalytics.pq:603`

### `on-select-columns`: 6 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AssembleViews](../connectors/AssembleViews.md) `AssembleViews.m:501`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `on-sort`: 5 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `on-group`: 4 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `on-add-columns`: 4 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `get-row-count`: 5 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [MicrostrategyDataset](../connectors/MicrostrategyDataset.md) `MicroStrategyDataset.m:517`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`

### `get-expression`: 6 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [FabricSql](../connectors/FabricSql.md) `FabricSql.pq:277`, [OneLakeSql](../connectors/OneLakeSql.md) `OneLakeSql.pq:245`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`, [Warehouse](../connectors/Warehouse.md) `Warehouse.pq:299`

### `other`: 6 connectors

[LakeHouse](../connectors/LakeHouse.md) ✓ `LakeHouse.pq:3570`, [AzureCosmosDBForMongoDBvCore](../connectors/AzureCosmosDBForMongoDBvCore.md) `AzureCosmosDBForMongoDBvCore.pq:580`, [Bloomberg](../connectors/Bloomberg.md) `Folding.pqm:66`, [CDataConnectCloud](../connectors/CDataConnectCloud.md) `CDataConnectCloudServiceV2.pqm:304`, [FabricSql](../connectors/FabricSql.md) `FabricSql.pq:277`, [PowerPlatformDataflows](../connectors/PowerPlatformDataflows.md) `PowerPlatformDataflows.pq:1738`
