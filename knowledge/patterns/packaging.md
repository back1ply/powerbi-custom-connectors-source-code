---
type: Power Query Pattern
title: Resources and modular source loading
description: Configuration resources, localization calls, and extracted archives.
category: Packaging
tags: [packaging]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Extension\.Contents|Extension\.LoadString|Expression\.Evaluate)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L2
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: d71ada87a2cce25df057ca9e58c4fc7566b2a853c80f94052396f9516cd3611c
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Asana loads `Config.json` with `Extension.Contents`, parses it with `Json.Document`, and binds its client identifier, callback URI, token URI, authorization URI, and API URL from that record. The exported function's type and publishing metadata also call `Extension.LoadString` for UI text.[^example]

The same file references image resources in its icon declarations. Source references can therefore remain even when the extraction pipeline has removed localization and image files. The source archive is useful for inspecting these bindings, but it is not a complete runnable package.[^example]

# Adaptation and failure paths

Follow a resource name to the actual retained file before describing its content. Keep code, configuration, localized strings, and images distinct when planning a new package. If a configuration or module is missing, do not infer its values from a loader call alone.

Rebuild a distributable connector from its own package resources rather than treating this stripped archive as a drop-in package. Preserve the relationship between resource keys and call sites, and review credential-bearing configuration separately from public identifiers. The redaction rules and removed-resource list are documented in the repository README; they are properties of this archive's tooling, not behavior supplied by `Extension.Contents`.

