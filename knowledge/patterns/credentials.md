---
type: Power Query Pattern
title: Credential access
description: Authentication-kind dispatch and credential connection strings.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bExtension\.CurrentCredential\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L115
  title: Actian/Actian.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: 97c1b43f5028a9da2b96df5a1eaeb18617667483eda339735b8357f2812865cf
  sources_sha256:
    example: fd2d31eeba79778f2f1221a22b0dc78942f0b603d8381d4e3dbe7bd8e77a04d7
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Actian obtains a credential record through `Extension.CurrentCredential()` and dispatches on its optional `AuthenticationKind` field. For `UsernamePassword` it constructs a separate `CredentialConnectionString` record containing `UID` and `PWD`. For `Windows` it returns `null`; the SQL Server-specific trusted-connection record in the file is commented out.[^example]

The surrounding function constructs ordinary connection properties such as driver, server, and database separately from this credential record. That separation makes it possible to inspect connection routing without replacing the user-supplied username and password with literals in the query.[^example]

# Adaptation and failure paths

Read the authentication declaration and the consumer of `CredentialConnectionString` before copying a branch. A field used by an OAuth connector is not a substitute for the username/password fields shown here. Keep secret values out of examples, connection labels, and diagnostic messages when adapting the pattern.

The final branch raises `Error.Record` for an unhandled authentication kind; it does not silently fall back to anonymous access. The optional field lookup in the condition also means the code can reach that failure path when the expected kind is absent. Include that path when checking a connector against its supported authentication modes.[^example]

See [ODBC configuration](odbc.md), [diagnostics](diagnostics.md), and [OAuth2](oauth2.md).

# Examples

The following excerpt is copied from `Actian/Actian.m`, lines 115–126.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        // handled here as an example. 
        //
        Credential = Extension.CurrentCredential(),
        CredentialConnectionString =
            if Credential[AuthenticationKind]? = "UsernamePassword" then
                // set connection string parameters used for basic authentication
                [ UID = Credential[Username], PWD = Credential[Password] ]
            else if (Credential[AuthenticationKind]? = "Windows") then
                // set connection string parameters used for windows/kerberos authentication
                //[ Trusted_Connection="Yes" ]    SQLServer only
                null
            else
