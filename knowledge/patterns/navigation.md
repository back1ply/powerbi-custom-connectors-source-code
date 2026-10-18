---
type: Power Query Pattern
title: Navigation tables and connection checks
description: Navigation-column mappings and connection-test entry points.
category: Navigation and UI
tags: [navigation-and-ui]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Table\.ToNavigationTable\s*\(|TestConnection\s*=)']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L26
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: a14495cb07514ec04c8236b24ff322f62227d1b732c20f2590fcc2661827e4fd
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Asana builds a one-row navigation table with `Name`, `Data`, `ItemKind`, `ItemName`, and `IsLeaf` columns. The `Data` cell contains `Asana.View(link)`. `Table.ToNavigationTable` receives `Name` as the key and maps each navigation role to the corresponding column name.[^example]

The connector record separately declares `TestConnection = (dataSourcePath) => {"Asana.Tables", dataSourcePath}`. That handler names the shared function and supplies its argument. The connection check and the navigation-table construction are related entry points, but they are not the same function.[^example]

# Adaptation and failure paths

Keep column roles explicit when changing a navigation schema. A renamed key, data, or leaf column also needs an updated mapping. Trace what the `Data` cell evaluates to and how its function obtains the original URL; a visually correct list of names does not establish correct parameter routing.

Review the connection-test handler against the shared function's signature and its serialized data-source path. Asana passes the path directly, while the displayed navigation data comes from a view. Test the entry-point path separately from downstream row retrieval when adapting the connector, especially if the source path contains multiple parameters.[^example]

See [Table.View](table-view.md), [schema metadata](schema.md), and [packaged resources](packaging.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 26–34.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
AsanaNavTable = (link as text) as table =>
    let
        source = #table(
            { "Name",      "Data",           "ItemKind", "ItemName", "IsLeaf"}, {
            { "Tasks",      Asana.View(link), "Table",    "Table",     true }            }
        ),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;