See [OAuth2 configuration](oauth2.md), [navigation metadata](navigation.md), and [credential access](credentials.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 2–13.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
section Asana;

config = Json.Document ( Extension.Contents( "Config.json") );
client_id=  config[client_id];
redirect_uri = config[redirect_uri];
token_uri = config[token_uri];
authorize_uri = config [authorize_uri];
api_url = config [api_url];

[DataSource.Kind="Asana", Publish="Asana.Publish"]
shared Asana.Tables =  Value.ReplaceType(AsanaNavTable, Asana_Type);

```

[^example]: Asana/Asana.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **133** connectors in this archive.

* [Acterys : Model Automation & Planning](../connectors/Acterys.md): [Acterys.pq line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L219)
* [Actian](../connectors/Actian.md): [Actian.m line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L212)
* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L5)
* [AmazonAthena](../connectors/AmazonAthena.md): [AmazonAthena.m line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L76)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [AmazonOpenSearchService.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L222)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L234), [TraceContext.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/TraceContext.pqm#L21)
* [Topcon Aptix Insights](../connectors/AptixInsights.md): [AptixInsights.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L20)
* [Asana](../connectors/Asana.md): [Asana.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L4)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L347)
* [AtScale cubes](../connectors/AtScale.md): [AtScale.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L15)
* [Attio](../connectors/Attio.md): [Attio.pq line 151](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L151)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L5)
* [AutomationAnywhere](../connectors/AutomationAnywhere.md): [AutomationAnywhere.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomationAnywhere/AutomationAnywhere.m#L15)
* [Automy Analytics](../connectors/AutomyDataAnalytics.md): [AutomyDataAnalytics.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L15)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95), [ExtendedJson.Extract.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm#L63), [Visitors.VisitAstKind.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm#L3)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L117)
* [Azure Database for MySQL](../connectors/AzureDatabaseForMySQL.md): [AzureDatabaseForMySQL.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L35)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [AzureDeviceRegistry.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L47)
* [Azure HorizonDB Database](../connectors/AzureHorizonDB.md): [AzureHorizonDB.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L47)
* [Azure Database for PostgreSQL](../connectors/AzurePostgreSQL.md): [AzurePostgreSQL.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L47)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L9)
* [Solver](../connectors/BI360.md): [Solver.m line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L199)
* [BIConnector](../connectors/BIConnector.md): [BIConnector.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L98)
* [Bitbucket](../connectors/Bitbucket.md): [Bitbucket.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitbucket/Bitbucket.pq#L182)
* [Bitly](../connectors/Bitly.md): [Bitly.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitly/Bitly.pq#L83)
* [Bitsight Security Ratings](../connectors/BitSightSecurityRatings.md): [BitSightSecurityRatings.pq line 569](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L569)
* [Bloomberg](../connectors/Bloomberg.md): [Auth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L4), [Bloomberg.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L21), [Data-Handler.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L4), [Diagnostics.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm#L4), [Folding.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L4), [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L4)
* [BQE CORE](../connectors/BQECore.md): [BQECore.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L3)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L6)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L21)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [CDataConnectCloud.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L12), [CDataConnectCloudRest.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRest.pqm#L8), [CDataConnectCloudRestV2.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudRestV2.pqm#L8), [CDataConnectCloudService.pqm line 381](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L381), [CDataConnectCloudServiceV2.pqm line 472](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L472)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L29)
* [Cherwell](../connectors/Cherwell.md): [Cherwell.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L26)
* [ClickHouse](../connectors/ClickHouse.md): [ClickHouseConnector.pq line 427](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L427)
* [CloudBluePSA](../connectors/CloudBluePSA.md): [CloudBluePSAConnector.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L52)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L56)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L98)
* [CosmosDB](../connectors/CosmosDB.md): [CosmosDB.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L135)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L58)
* [Azure Databricks](../connectors/Databricks.md): [AdvancedOptions.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm#L28), [Databricks.pq line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L43)
* [Data Virtuality LDW](../connectors/DataVirtuality.md): [DataVirtuality.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L25)
* [Digital Construction Works Insights](../connectors/DCWInsights.md): [DCWInsights.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DCWInsights/DCWInsights.m#L14)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L36)
* [Denodo](../connectors/Denodo.md): [DenodoForPowerBI.m line 595](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L595)
* [Dremio](../connectors/Dremio.md): [Dremio.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L72), [DremioAdbcDataSource.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L8), [DremioAdbcOptions.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcOptions.pqm#L8), [SqlGenerator.pqm line 1004](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/SqlGenerator.pqm#L1004)
* [Dynatrace_Grail_DQL](../connectors/DynatraceGrail.md): [DynatraceGrail.m line 445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L445)
* [Eduframe](../connectors/Eduframe.md): [EduFrame.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L5)
* [Emigo Data Source](../connectors/Emigo.md): [Emigo.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Emigo/Emigo.m#L18)
* [Entersoft Business Suite](../connectors/EntersoftBusinessSuite.md): [Entersoft_Business_Suite.m line 281](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L281)
* [EQuIS](../connectors/EQuIS.md): [EQuIS.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L20)
* [eWay-CRM](../connectors/eWayCRM.md): [eWay_CRM.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L358)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [ExactOnlinePremium.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L9), [OAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L3)
* [Exasol](../connectors/Exasol.md): [Exasol.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L16)
* [SQL database](../connectors/FabricSql.md): [FabricSql.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L12), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L24)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [FactSetAnalytics.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L34)
* [FactSet RMS](../connectors/FactSetRMS.md): [FactSetRMS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m#L14)
* [FHIR](../connectors/Fhir.md): [Fhir.pq line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L29)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L11)
* [Funnel](../connectors/Funnel.md): [DataLoading.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L10), [Funnel.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L16), [NavigationTable.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/NavigationTable.pqm#L4), [OAuth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm#L4)
* [Google Sheets](../connectors/GoogleSheets.md): [GoogleSheets.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L74)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L52), [OAuth.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L8), [ParametricFilter.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L45), [SelectList.pqm line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L39), [Typecast.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L31), [UoM.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L14)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L39)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L9)
* [InformationGrid](../connectors/InformationGrid.md): [InformationGrid.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L11)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L21)
* [Intune Data Warehouse](../connectors/IntuneDataWarehouse.md): [Intune.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L60)
* [Intune Data Warehouse](../connectors/IntuneV2.md): [IntuneV2.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L14)
* [inwink](../connectors/inwink.md): [inwink.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L38)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L17)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L14)
* [JethroDataConnector](../connectors/JethroData1.0.1.md): [JethroODBC.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L122)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L121)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [AuthHelpers.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L44), [CommonHelpers.pqm line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L212), [kxkdbinsightsenterprise.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L44)
* [KylinDirectQuery](../connectors/Kyligence.md): [Kyligence.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Kyligence.m#L126)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 309](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L309)
* [Lakehouse](../connectors/LakeHouse.md): [LakeHouse.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L117), [MDSync.pqm line 356](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L356), [SparkCompute.pqm line 413](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkCompute.pqm#L413), [SparkComputeUtils.pqm line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkComputeUtils.pqm#L212), [SqlGenerator.pqm line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SqlGenerator.pqm#L114), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.pqm#L24)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L47)
* [Linkar PICK Style / MultiValue Databases](../connectors/Linkar.md): [LinkarConnector.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Linkar/LinkarConnector.pq#L32)
* [LinkedInLearning](../connectors/LinkedInLearning.md): [LinkedInLearning.pq line 403](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LinkedInLearning/LinkedInLearning.pq#L403)
* [MariaDB](../connectors/MariaDB.md): [MariaDB.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L30)
* [MarkLogic](../connectors/MarkLogicODBC.md): [MarkLogicODBC.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L358)
* [MicrosoftAzureDataManagerForEnergy](../connectors/MicrosoftAzureDataManagerForEnergy.md): [MicrosoftAzureDataManagerForEnergy.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L16)
* [Microsoft Graph Security](../connectors/MicrosoftGraphSecurity.md): [MicrosoftGraphSecurity.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L4)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L9)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [MongoDBAtlasODBC.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L142)
* [OneLake Files](../connectors/OneLakeFile.md): [OneLakeFile.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L12), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L47), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L24)
* [OneLakeSql](../connectors/OneLakeSql.md): [OneLakeSql.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/OneLakeSql.pq#L11), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L24)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 842](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L842)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [OpenSearchProject.m line 222](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L222)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L19)
* [Planview OKR](../connectors/PlanviewOKR.md): [PlanviewOKR.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L14)
* [Planview ProjectPlace](../connectors/PlanviewProjectplace.md): [PlanviewProjectplace.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L14)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L125)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [PowerPlatformDataflows.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L150), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L47), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L50)
* [ProductInsightsConnector](../connectors/ProductInsights.md): [ProductInsightsConnector.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L4)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L8)
* [QubolePresto](../connectors/QubolePresto.md): [QubolePresto.m line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L221)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L12)
* [Roamler](../connectors/Roamler.md): [Roamler.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Roamler/Roamler.m#L18)
* [Samsara](../connectors/Samsara.md): [Samsara.Client.Depage.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Depage.pqm#L42), [Samsara.Client.ErrorTranslation.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.ErrorTranslation.pqm#L33), [Samsara.Client.StartRun.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.StartRun.pqm#L21), [Samsara.Credentials.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Credentials.pqm#L9), [Samsara.Icons.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Icons.pqm#L5), [Samsara.Input.Parameters.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Input.Parameters.pqm#L5), [Samsara.Input.Validation.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Input.Validation.pqm#L27), [Samsara.Table.Discover.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Table.Discover.pqm#L9), [Samsara.pq line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.pq#L26)
* [SIS-CC SDMX](../connectors/SDMX.md): [SDMX.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L17)
* [Sentinel](../connectors/Sentinel.md): [Sentinel.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L11)
* [Shortcuts Business Insights](../connectors/ShortcutsBI.md): [ShortcutsBI.pq line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L7)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L16)
* [Siteimprove](../connectors/SiteImprove.md): [Siteimprove.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L14)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L51)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L17)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L3)
* [Planview IdeaPlace](../connectors/Spigit.md): [Spigit.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L14)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L133)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L259)
* [Supermetrics](../connectors/Supermetrics.md): [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Icons.pqm#L3), [Supermetrics.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L7)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [SurveyMonkey.m line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L142)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L45)
* [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md): [TeamDesk.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L11)
* [Microsoft Teams Personal Analytics](../connectors/TeamsAnalytics.md): [TeamsAnalytics.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamsAnalytics/TeamsAnalytics.pq#L40)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Tenforce.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L25)
* [TIBCO.ODBC.TDV](../connectors/TIBCO.md): [TIBCO.ODBC.TDV.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TIBCO/TIBCO.ODBC.TDV.m#L128)
* [Azure Time Series Insights](../connectors/TimeSeriesInsights.md): [TimeSeriesInsightsConnector.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L26)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L44)
* [Vena](../connectors/Vena.md): [Vena.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L63)
* [Vessel Insight](../connectors/VesselInsight.md): [VIAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L3), [VIServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm#L2), [VesselInsight.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L22), [VoyageServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm#L2)
* [Warehouse](../connectors/Warehouse.md): [OutputInterceptor.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L46), [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L47), [Warehouse.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L6), [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm#L86), [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L50), [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L24)
* [WebtrendsAnalytics](../connectors/WebtrendsAnalytics.md): [WebtrendsAnalytics.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WebtrendsAnalytics/WebtrendsAnalytics.pq#L21)
* [Windsor](../connectors/Windsor.md): [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Icons.pqm#L3), [Windsor.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L10)
* [PQExtension1](../connectors/Witivio.md): [Witivio.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L55)
* [Workforce Dimensions](../connectors/WorkforceDimensions.md): [WorkforceDimensions.m line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkforceDimensions/WorkforceDimensions.m#L47)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L217)
* [Wrike](../connectors/Wrike.md): [wrike.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L9)
* [ZendeskData](../connectors/ZendeskData.md): [zendesk.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L8)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L15)
* [Zucchetti](../connectors/Zucchetti.md): [Zucchetti.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Zucchetti/Zucchetti.m#L60)

<!-- seen-in:end -->
