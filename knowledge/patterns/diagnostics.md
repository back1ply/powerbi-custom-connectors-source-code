---
type: Power Query Pattern
title: Diagnostic tracing
description: Tracing values while preserving return and error behavior.
category: Schema and errors
tags: [schema-and-errors]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: [\bDiagnostics\.Trace\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm#L1
  title: Actian/Diagnostics.pqm
---

**Draft: awaiting human review.**

# Mechanism

Actian's `Diagnostics.LogValue` converts a value to text for its message and returns the original value through `Diagnostics.Trace`. `LogValue2` accepts a separate result expression and an optional delayed flag, so the logged representation and returned computation do not have to be the same object.[^example]

`LogFailure` evaluates a function under `try`. On failure it logs the error and uses a delayed function that raises that error again; on success it returns `result[Value]`. `WrapHandlers` applies this behavior to each field in a handler record through `WrapFunctionResult`.[^example]

# Adaptation and failure paths

Check whether a wrapper preserves evaluation timing as well as its return value. The delayed error expression is part of this implementation's propagation behavior. Replacing it with an eagerly evaluated error or a null value would change the operation being observed.[^example]

Review message contents before adding tracing around credentials or whole HTTP payloads. The serializer has a record branch that visits record fields and serializes their values; the excerpt does not show credential-field masking. Prefer deliberate diagnostic fields over passing arbitrary records to a generic serializer, and verify that conversion failures do not conceal the original operation's failure.[^example]

See [credential access](credentials.md), [structured errors](errors.md), and [buffering](buffering.md).

# Examples

The following excerpt is copied from `Actian/Diagnostics.pqm`, lines 1–11.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
let
    Diagnostics.LogValue = (prefix, value) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), value),
    Diagnostics.LogValue2 = (prefix, value, result, optional delayed) => Diagnostics.Trace(TraceLevel.Information, prefix & ": " & Diagnostics.ValueToText(value), result, delayed),    
    Diagnostics.LogFailure = (text, function) =>
        let
            result = try function()
        in
            if result[HasError] then Diagnostics.LogValue2(text, result[Error], () => error result[Error], true) else result[Value],

    Diagnostics.WrapFunctionResult = (innerFunction as function, outerFunction as function) as function =>
        Function.From(Value.Type(innerFunction), (list) => outerFunction(() => Function.Invoke(innerFunction, list))),