```

[^example]: Asana/Asana.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **133** connectors in this archive.

* [Acterys : Model Automation & Planning](../connectors/Acterys.md): [Acterys.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L57)
* [Actian](../connectors/Actian.md): [Actian.m line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L252)
* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L77)
* [AmazonAthena](../connectors/AmazonAthena.md): [AmazonAthena.m line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L220)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [AmazonOpenSearchService.m line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L183)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L219)
* [Topcon Aptix Insights](../connectors/AptixInsights.md): [AptixInsights.pq line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L57)
* [Asana](../connectors/Asana.md): [Asana.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L32)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L24)
* [AtScale cubes](../connectors/AtScale.md): [AtScale.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L11)
* [Attio](../connectors/Attio.md): [Attio.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L145)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L124)
* [AutomationAnywhere](../connectors/AutomationAnywhere.md): [AutomationAnywhere.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomationAnywhere/AutomationAnywhere.m#L126)
* [Automy Analytics](../connectors/AutomyDataAnalytics.md): [AutomyDataAnalytics.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L19)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [AzureCosmosDBForMongoDBvCore.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L149)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L155)
* [Azure Database for MySQL](../connectors/AzureDatabaseForMySQL.md): [AzureDatabaseForMySQL.pq line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L62)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [AzureDeviceRegistry.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L40)
* [Azure HorizonDB Database](../connectors/AzureHorizonDB.md): [AzureHorizonDB.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L150)
* [Azure Database for PostgreSQL](../connectors/AzurePostgreSQL.md): [AzurePostgreSQL.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L150)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L180)
* [Solver](../connectors/BI360.md): [Solver.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L18)
* [BIConnector](../connectors/BIConnector.md): [BIConnector.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L83)
* [Bitbucket](../connectors/Bitbucket.md): [Bitbucket.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitbucket/Bitbucket.pq#L176)
* [Bitly](../connectors/Bitly.md): [Bitly.pq line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitly/Bitly.pq#L77)
* [Bitsight Security Ratings](../connectors/BitSightSecurityRatings.md): [BitSightSecurityRatings.pq line 566](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L566)
* [Bloomberg](../connectors/Bloomberg.md): [Bloomberg.m line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L141), [Utils.pqm line 296](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L296)
* [BQE CORE](../connectors/BQECore.md): [BQECore.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L137)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L99)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L8)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [CDataConnectCloud.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L6)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L25)
* [Cherwell](../connectors/Cherwell.md): [Cherwell.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L8)
* [ClickHouse](../connectors/ClickHouse.md): [ClickHouseConnector.pq line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L411)
* [CloudBluePSA](../connectors/CloudBluePSA.md): [CloudBluePSAConnector.m line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L68)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L87)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 208](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L208)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 327](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L327)
* [CosmosDB](../connectors/CosmosDB.md): [CosmosDB.m line 447](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L447)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L46)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 925](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L925)
* [Data Virtuality LDW](../connectors/DataVirtuality.md): [DataVirtuality.m line 206](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L206)
* [Digital Construction Works Insights](../connectors/DCWInsights.md): [DCWInsights.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DCWInsights/DCWInsights.m#L38)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L16)
* [Denodo](../connectors/Denodo.md): [DenodoForPowerBI.m line 556](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L556)
* [Dremio](../connectors/Dremio.md): [Dremio.pq line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L41)
* [Dynatrace_Grail_DQL](../connectors/DynatraceGrail.md): [DynatraceGrail.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L101)
* [Eduframe](../connectors/Eduframe.md): [EduFrame.pq line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L143)
* [Emigo Data Source](../connectors/Emigo.md): [Emigo.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Emigo/Emigo.m#L14)
* [Entersoft Business Suite](../connectors/EntersoftBusinessSuite.md): [Entersoft_Business_Suite.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L44)
* [EQuIS](../connectors/EQuIS.md): [EQuIS.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L34)
* [eWay-CRM](../connectors/eWayCRM.md): [eWay_CRM.m line 326](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L326)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [ExactOnlinePremium.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L119)
* [Exasol](../connectors/Exasol.md): [Exasol.pq line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L210)
* [SQL database](../connectors/FabricSql.md): [FabricSql.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L50)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [FactSetAnalytics.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L60)
* [FactSet RMS](../connectors/FactSetRMS.md): [FactSetRMS.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m#L9)
* [FHIR](../connectors/Fhir.md): [Fhir.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L22)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 113](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L113)
* [Funnel](../connectors/Funnel.md): [Funnel.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L10), [NavigationTable.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L47)
* [Google Sheets](../connectors/GoogleSheets.md): [GoogleSheets.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L68)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L143)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 280](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L280)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L285)
* [InformationGrid](../connectors/InformationGrid.md): [InformationGrid.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L65)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L22)
* [Intune Data Warehouse](../connectors/IntuneDataWarehouse.md): [Intune.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L42)
* [Intune Data Warehouse](../connectors/IntuneV2.md): [IntuneV2.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L63)
* [inwink](../connectors/inwink.md): [inwink.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L22)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L18)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L44)
* [JethroDataConnector](../connectors/JethroData1.0.1.md): [JethroODBC.m line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L109)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L81)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [kxkdbinsightsenterprise.pq line 565](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L565)
* [KylinDirectQuery](../connectors/Kyligence.md): [Kyligence.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L98)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 287](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L287)
* [Lakehouse](../connectors/LakeHouse.md): [LakeHouse.pq line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L315)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L72)
* [Linkar PICK Style / MultiValue Databases](../connectors/Linkar.md): [LinkarConnector.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Linkar/LinkarConnector.pq#L14)
* [LinkedInLearning](../connectors/LinkedInLearning.md): [LinkedInLearning.pq line 378](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LinkedInLearning/LinkedInLearning.pq#L378)
* [MariaDB](../connectors/MariaDB.md): [MariaDB.m line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L299)
* [MarkLogic](../connectors/MarkLogicODBC.md): [MarkLogicODBC.m line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L347)
* [MicrosoftAzureDataManagerForEnergy](../connectors/MicrosoftAzureDataManagerForEnergy.md): [MicrosoftAzureDataManagerForEnergy.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L74)
* [Microsoft Graph Security](../connectors/MicrosoftGraphSecurity.md): [MicrosoftGraphSecurity.m line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L73)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L22)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [MongoDBAtlasODBC.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L125)
* [OneLake Files](../connectors/OneLakeFile.md): [OneLakeFile.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L44)
* [OneLakeSql](../connectors/OneLakeSql.md): [OneLakeSql.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L44)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L74)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [OpenSearchProject.m line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L183)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L7)
* [Planview OKR](../connectors/PlanviewOKR.md): [PlanviewOKR.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L12)
* [Planview ProjectPlace](../connectors/PlanviewProjectplace.md): [PlanviewProjectplace.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L12)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L17)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Cdsa.Workspace.pqm line 243](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L243), [PowerPlatformDataflows.pq line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L197)
* [ProductInsightsConnector](../connectors/ProductInsights.md): [ProductInsightsConnector.m line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L166)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L64)
* [QubolePresto](../connectors/QubolePresto.md): [QubolePresto.m line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L210)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L96)
* [Roamler](../connectors/Roamler.md): [Roamler.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Roamler/Roamler.m#L14)
* [Samsara](../connectors/Samsara.md): [Samsara.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.pq#L59)
* [SIS-CC SDMX](../connectors/SDMX.md): [SDMX.m line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L69)
* [Sentinel](../connectors/Sentinel.md): [Sentinel.pq line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L126)
* [Shortcuts Business Insights](../connectors/ShortcutsBI.md): [ShortcutsBI.pq line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L88)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 446](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L446)
* [Siteimprove](../connectors/SiteImprove.md): [Siteimprove.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L10)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L11)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L50)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L28)
* [Planview IdeaPlace](../connectors/Spigit.md): [Spigit.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L12)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L51)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L180)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L11)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [SurveyMonkey.m line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L78)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L90)
* [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md): [TeamDesk.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L12)
* [Microsoft Teams Personal Analytics](../connectors/TeamsAnalytics.md): [TeamsAnalytics.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L44)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Tenforce.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L14)
* [TIBCO.ODBC.TDV](../connectors/TIBCO.md): [TIBCO.ODBC.TDV.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TIBCO/TIBCO.ODBC.TDV.m#L162)
* [Azure Time Series Insights](../connectors/TimeSeriesInsights.md): [TimeSeriesInsightsConnector.m line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L56)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L28)
* [Vena](../connectors/Vena.md): [Main.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Main.pqm#L34), [Vena.pq line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L210)
* [Vessel Insight](../connectors/VesselInsight.md): [VesselInsight.m line 408](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L408)
* [Warehouse](../connectors/Warehouse.md): [Warehouse.pq line 379](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L379)
* [WebtrendsAnalytics](../connectors/WebtrendsAnalytics.md): [WebtrendsAnalytics.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L14)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L14)
* [PQExtension1](../connectors/Witivio.md): [Witivio.pq line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L23)
* [Workforce Dimensions](../connectors/WorkforceDimensions.md): [WorkforceDimensions.m line 424](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkforceDimensions/WorkforceDimensions.m#L424)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 752](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L752)
* [Wrike](../connectors/Wrike.md): [wrike.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L43)
* [ZendeskData](../connectors/ZendeskData.md): [zendesk.pq line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L157)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L122)
* [Zucchetti](../connectors/Zucchetti.md): [Zucchetti.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Zucchetti/Zucchetti.m#L21)

<!-- seen-in:end -->