```

[^example]: Actian/Actian.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **83** connectors in this archive.

* [Acterys : Model Automation & Planning](../connectors/Acterys.md): [Acterys.pq line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L8)
* [Actian](../connectors/Actian.md): [Actian.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Actian.m#L117)
* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L98)
* [AmazonAthena](../connectors/AmazonAthena.md): [AmazonAthena.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L53)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [AmazonOpenSearchService.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L38)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L81)
* [Topcon Aptix Insights](../connectors/AptixInsights.md): [AptixInsights.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L39)
* [Asana](../connectors/Asana.md): [Asana.m line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L194)
* [AtScale cubes](../connectors/AtScale.md): [AtScale.pq line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AtScale/AtScale.pq#L24)
* [Attio](../connectors/Attio.md): [Attio.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L85)
* [AutomationAnywhere](../connectors/AutomationAnywhere.md): [AutomationAnywhere.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomationAnywhere/AutomationAnywhere.m#L34)
* [Automy Analytics](../connectors/AutomyDataAnalytics.md): [AutomyDataAnalytics.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L10)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L182)
* [Azure Database for MySQL](../connectors/AzureDatabaseForMySQL.md): [AzureDatabaseForMySQL.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDatabaseForMySQL/AzureDatabaseForMySQL.pq#L12)
* [Azure HorizonDB Database](../connectors/AzureHorizonDB.md): [AzureHorizonDB.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureHorizonDB/AzureHorizonDB.pq#L33)
* [Azure Database for PostgreSQL](../connectors/AzurePostgreSQL.md): [AzurePostgreSQL.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzurePostgreSQL/AzurePostgreSQL.pq#L33)
* [Solver](../connectors/BI360.md): [Solver.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L11)
* [BIConnector](../connectors/BIConnector.md): [BIConnector.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BIConnector/BIConnector.pq#L19)
* [Bitbucket](../connectors/Bitbucket.md): [Bitbucket.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitbucket/Bitbucket.pq#L123)
* [Bitly](../connectors/Bitly.md): [Bitly.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitly/Bitly.pq#L49)
* [Bitsight Security Ratings](../connectors/BitSightSecurityRatings.md): [BitSightSecurityRatings.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L21)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L292)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L5)
* [ClickHouse](../connectors/ClickHouse.md): [ClickHouseConnector.pq line 252](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/ClickHouseConnector.pq#L252)
* [CloudBluePSA](../connectors/CloudBluePSA.md): [CloudBluePSAConnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L33)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L129)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 314](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L314)
* [CosmosDB](../connectors/CosmosDB.md): [CosmosDB.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/CosmosDB.m#L215)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L283)
* [Data Virtuality LDW](../connectors/DataVirtuality.md): [DataVirtuality.m line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DataVirtuality/DataVirtuality.m#L42)
* [Digital Construction Works Insights](../connectors/DCWInsights.md): [DCWInsights.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DCWInsights/DCWInsights.m#L26)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 464](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L464)
* [Denodo](../connectors/Denodo.md): [DenodoForPowerBI.m line 101](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/DenodoForPowerBI.m#L101)
* [Dremio](../connectors/Dremio.md): [Dremio.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L13), [DremioAdbcDataSource.pqm line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L115)
* [Eduframe](../connectors/Eduframe.md): [Requests.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L27)
* [Entersoft Business Suite](../connectors/EntersoftBusinessSuite.md): [Entersoft_Business_Suite.m line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L35)
* [EQuIS](../connectors/EQuIS.md): [EQuIS.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L64)
* [eWay-CRM](../connectors/eWayCRM.md): [eWay_CRM.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L13)
* [Exasol](../connectors/Exasol.md): [Exasol.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Exasol.pq#L85)
* [SQL database](../connectors/FabricSql.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L131)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L95)
* [Funnel](../connectors/Funnel.md): [DataLoading.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/DataLoading.pqm#L18)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L105)
* [InformationGrid](../connectors/InformationGrid.md): [InformationGrid.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L35)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L93)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L81)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L259)
* [JethroDataConnector](../connectors/JethroData1.0.1.md): [JethroODBC.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JethroData1.0.1/JethroODBC.m#L27)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 399](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L399)
* [Lakehouse](../connectors/LakeHouse.md): [LakeHouse.pq line 2881](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L2881), [MDSync.pqm line 691](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L691), [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.PrivateLink.pqm#L131)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L99)
* [Linkar PICK Style / MultiValue Databases](../connectors/Linkar.md): [LinkarConnector.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Linkar/LinkarConnector.pq#L155)
* [LinkedInLearning](../connectors/LinkedInLearning.md): [LinkedInLearning.pq line 359](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LinkedInLearning/LinkedInLearning.pq#L359)
* [MariaDB](../connectors/MariaDB.md): [MariaDB.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/MariaDB.m#L108)
* [MarkLogic](../connectors/MarkLogicODBC.md): [MarkLogicODBC.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/MarkLogicODBC.m#L132)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L102)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [MongoDBAtlasODBC.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L55)
* [OneLake Files](../connectors/OneLakeFile.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L431), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L131)
* [OneLakeSql](../connectors/OneLakeSql.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L131)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [OpenSearchProject.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/OpenSearchProject.m#L38)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 215](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L215)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L260)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Fabric.GetClusterUrl.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L13), [PowerPlatformDataflows.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L217), [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L131)
* [QubolePresto](../connectors/QubolePresto.md): [QubolePresto.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/QubolePresto.m#L92)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L33)
* [Roamler](../connectors/Roamler.md): [Roamler.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Roamler/Roamler.m#L8)
* [Samsara](../connectors/Samsara.md): [Samsara.Credentials.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Credentials.pqm#L4)
* [Sentinel](../connectors/Sentinel.md): [Sentinel.pq line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Sentinel/Sentinel.pq#L105)
* [Shortcuts Business Insights](../connectors/ShortcutsBI.md): [ShortcutsBI.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/ShortcutsBI.pq#L30)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L153)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L43)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L139)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 196](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L196)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L293)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [SurveyMonkey.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L66)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 400](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L400)
* [TeamDesk.PowerBI.DataConnector](../connectors/TeamDesk.PowerBI.DataConnector.md): [TeamDesk.m line 266](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L266)
* [TIBCO.ODBC.TDV](../connectors/TIBCO.md): [TIBCO.ODBC.TDV.m line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TIBCO/TIBCO.ODBC.TDV.m#L61)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L241)
* [Vena](../connectors/Vena.md): [Vena.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L52)
* [Warehouse](../connectors/Warehouse.md): [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L431), [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.DLP.pqm#L61), [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L131)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 1057](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L1057)
* [Workforce Dimensions](../connectors/WorkforceDimensions.md): [WorkforceDimensions.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkforceDimensions/WorkforceDimensions.m#L96)

<!-- seen-in:end -->
