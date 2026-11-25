---
type: Power Query Connector
title: OneLake Files
description: Power BI connector source for OneLake Files.
tags: [aad, buffering, credentials, diagnostics, errors, packaging, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.2.13
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq
  title: OneLakeFile.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeFile/1.2.13/OneLakeFile_1.2.13.pqx
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
| Microsoft | 1.2.13 | Aad |

# Source files

* [OneLakeFile.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L295) — `handledStatuses = List.Buffer(List.Transform(Record.FieldNames(Record.RemoveFields(handlers, "Error")), Number.From)),`
    * [Workspace.pqm line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L187) — `workspaceIds = List.Buffer(GetTestConnectionWorkspaceIds(dlpPolicies)),`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L432) — `Extension.CurrentCredential(forceRefreshOfTokens) <> null, // Force refresh of token.`
    * [Utils.pqm line 493](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L493) — `finalTokenValue = if tokenValue = "" then Diagnostics.Trace(TraceLevel.Error, [Name = "GetCredential/CredentialPropertyNotFound", Data = [], SafeData = [CredentialProperty = Text.Combine({prop, propWithSlash}, ",")]], currentCredentials[access_token]) else tokenValue,`
    * [Workspace.PrivateLink.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L127) — `serviceAccessToken = Extension.CurrentCredential()[Properties]?[ServiceAccessToken]?,`
    * [Workspace.PrivateLink.pqm line 150](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L150) — `token = Utils[GetCredential](AadWorkspaceApiOAuthResource)[access_token],`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [OneLakeFile.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L213) — `error Diagnostics.Trace(`
    * [OneLakeFile.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L214) — `TraceLevel.Error,`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Table.NavigationTableView.pqm line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L68) — `Diagnostics.Trace(TraceLevel.Information, [Name = "NavigationTableView/OnSelectRows/FoldingFailure", Data = [], SafeData = [DueToError = triedData[HasError]]], default)`
    * [Utils.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L56) — `tracedMessage = Diagnostics.Trace(`
    * [Utils.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L57) — `TraceLevel.Error,`
    * [Workspace.PrivateLink.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L37) — `catch(e) => error Diagnostics.Trace(`
    * [Workspace.PrivateLink.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L38) — `TraceLevel.Information,`
    * [Workspace.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L18) — `error Diagnostics.Trace(`
    * [Workspace.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L19) — `TraceLevel.Error,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [OneLakeFile.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L144) — `Documentation.FieldCaption = Extension.LoadString("OneLakeFile_PathCaption"),`
    * [OneLakeFile.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L137) — `shared OneLake.Contents = Value.ReplaceType(OneLakeFileImpl, OneLakeFile.Type);`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [OneLakeFile.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L12) — `binary = Extension.Contents(name),`
    * [Utils.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L47) — `Text.Format(Extension.LoadString("TraceMessageWithDetails"), {piiFreeLogMessage, errorMessage})`
    * [Workspace.PrivateLink.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L46) — `Utils[NonPii](Extension.LoadString("UrlParseError")),`
    * [Workspace.pqm line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L23) — `Extension.LoadString("NoWorkspacesAvailable"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Table.NavigationTableView.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L55) — `viewException.IsMarked = (errorRecord) => Record.FieldCount( Value.Metadata( Value.Type(errorRecord[Reason]?) ) ) > 0`
    * [Utils.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L4) — `IsNonPii = (x) => Value.Metadata(x)[Is.Pii]? = false,`
    * [Utils.pqm line 304](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L304) — `responseStatus = Value.Metadata(response)[Response.Status]? ?? 200,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [OneLakeFile.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L15) — `context = if additionalContext = null then baseContext`
    * [Table.NavigationTableView.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L21) — `if value is list then`
    * [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L231) — `else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [Utils.pqm line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L407) — `if state[Iteration] < count then Function.InvokeAfter(() => state, #duration(0, 0, 0, delay(state[Iteration])))`
    * [Utils.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L8) — `nextDepth = if depth = null then 3 else depth - 1,`
    * [Workspace.PrivateLink.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L25) — `if Text.Contains(PBIBaseUrl, "powerbistagingapi") then`
    * [Workspace.pqm line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L143) — `TestConnectionPrivateLinkTimeout = #duration(0, 0, 0, 5),`
    * [Workspace.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L45) — `allWorkspaces = if List.IsEmpty(jsonResponse[value]) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [OneLakeFile.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L137) — `shared OneLake.Contents = Value.ReplaceType(OneLakeFileImpl, OneLakeFile.Type);`
    * [OneLakeFile.pq line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L152) — `ReturnType = type table`
    * [Table.NavigationTableView.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L40) — `type table Type.ForRecord(List.Accumulate(tableKeys, [], (r, f) => Record.AddField(r, f, [Type=if f = "Data" then type table else type any, Optional=false])), false),`
    * [Utils.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L17) — `else if value is type then List.First(Table.Schema(#table({"type"}, {{value}}))[TypeName], "<type>")`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [OneLakeFile.pq line 177](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L177) — `catch () => error Error.Record("Expression.Error", Extension.LoadString("CurrentWorkspaceNotResolved"))`
    * [OneLakeFile.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L18) — `try`
    * [Table.NavigationTableView.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L28) — `error "Unexpected descriptor value for '" & key & "'",`
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L66) — `Error.Record(`
    * [Utils.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L21) — `try result catch (e) => @Value.ToText(e, nextDepth),`
    * [Workspace.PrivateLink.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L44) — `Error.Record(`
    * [Workspace.PrivateLink.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm#L14) — `Utils = try #shared[Utils] otherwise`
    * [Workspace.pqm line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L123) — `unableToResolveCurrentWorkspace = Table.ViewError(Error.Record(`
    * [Workspace.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm#L5) — `Utils = try #shared[Utils] otherwise error "Module Utils not found in shared context. Ensure the Utils module is loaded.",`
* [Table.View handlers](../patterns/table-view.md)
  * **Uncertain match (older review)**
    * [Table.NavigationTableView.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L57) — `Table.View(null, [`
    * [Table.NavigationTableView.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm#L58) — `GetType = () => tableType,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Utils.pqm line 303](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L303) — `response = Web.Contents(url, moreOptions & [IsRetry = state[Iteration] > 0]),`
