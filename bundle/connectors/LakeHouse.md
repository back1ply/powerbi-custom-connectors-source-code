---
type: Power Query Connector
title: Lakehouse
description: Import data from a Lakehouse
tags: [aad, actions, buffering, credentials, diagnostics, errors, navigation, packaging, parameter-metadata, response-metadata, retry-polling, schema, table-view, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.264
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm
  title: DeltaTableFastCopy.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm
  title: DualTable.View.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq
  title: LakeHouse.pq
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm
  title: MDSync.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm
  title: SparkCompute.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm
  title: SparkComputeUtils.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm
  title: SqlGenerator.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm
  title: SqlGeneratorCommon.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/TypeInfo.pqm
  title: TypeInfo.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm
  title: Utils.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/LakeHouse/1.0.264/LakeHouse_1.0.264.pqx
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
| Microsoft | 1.0.264 | Aad |

# Source files

* [DeltaTableFastCopy.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm)
* [DualTable.View.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm)
* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/FabricEnvironment.pqm)
* [LakeHouse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq)
* [MDSync.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm)
* [SparkCompute.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm)
* [SparkComputeUtils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm)
* [SqlGenerator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm)
* [SqlGeneratorCommon.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm)
* [TypeInfo.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/TypeInfo.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm)

# Pattern evidence

* [Actions and table mutation handlers](../patterns/actions.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L220) — `insertActions = Action.Sequence({`
    * [LakeHouse.pq line 884](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L884) — `Action.Sequence({`
    * [LakeHouse.pq line 824](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L824) — `else Table.View(Table.SelectRows(nav, selector), [OnDeleteRows = () => DeleteRows(selector)]),`
    * [MDSync.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L112) — `Action.Sequence({`
    * [SparkCompute.pqm line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L364) — `executeSparkAction = Action.Sequence(`
* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L58) — `() => [i = 0, result = try Table.Buffer(OneLake.Contents(url)), shouldContinue = true],`
    * [LakeHouse.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L96) — `LakehouseCacheFile = (workspaceId as text, lakehouseId as text, cacheKey as text, isMsit as logical) => Binary.Buffer(OneLake.FileContents(Text.Format(OneLakeFilesContentPathFormat, {OneLakeFilesPathBaseUrl(cloud, isMsit), workspaceId, lakehouseId, cacheKey})));`
    * [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L295) — `handledStatuses = List.Buffer(List.Transform(Record.FieldNames(Record.RemoveFields(handlers, "Error")), Number.From)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [LakeHouse.pq line 2881](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L2881) — `currentCredentials = Extension.CurrentCredential(),`
    * [LakeHouse.pq line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L285) — `token = GetCredential(AadWorkspaceApiOAuthResource)[access_token],`
    * [MDSync.pqm line 691](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L691) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null // Force refresh of token.`
    * [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L431) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null, // Force refresh of token.`
    * [Utils.pqm line 492](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L492) — `finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,`
    * [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm#L61) — `credential = Extension.CurrentCredential(),`
    * [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L131) — `serviceAccessToken = Extension.CurrentCredential()[Properties]?[ServiceAccessToken]?,`
    * [Workspace.PrivateLink.pqm line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L154) — `token = Utils[GetCredential](AadWorkspaceApiOAuthResource)[access_token],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L12) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "UtilsModuleLoadError", Data = []], e),`
    * [DeltaTableFastCopy.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L12) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "UtilsModuleLoadError", Data = []], e),`
    * [DualTable.View.pqm line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L80) — `Diagnostics.Trace(`
    * [DualTable.View.pqm line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L81) — `TraceLevel.Information,`
    * [LakeHouse.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L46) — `Diagnostics.Trace(`
    * [LakeHouse.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L47) — `TraceLevel.Information,`
    * [MDSync.pqm line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L78) — `Diagnostics.Trace(`
    * [MDSync.pqm line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L79) — `TraceLevel.Warning,`
    * [SparkCompute.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L13) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "UtilsModuleLoadError", Data = []], e),`
    * [SparkCompute.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L13) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "UtilsModuleLoadError", Data = []], e),`
    * [SparkComputeUtils.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L3) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "ModuleLoadError", Data = []], e),`
    * [SparkComputeUtils.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L3) — `error Diagnostics.Trace(TraceLevel.Error, [Name = "ModuleLoadError", Data = []], e),`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L56) — `tracedMessage = Diagnostics.Trace(`
    * [Utils.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L57) — `TraceLevel.Error,`
    * [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L41) — `catch(e) => error Diagnostics.Trace(`
    * [Workspace.PrivateLink.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L42) — `TraceLevel.Information,`
    * [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L19) — `error Diagnostics.Trace(`
    * [Workspace.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L20) — `TraceLevel.Error,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L30) — `Function.Atomic = (n, f) => let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [DualTable.View.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L27) — `let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [LakeHouse.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L117) — `Documentation.FieldCaption = Extension.LoadString("Lakehouse.Fields.HierarchicalNavigation.FieldCaption")`
    * [LakeHouse.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L112) — `shared Lakehouse.Contents = Value.ReplaceType(LakehouseView, LakehouseType);`
    * [LakeHouse.pq line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L132) — `functionType = type function (optional options as LakehouseOptions)`
    * [SparkCompute.pqm line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L35) — `Function.Atomic = (n, f) => let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [Table.ToNavigationTable.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm#L32) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Native queries](../patterns/native-query.md)
  * **Uncertain match (older review)**
    * [DeltaTableFastCopy.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L45) — `deltaLogPublishingEnabled = Value.NativeQuery(sqlInstance, checkDeltaLogStatusQuery)`
    * [DualTable.View.pqm line 277](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L277) — `modifiedTable1 = Value.NativeQuery(`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [LakeHouse.pq line 315](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L315) — `nav = Table.ToNavigationTable(withIsLeaf, {keyName}, "lakehouseName", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm#L17) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [LakeHouse.pq line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L117) — `Documentation.FieldCaption = Extension.LoadString("Lakehouse.Fields.HierarchicalNavigation.FieldCaption")`
    * [MDSync.pqm line 356](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L356) — `catch (e) => ThrowMetadataSyncErrors(prefix & "ProgressDetail", Extension.LoadString("MetadataRefreshParseResponseError"),`
    * [SparkCompute.pqm line 413](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L413) — `Extension.LoadString("LakehouseSparkSessionUnavailable"),`
    * [SparkComputeUtils.pqm line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L212) — `Extension.LoadString("LakehouseSparkStatementExecutionError"),`
    * [SqlGenerator.pqm line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm#L114) — `binary = Extension.Contents(name), asText = Text.FromBinary(binary)`
    * [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L47) — `Text.Format(Extension.LoadString("TraceMessageWithDetails"), {piiFreeLogMessage, errorMessage})`
    * [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm#L86) — `Message = NonPii(Extension.LoadString("WorkspaceAccessDeniedByDlpPolicy")),`
    * [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L50) — `Utils[NonPii](Extension.LoadString("UrlParseError")),`
    * [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L24) — `Extension.LoadString("NoWorkspacesAvailable"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [DualTable.View.pqm line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L79) — `if Value.Metadata(Value.Type(function))[Documentation.Name]? = "DualTable.Expressions" then`
    * [LakeHouse.pq line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L76) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false;`
    * [MDSync.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L34) — `headers = Value.Metadata(response)[Headers]? ?? [],`
    * [MDSync.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L34) — `headers = Value.Metadata(response)[Headers]? ?? [],`
    * [SparkComputeUtils.pqm line 267](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L267) — `responseValue = Json.Document(response) meta Value.Metadata(response),`
    * [SqlGeneratorCommon.pqm line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm#L290) — `else if(Value.Metadata(valuetype)[recordtype]? = "FunctionOverrides") then Value.AssertFunctionOverrides(value,valuetype)`
    * [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L55) — `viewException.IsMarked = (errorRecord) => Record.FieldCount( Value.Metadata( Value.Type(errorRecord[Reason]?) ) ) > 0`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L4) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false,`
    * [Utils.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L304) — `responseStatus = Value.Metadata(response)[Response.Status]? ?? 200,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L66) — `Function.InvokeAfter(`
    * [DeltaTableFastCopy.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L50) — `OneLakeContentsRetryDelay = #duration(0, 0, 0, 5),`
    * [DeltaTableFastCopy.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L65) — `result = if shouldContinue then`
    * [DualTable.View.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L24) — `if (List.IsEmpty(List.Select(equalityComparers, each _ <> Value.Equals))) then null`
    * [LakeHouse.pq line 2848](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L2848) — `(DateTimeZone.RemoveZone(DateTimeZone.UtcNow()) - [Date modified] > #duration(0, 0, 0, CacheTrimDuration))),`
    * [LakeHouse.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L54) — `DeltaLake.Options = (options) => [Compression=Compression.Snappy] & (if options[EnableVorder]? = null then [] else [PreserveOrder=not options[EnableVorder]]);`
    * [MDSync.pqm line 596](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L596) — `Function.InvokeAfter(() => Submit(iteration + 1, false), Diagnostics.Trace(TraceLevel.Information, [Name = prefix & "LockConflict/NothingInProgress/Retry",`
    * [MDSync.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L295) — `batchTimeout = [timeout = Duration.ToText(#duration(0, 0, 0, MaxDMSBatchDuration))],`
    * [MDSync.pqm line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L36) — `value = if List.IsEmpty(matchingNames) then null else Record.Field(headers, matchingNames{0})`
    * [SparkCompute.pqm line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L161) — `if schemaName <> "default" then`
    * [SparkComputeUtils.pqm line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L161) — `Function.InvokeAfter(`
    * [SparkComputeUtils.pqm line 172](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L172) — `#duration(0,0,0, 15))`
    * [SparkComputeUtils.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L24) — `retryCount = if maxCount = null then 3 else maxCount - 1,`
    * [SqlGenerator.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGenerator.pqm#L3) — `AddUnsignedAttribute = Table.AddColumn(TypeInfo, "UnsignedAttribute", each if [Unsigned] = true then 1 else 0),`
    * [SqlGeneratorCommon.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm#L83) — `sqlast = if(ast[Arguments]{0}[Value]{0} = null) then UnaryLogicalOperation("IsNull",sqlastarg2)`
    * [Table.NavigationTableView.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L21) — `if value is list then`
    * [Table.ToNavigationTable.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm#L15) — `if tagsColumn <> null then`
    * [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L231) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [Utils.pqm line 406](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L406) — `if state[Iteration] < count then Function.InvokeAfter(() => state, #duration(0, 0, 0, delay(state[Iteration])))`
    * [Utils.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L8) — `nextDepth = if depth = null then 3 else depth - 1,`
    * [Workspace.DLP.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm#L24) — `if (dlpPoliciesJson = null) then`
    * [Workspace.PrivateLink.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L29) — `if Text.Contains(PBIBaseUrl, "powerbistagingapi") then`
    * [Workspace.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L46) — `allWorkspaces = if List.IsEmpty(jsonResponse[value]) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L30) — `Function.Atomic = (n, f) => let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [DeltaTableFastCopy.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L304) — `tableSchema = Table.Schema(deltaTableBeingModified),`
    * [DualTable.View.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L27) — `let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [LakeHouse.pq line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L112) — `shared Lakehouse.Contents = Value.ReplaceType(LakehouseView, LakehouseType);`
    * [LakeHouse.pq line 166](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L166) — `LakehouseNavTableType = type table [`
    * [MDSync.pqm line 338](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L338) — `changedTypeForStartTimestamp = Table.TransformColumnTypes(asTable, {{"startTimeStamp", type datetime}}), // represent as datetime`
    * [SparkCompute.pqm line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L35) — `Function.Atomic = (n, f) => let f = Table.ViewFunction(f) in Value.ReplaceType(f, Value.Type(f) meta [Documentation.Name = n]),`
    * [SparkCompute.pqm line 261](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L261) — `newType = type table Type.ForRecord(Record.FromTable(transformed), false)`
    * [SqlGeneratorCommon.pqm line 298](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm#L298) — `fieldnamesfromvalue = Table.Column(Table.Schema(value),"Name"),`
    * [Table.NavigationTableView.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L40) — `type table Type.ForRecord(List.Accumulate(tableKeys, [], (r, f) => Record.AddField(r, f, [Type=if f = "Data" then type table else type any, Optional=false])), false),`
    * [Table.ToNavigationTable.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.ToNavigationTable.pqm#L32) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Utils.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L17) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DeltaTableFastCopy.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DeltaTableFastCopy.pqm#L11) — `Utils = try #shared[Utils] catch(e) =>`
    * [DualTable.View.pqm line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L143) — `error`
    * [LakeHouse.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L192) — `error Table.ViewError(Error.Record(`
    * [LakeHouse.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L68) — `GetPlatformVersion = () => try Number.From(Text.Split(Module.Versions()[Core], "."){1}) otherwise 0;`
    * [MDSync.pqm line 460](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L460) — `then error Error.Record(Utils[NonPii]("DataSource.Error"), Utils[NonPii](Extension.LoadString("MetadataRefreshErrorWithDetail")), errorDetail, errorVariables)`
    * [MDSync.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/MDSync.pqm#L18) — `Utils = try #shared[Utils] otherwise`
    * [SparkCompute.pqm line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L411) — `error Error.Record(`
    * [SparkCompute.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkCompute.pqm#L12) — `Utils = try #shared[Utils] catch(e) =>`
    * [SparkComputeUtils.pqm line 210](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L210) — `error Error.Record(`
    * [SparkComputeUtils.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SparkComputeUtils.pqm#L2) — `Utils = try #shared[Utils] catch(e) =>`
    * [SqlGeneratorCommon.pqm line 289](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/SqlGeneratorCommon.pqm#L289) — `else if(Type.Is(valuetype,type record)<> true) then error "Type provided is not a record type"`
    * [Table.NavigationTableView.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L28) — `error "Unexpected descriptor value for '" & key & "'",`
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L66) — `Error.Record(`
    * [Utils.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L21) — `try result catch (e) => @Value.ToText(e, nextDepth),`
    * [Workspace.DLP.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.DLP.pqm#L27) — `try`
    * [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L48) — `Error.Record(`
    * [Workspace.PrivateLink.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.PrivateLink.pqm#L17) — `Utils = try #shared[Utils] otherwise`
    * [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L124) — `unableToResolveCurrentWorkspace = Table.ViewError(Error.Record(`
    * [Workspace.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Workspace.pqm#L5) — `Utils = try #shared[Utils] otherwise error "Module Utils not found in shared context. Ensure the Utils module is loaded.",`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [DualTable.View.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L30) — `Table.View(null,`
    * [DualTable.View.pqm line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/DualTable.View.pqm#L35) — `GetType = () => Value.Type(valueTable),`
    * [LakeHouse.pq line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L145) — `view = (x) => Table.View(null, Handlers((op, transform) =>`
    * [LakeHouse.pq line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/LakeHouse.pq#L216) — `GetType = () => Value.Type(emptyTable),`
    * [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L57) — `Table.View(null, [`
    * [Table.NavigationTableView.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Table.NavigationTableView.pqm#L58) — `GetType = () => tableType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Utils.pqm line 303](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/LakeHouse/Utils.pqm#L303) — `response = Web.Contents(url, moreOptions & [IsRetry = state[Iteration] > 0]),`
