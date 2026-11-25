---
type: Power Query Connector
title: OneLakeSql
description: Power BI connector source for OneLakeSql.
tags: [aad, buffering, credentials, diagnostics, errors, packaging, parameter-metadata, response-metadata, table-view, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.24
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq
  title: OneLakeSql.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm
  title: Workspace.DLP.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeSql/1.0.24/OneLakeSql_1.0.24.pqx
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
| Microsoft | 1.0.24 | Aad |

# Source files

* [OneLakeSql.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm)
* [Workspace.DLP.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L295) — `handledStatuses = List.Buffer(List.Transform(Record.FieldNames(Record.RemoveFields(handlers, "Error")), Number.From)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Utils.pqm line 431](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L431) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null, // Force refresh of token.`
    * [Utils.pqm line 492](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L492) — `finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,`
    * [Workspace.DLP.pqm line 61](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm#L61) — `credential = Extension.CurrentCredential(),`
    * [Workspace.PrivateLink.pqm line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L131) — `serviceAccessToken = Extension.CurrentCredential()[Properties]?[ServiceAccessToken]?,`
    * [Workspace.PrivateLink.pqm line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L154) — `token = Utils[GetCredential](AadWorkspaceApiOAuthResource)[access_token],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L56) — `tracedMessage = Diagnostics.Trace(`
    * [Utils.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L57) — `TraceLevel.Error,`
    * [Workspace.PrivateLink.pqm line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L41) — `catch(e) => error Diagnostics.Trace(`
    * [Workspace.PrivateLink.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L42) — `TraceLevel.Information,`
    * [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L19) — `error Diagnostics.Trace(`
    * [Workspace.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L20) — `TraceLevel.Error,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [OneLakeSql.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L138) — `Documentation.FieldCaption = Extension.LoadString("OneLakeSql_WorkspaceCaption"),`
    * [OneLakeSql.pq line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L131) — `shared OneLake.SqlAnalytics  = Value.ReplaceType(OneLakeSqlImpl, OneLakeSql.Type);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [OneLakeSql.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L11) — `binary = Extension.Contents(name),`
    * [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L47) — `Text.Format(Extension.LoadString("TraceMessageWithDetails"), {piiFreeLogMessage, errorMessage})`
    * [Workspace.DLP.pqm line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm#L86) — `Message = NonPii(Extension.LoadString("WorkspaceAccessDeniedByDlpPolicy")),`
    * [Workspace.PrivateLink.pqm line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L50) — `Utils[NonPii](Extension.LoadString("UrlParseError")),`
    * [Workspace.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L24) — `Extension.LoadString("NoWorkspacesAvailable"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L55) — `viewException.IsMarked = (errorRecord) => Record.FieldCount( Value.Metadata( Value.Type(errorRecord[Reason]?) ) ) > 0`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L4) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false,`
    * [Utils.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L304) — `responseStatus = Value.Metadata(response)[Response.Status]? ?? 200,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [OneLakeSql.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L14) — `context = if additionalContext = null`
    * [Table.NavigationTableView.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L21) — `if value is list then`
    * [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L231) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [Utils.pqm line 406](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L406) — `if state[Iteration] < count then Function.InvokeAfter(() => state, #duration(0, 0, 0, delay(state[Iteration])))`
    * [Utils.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L8) — `nextDepth = if depth = null then 3 else depth - 1,`
    * [Workspace.DLP.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm#L24) — `if (dlpPoliciesJson = null) then`
    * [Workspace.PrivateLink.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L29) — `if Text.Contains(PBIBaseUrl, "powerbistagingapi") then`
    * [Workspace.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L46) — `allWorkspaces = if List.IsEmpty(jsonResponse[value]) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [OneLakeSql.pq line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L131) — `shared OneLake.SqlAnalytics  = Value.ReplaceType(OneLakeSqlImpl, OneLakeSql.Type);`
    * [OneLakeSql.pq line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L154) — `ReturnType = type table`
    * [Table.NavigationTableView.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L40) — `type table Type.ForRecord(List.Accumulate(tableKeys, [], (r, f) => Record.AddField(r, f, [Type=if f = "Data" then type table else type any, Optional=false])), false),`
    * [Utils.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L17) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [OneLakeSql.pq line 115](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L115) — `catch () => error Error.Record("Expression.Error", Extension.LoadString("CannotResolveCurrentWorkspace"))`
    * [OneLakeSql.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L18) — `try`
    * [Table.NavigationTableView.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L28) — `error "Unexpected descriptor value for '" & key & "'",`
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L66) — `Error.Record(`
    * [Utils.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L21) — `try result catch (e) => @Value.ToText(e, nextDepth),`
    * [Workspace.DLP.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.DLP.pqm#L27) — `try`
    * [Workspace.PrivateLink.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L48) — `Error.Record(`
    * [Workspace.PrivateLink.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.PrivateLink.pqm#L17) — `Utils = try #shared[Utils] otherwise`
    * [Workspace.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L124) — `unableToResolveCurrentWorkspace = Table.ViewError(Error.Record(`
    * [Workspace.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Workspace.pqm#L5) — `Utils = try #shared[Utils] otherwise error "Module Utils not found in shared context. Ensure the Utils module is loaded.",`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [OneLakeSql.pq line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L244) — `Table.View(withoutSystemTables,[`
    * [OneLakeSql.pq line 245](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/OneLakeSql.pq#L245) — `OnSelectRows = (selector) => Table.SelectRows(sqlAnalytics, selector), // Prevent the "sys" schema predicate from blocking folding`
    * [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L57) — `Table.View(null, [`
    * [Table.NavigationTableView.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Table.NavigationTableView.pqm#L58) — `GetType = () => tableType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Utils.pqm line 303](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeSql/Utils.pqm#L303) — `response = Web.Contents(url, moreOptions & [IsRetry = state[Iteration] > 0]),`
