---
type: Power Query Connector
title: Warehouse
description: Import Warehouse
tags: [aad, credentials, diagnostics, errors, packaging, parameter-metadata, response-metadata, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.2.48
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/FabricEnvironment.pqm
  title: FabricEnvironment.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm
  title: OutputInterceptor.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm
  title: Utils.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq
  title: Warehouse.pq
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm
  title: WarehouseOutputInterceptor.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Warehouse/1.2.48/Warehouse_1.2.48.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T17:23:17Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.2.48 | Aad |

# Source files

* [FabricEnvironment.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/FabricEnvironment.pqm)
* [OutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm)
* [Warehouse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq)
* [WarehouseOutputInterceptor.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm)

# Pattern evidence

* [Actions and table mutation handlers](../patterns/actions.md)
  * **Uncertain match (older review)**
    * [OutputInterceptor.pqm line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm#L128) — `else TableAction.InsertRows(`
    * [WarehouseOutputInterceptor.pqm line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L39) — `Action.Sequence({`
    * [WarehouseOutputInterceptor.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L66) — `OnInsertRows = (rowsToInsert) =>`
* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L295) — `handledStatuses = List.Buffer(List.Transform(Record.FieldNames(Record.RemoveFields(handlers, "Error")), Number.From)),`
    * [WarehouseOutputInterceptor.pqm line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L80) — `versionsToAdd = List.Buffer(rowsToInsert[Version]),`
    * [Workspace.pqm line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L187) — `workspaceIds = List.Buffer(GetTestConnectionWorkspaceIds(dlpPolicies)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L432) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null, // Force refresh of token.`
    * [Utils.pqm line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L493) — `finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,`
    * [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm#L61) — `credential = Extension.CurrentCredential(),`
    * [Workspace.PrivateLink.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L127) — `serviceAccessToken = Extension.CurrentCredential()[Properties]?[ServiceAccessToken]?,`
    * [Workspace.PrivateLink.pqm line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L150) — `token = Utils[GetCredential](AadWorkspaceApiOAuthResource)[access_token],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L56) — `tracedMessage = Diagnostics.Trace(`
    * [Utils.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L57) — `TraceLevel.Error,`
    * [Warehouse.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L49) — `Diagnostics.Trace(`
    * [Warehouse.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L50) — `TraceLevel.Information,`
    * [WarehouseOutputInterceptor.pqm line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L130) — `Diagnostics.Trace(`
    * [WarehouseOutputInterceptor.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L131) — `TraceLevel.Information,`
    * [Workspace.PrivateLink.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L37) — `catch(e) => error Diagnostics.Trace(`
    * [Workspace.PrivateLink.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L38) — `TraceLevel.Information,`
    * [Workspace.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L18) — `error Diagnostics.Trace(`
    * [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L19) — `TraceLevel.Error,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Warehouse.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L213) — `Documentation.FieldCaption = Extension.LoadString("Warehouse.Fields.HierarchicalNavigation.FieldCaption")`
    * [Warehouse.pq line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L194) — `shared Fabric.Warehouse = Value.ReplaceType(WarehouseImpl, Warehouse.Type);`
    * [Warehouse.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L218) — `WarehouseType = type function (optional options as WarehouseOptions)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L47) — `Text.Format(Extension.LoadString("TraceMessageWithDetails"), {piiFreeLogMessage, errorMessage})`
    * [Warehouse.pq line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L6) — `binary = Extension.Contents(name),`
    * [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm#L86) — `Message = NonPii(Extension.LoadString("WorkspaceAccessDeniedByDlpPolicy")),`
    * [Workspace.PrivateLink.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L46) — `Utils[NonPii](Extension.LoadString("UrlParseError")),`
    * [Workspace.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L23) — `Extension.LoadString("NoWorkspacesAvailable"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L55) — `viewException.IsMarked = (errorRecord) => Record.FieldCount( Value.Metadata( Value.Type(errorRecord[Reason]?) ) ) > 0`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L4) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false,`
    * [Utils.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L304) — `responseStatus = Value.Metadata(response)[Response.Status]? ?? 200,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [OutputInterceptor.pqm line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm#L115) — `VersionKey = (prefix, version) => SafeKey(if prefix <> null then {prefix, "OI", "V", version} else {"OI", "V", version}),`
    * [Table.NavigationTableView.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L21) — `if value is list then`
    * [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L231) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [Utils.pqm line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L407) — `if state[Iteration] < count then Function.InvokeAfter(() => state, #duration(0, 0, 0, delay(state[Iteration])))`
    * [Utils.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L8) — `nextDepth = if depth = null then 3 else depth - 1,`
    * [Warehouse.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L9) — `context = if additionalContext = null`
    * [WarehouseOutputInterceptor.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L42) — `if result[HasError] then`
    * [Workspace.DLP.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm#L24) — `if (dlpPoliciesJson = null) then`
    * [Workspace.PrivateLink.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L25) — `if Text.Contains(PBIBaseUrl, "powerbistagingapi") then`
    * [Workspace.pqm line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L143) — `TestConnectionPrivateLinkTimeout = #duration(0, 0, 0, 5),`
    * [Workspace.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L45) — `allWorkspaces = if List.IsEmpty(jsonResponse[value]) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [OutputInterceptor.pqm line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm#L270) — `[Phase = "Created", Schema = schema]`
    * [Table.NavigationTableView.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L40) — `type table Type.ForRecord(List.Accumulate(tableKeys, [], (r, f) => Record.AddField(r, f, [Type=if f = "Data" then type table else type any, Optional=false])), false),`
    * [Utils.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L17) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
    * [Warehouse.pq line 194](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L194) — `shared Fabric.Warehouse = Value.ReplaceType(WarehouseImpl, Warehouse.Type);`
    * [Warehouse.pq line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L104) — `Schema =  navigation{4}?[Schema]?,`
    * [WarehouseOutputInterceptor.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L19) — `[Schema = parts{0}, Name = parts{1}],`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [OutputInterceptor.pqm line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm#L138) — `error Error.Record("Expression.Error", code, detail, null, code),`
    * [OutputInterceptor.pqm line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/OutputInterceptor.pqm#L138) — `error Error.Record("Expression.Error", code, detail, null, code),`
    * [Table.NavigationTableView.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L28) — `error "Unexpected descriptor value for '" & key & "'",`
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L66) — `Error.Record(`
    * [Utils.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L21) — `try result catch (e) => @Value.ToText(e, nextDepth),`
    * [Warehouse.pq line 310](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L310) — `error Table.ViewError(Error.Record(`
    * [Warehouse.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L13) — `try`
    * [WarehouseOutputInterceptor.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L3) — `try #shared[OutputInterceptorCreate]`
    * [Workspace.DLP.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.DLP.pqm#L27) — `try`
    * [Workspace.PrivateLink.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L44) — `Error.Record(`
    * [Workspace.PrivateLink.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.PrivateLink.pqm#L14) — `Utils = try #shared[Utils] otherwise`
    * [Workspace.pqm line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L123) — `unableToResolveCurrentWorkspace = Table.ViewError(Error.Record(`
    * [Workspace.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Workspace.pqm#L5) — `Utils = try #shared[Utils] otherwise error "Module Utils not found in shared context. Ensure the Utils module is loaded.",`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L57) — `Table.View(null, [`
    * [Table.NavigationTableView.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Table.NavigationTableView.pqm#L58) — `GetType = () => tableType,`
    * [Warehouse.pq line 340](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L340) — `Table.View(withoutSystemTables,[`
    * [Warehouse.pq line 345](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Warehouse.pq#L345) — `OnSelectRows = (selector) => Table.SelectRows(nav, selector), // Prevent the "sys" schema predicate from blocking folding`
    * [WarehouseOutputInterceptor.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L65) — `view = Table.View(addData(allVersions()), [`
    * [WarehouseOutputInterceptor.pqm line 168](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L168) — `GetType = () => Value.Type(database),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Utils.pqm line 303](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Warehouse/Utils.pqm#L303) — `response = Web.Contents(url, moreOptions & [IsRetry = state[Iteration] > 0]),`