```

[^example]: Actian/Diagnostics.pqm; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **51** connectors in this archive.

* [Actian](../connectors/Actian.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Actian/Diagnostics.pqm#L2)
* [Amazon OpenSearch Service](../connectors/AmazonOpenSearchService.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonOpenSearchService/Diagnostics.pqm#L2)
* [AnaplanConnector](../connectors/Anaplan.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Diagnostics.pqm#L2)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 346](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L346)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/Diagnostics.pqm#L2)
* [Azure Cosmos DB for MongoDB vCore](../connectors/AzureCosmosDBForMongoDBvCore.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L3)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 2445](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L2445), [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/Diagnostics.pqm#L2)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/Diagnostics.pqm#L5)
* [Solver](../connectors/BI360.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Diagnostics.pqm#L2)
* [Bloomberg](../connectors/Bloomberg.md): [Diagnostics.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Diagnostics.pqm#L13)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L145), [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/Diagnostics.pqm#L3)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 1080](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L1080)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/Diagnostics.pqm#L3)
* [ClickHouse](../connectors/ClickHouse.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ClickHouse/Diagnostics.pqm#L2)
* [CosmosDB](../connectors/CosmosDB.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CosmosDB/Diagnostics.pqm#L2)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L164), [Diagnostics.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm#L19)
* [Denodo](../connectors/Denodo.md): [Diagnostics.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Denodo/Diagnostics.pqm#L32)
* [Dremio](../connectors/Dremio.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Diagnostics.pqm#L3), [Dremio.pq line 1047](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/Dremio.pq#L1047)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/Diagnostics.pqm#L2)
* [Exasol](../connectors/Exasol.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Exasol/Diagnostics.pqm#L2)
* [SQL database](../connectors/FabricSql.md): [FabricSql.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/FabricSql.pq#L290), [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Workspace.pqm#L19)
* [FHIR](../connectors/Fhir.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Diagnostics.pqm#L2), [Fhir.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L78), [Folding.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Folding.pqm#L295)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [ParametricFilter.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L8), [SelectList.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L8), [Typecast.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L8), [UoM.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L8)
* [Indexima](../connectors/Indexima.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Diagnostics.pqm#L2)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/Diagnostics.pqm#L2)
* [InformationGrid](../connectors/InformationGrid.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/Diagnostics.pqm#L2)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/Diagnostics.pqm#L2)
* [inwink](../connectors/inwink.md): [inwink.pq line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L92)
* [InterSystems IRIS](../connectors/IRIS.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Diagnostics.pqm#L2)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L5)
* [KylinDirectQuery](../connectors/Kyligence.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kyligence/Diagnostics.pqm#L2)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/Diagnostics.pqm#L3)
* [Lakehouse](../connectors/LakeHouse.md): [DeltaTableFastCopy.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DeltaTableFastCopy.pqm#L12), [DualTable.View.pqm line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DualTable.View.pqm#L80), [LakeHouse.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L46), [MDSync.pqm line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L78), [SparkCompute.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkCompute.pqm#L13), [SparkComputeUtils.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkComputeUtils.pqm#L3), [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Workspace.pqm#L19)
* [MariaDB](../connectors/MariaDB.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MariaDB/Diagnostics.pqm#L2)
* [MarkLogic](../connectors/MarkLogicODBC.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MarkLogicODBC/Diagnostics.pqm#L2)
* [MongoDB Atlas SQL](../connectors/MongoDBAtlasODBC.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MongoDBAtlasODBC/Diagnostics.pqm#L2)
* [OneLake Files](../connectors/OneLakeFile.md): [OneLakeFile.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/OneLakeFile.pq#L213), [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Workspace.pqm#L19)
* [OneLakeSql](../connectors/OneLakeSql.md): [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Workspace.pqm#L19)
* [OpenSearch Project](../connectors/OpenSearchProject.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OpenSearchProject/Diagnostics.pqm#L2)
* [Datamarts](../connectors/PowerBIDatamarts.md): [PowerBIDatamarts.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L187)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Cdsa.Workspace.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L28), [Fabric.GetClusterUrl.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L26), [PowerPlatformDataflows.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L230), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L56), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L41)
* [QubolePresto](../connectors/QubolePresto.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QubolePresto/Diagnostics.pqm#L2)
* [Samsara](../connectors/Samsara.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Diagnostics.pqm#L3), [Samsara.Client.ErrorTranslation.pqm line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.ErrorTranslation.pqm#L117), [Samsara.Metrics.LogEvent.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Metrics.LogEvent.pqm#L27), [Samsara.Metrics.ReportCount.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Metrics.ReportCount.pqm#L29), [Samsara.Metrics.ReportError.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Metrics.ReportError.pqm#L17), [Samsara.Metrics.ReportNumber.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Metrics.ReportNumber.pqm#L29), [Samsara.Table.Fetch.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Table.Fetch.pqm#L83)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/Diagnostics.pqm#L2)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L163)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L63)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/Diagnostics.pqm#L2)
* [Azure Synapse Analytics workspace](../connectors/Synapse.md): [Synapse.pq line 415](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Synapse/Synapse.pq#L415)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Diagnostics.pqm#L2)
* [Warehouse](../connectors/Warehouse.md): [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Table.NavigationTableView.pqm#L68), [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L56), [Warehouse.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Warehouse.pq#L49), [WarehouseOutputInterceptor.pqm line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L119), [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.PrivateLink.pqm#L41), [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Workspace.pqm#L19)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2)

<!-- seen-in:end -->
