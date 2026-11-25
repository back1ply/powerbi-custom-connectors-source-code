---
type: Power Query Connector
title: Dataflows
description: Import data from a dataflow
tags: [aad, buffering, credentials, diagnostics, errors, native-query, navigation, packaging, pagination, retry-polling, schema, table-view, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.1.35
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm
  title: Cdsa.Workspace.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm
  title: Fabric.GetClusterUrl.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq
  title: PowerPlatformDataflows.pq
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm
  title: Utils.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PowerPlatformDataflows/3.1.35/PowerPlatformDataflows_3.1.35.pqx
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
| Microsoft | 3.1.35 | Aad |

# Source files

* [Cdsa.Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm)
* [Fabric.GetClusterUrl.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm)
* [PowerPlatformDataflows.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L295) — `handledStatuses = List.Buffer(List.Transform(Record.FieldNames(Record.RemoveFields(handlers, "Error")), Number.From)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Fabric.GetClusterUrl.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L13) — `props = (Extension.CurrentCredential()[Properties]? ?? []) & Extension.CurrentApplication(),`
    * [PowerPlatformDataflows.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L217) — `else Extension.CurrentCredential(),`
    * [PowerPlatformDataflows.pq line 565](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L565) — `currentCredentials & [access_token = Record.FieldOrDefault(currentCredentials[Properties], prop, currentCredentials[access_token])];`
    * [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L432) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null, // Force refresh of token.`
    * [Utils.pqm line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L493) — `finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,`
    * [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L61) — `credential = Extension.CurrentCredential(),`
    * [Workspace.PrivateLink.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L127) — `serviceAccessToken = Extension.CurrentCredential()[Properties]?[ServiceAccessToken]?,`
    * [Workspace.PrivateLink.pqm line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L150) — `token = Utils[GetCredential](AadWorkspaceApiOAuthResource)[access_token],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Cdsa.Workspace.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L28) — `filteredWorkspaces = Diagnostics.Trace(TraceLevel.Information,`
    * [Cdsa.Workspace.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L28) — `filteredWorkspaces = Diagnostics.Trace(TraceLevel.Information,`
    * [Fabric.GetClusterUrl.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L26) — `clusterUrl = Diagnostics.Trace(TraceLevel.Information, [`
    * [Fabric.GetClusterUrl.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L26) — `clusterUrl = Diagnostics.Trace(TraceLevel.Information, [`
    * [PowerPlatformDataflows.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L230) — `credential = Diagnostics.Trace(TraceLevel.Information,`
    * [PowerPlatformDataflows.pq line 230](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L230) — `credential = Diagnostics.Trace(TraceLevel.Information,`
    * [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L56) — `tracedMessage = Diagnostics.Trace(`
    * [Utils.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L57) — `TraceLevel.Error,`
    * [Workspace.PrivateLink.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L37) — `catch(e) => error Diagnostics.Trace(`
    * [Workspace.PrivateLink.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L38) — `TraceLevel.Information,`
* [Native queries](../patterns/native-query.md)
  * **Match from a review of older source**
    * [PowerPlatformDataflows.pq line 1727](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1727) — `Value.NativeQuery(`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Cdsa.Workspace.pqm line 243](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L243) — `nav = Table.ToNavigationTable(withIsLeaf, {"dataflowId"}, "dataflowName", "Data", "Tags", "ItemKind", "ItemName", "IsLeaf")`
    * [PowerPlatformDataflows.pq line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L197) — `nav = Table.ToNavigationTable(withIsLeaf, {"Id"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm#L17) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [PowerPlatformDataflows.pq line 1015](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1015) — `blobList = List.Combine(List.Generate(`
    * [Utils.pqm line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L226) — `list = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [PowerPlatformDataflows.pq line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L150) — `Documentation.Name = Extension.LoadString("DataSourceLabel"),`
    * [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L47) — `Text.Format(Extension.LoadString("TraceMessageWithDetails"), {piiFreeLogMessage, errorMessage})`
    * [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L86) — `Message = NonPii(Extension.LoadString("WorkspaceAccessDeniedByDlpPolicy")),`
    * [Workspace.PrivateLink.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L46) — `Utils[NonPii](Extension.LoadString("UrlParseError")),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L12) — `previousMeta = Value.Metadata(tableType),`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L4) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false,`
    * [Utils.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L304) — `responseStatus = Value.Metadata(response)[Response.Status]? ?? 200,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [Cdsa.Workspace.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L18) — `if isMwcRefresh then`
    * [Fabric.GetClusterUrl.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L8) — `GetTenantIdRequestHeader = (tenantId as nullable text) => if tenantId <> null then [#"x-ms-tid" = tenantId] else [],`
    * [PowerPlatformDataflows.pq line 1731](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1731) — `[CommandTimeout = #duration(1, 0, 0, 0)]),`
    * [PowerPlatformDataflows.pq line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L176) — `if List.Contains({"GetRows", "GetType", "GetRowCount", "GetExpression", "OnTestConnection"}, op) then transform(x(invoke))`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.NavigationTableView.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L19) — `if value is list`
    * [Table.ToNavigationTable.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm#L15) — `if tagsColumn <> null then`
    * [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L231) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [Utils.pqm line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L407) — `if state[Iteration] < count then Function.InvokeAfter(() => state, #duration(0, 0, 0, delay(state[Iteration])))`
    * [Utils.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L8) — `nextDepth = if depth = null then 3 else depth - 1,`
    * [Workspace.DLP.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L24) — `if (dlpPoliciesJson = null) then`
    * [Workspace.PrivateLink.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L25) — `if Text.Contains(PBIBaseUrl, "powerbistagingapi") then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Cdsa.Workspace.pqm line 236](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L236) — `withData = Table.AddColumn(dataflows, "Data", each getNavTableForDataflow(baseUrl, workspaceId, workspaceType, [dataflowId], options), type table),`
    * [PowerPlatformDataflows.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L144) — `shared PowerPlatform.Dataflows = Value.ReplaceType(DataflowsView, DataflowsType);`
    * [PowerPlatformDataflows.pq line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L128) — `#table(type table [T = text, M = type, S = text], {`
    * [Table.ChangeType.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L44) — `changedPrimatives = Table.TransformColumnTypes(reordered, primativeTransforms, culture),`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.ToNavigationTable.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ToNavigationTable.pqm#L32) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Utils.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L17) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Cdsa.Workspace.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Cdsa.Workspace.pqm#L4) — `Table.NavigationTableView = try #shared[Table.NavigationTableView] otherwise error "Internal Error: Table.NavigationTableView not found in shared context. Ensure the module is loaded with the correct context.",`
    * [Fabric.GetClusterUrl.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Fabric.GetClusterUrl.pqm#L3) — `Utils = try #shared[Utils] otherwise error "Module Utils not found in shared context. Ensure the Utils module is loaded.",`
    * [PowerPlatformDataflows.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L249) — `error Error.Record(`
    * [PowerPlatformDataflows.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L249) — `error Error.Record(`
    * [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L27) — `error Error.Record("Error.Parameter", "table argument is a list, but not a list of records", [ ValueType = firstValueType ])`
    * [Table.ChangeType.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.ChangeType.pqm#L5) — `if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else`
    * [Table.NavigationTableView.pqm line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L52) — `index = try getIndex(selector, keyColumns) otherwise [],`
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L66) — `Error.Record(`
    * [Utils.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L21) — `try result catch (e) => @Value.ToText(e, nextDepth),`
    * [Workspace.DLP.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.DLP.pqm#L27) — `try`
    * [Workspace.PrivateLink.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L44) — `Error.Record(`
    * [Workspace.PrivateLink.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Workspace.PrivateLink.pqm#L14) — `Utils = try #shared[Utils] otherwise`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [PowerPlatformDataflows.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L175) — `view = (x) => Table.View(null, Handlers((op, transform) =>`
    * [PowerPlatformDataflows.pq line 379](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L379) — `GetType = () => type table [dataflowId=text, dataflowName=text, description=nullable text],`
    * [Table.NavigationTableView.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L47) — `Table.View(null, [`
    * [Table.NavigationTableView.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Table.NavigationTableView.pqm#L48) — `GetType = () => tableType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [PowerPlatformDataflows.pq line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1011) — `response = Xml.Tables(Web.Contents(uri, [ManualCredentials = true, CredentialQuery = sas])),`
    * [Utils.pqm line 303](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerPlatformDataflows/Utils.pqm#L303) — `response = Web.Contents(url, moreOptions & [IsRetry = state[Iteration] > 0]),`
