---
type: Power Query Connector
title: SmartsheetGlobal
description: Power BI connector source for SmartsheetGlobal.
tags: [diagnostics, oauth, packaging, parameter-metadata, response-metadata, retry-polling, web-requests]
x-pqkb-publisher: Smartsheet
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq
  title: SmartsheetGlobal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SmartsheetGlobal/1.1.1/SmartsheetGlobal_1.1.1.pqx
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
| Smartsheet | 1.1.1 | OAuth |

# Source files

* [SmartsheetGlobal.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L163) — `Diagnostics.Trace(TraceLevel.Warning, "'" & Text.From(value) & "' is below the minimum for " & valueName & ". Clamping value to " & Text.From(min), min)`
    * [SmartsheetGlobal.pq line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L163) — `Diagnostics.Trace(TraceLevel.Warning, "'" & Text.From(value) & "' is below the minimum for " & valueName & ". Clamping value to " & Text.From(min), min)`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 563](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L563) — `Documentation.FieldCaption = "Region",`
    * [SmartsheetGlobal.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L5) — `shared SmartsheetGlobal.Query = Value.ReplaceType(Smartsheet.QueryInternal, QueryFunctionType);`
    * [SmartsheetGlobal.pq line 572](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L572) — `t = type function (region as RegionParameterType, optional options as nullable record) as table`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Uncertain match (older review)**
    * [SmartsheetGlobal.pq line 468](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L468) — `navTable = Table.ToNavigationTable(withWorkspaces, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [SmartsheetGlobal.pq line 476](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L476) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [SmartsheetGlobal.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L18) — `OAuth = [`
    * [SmartsheetGlobal.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L19) — `StartLogin = StartLogin,`
    * [SmartsheetGlobal.pq line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L20) — `FinishLogin = FinishLogin,`
    * [SmartsheetGlobal.pq line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L87) — `grant_type = "authorization_code",`
    * [SmartsheetGlobal.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L81) — `Response = Web.Contents(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L51) — `ButtonText = {Extension.LoadString("FormulaTitle"), Extension.LoadString("FormulaHelp")},`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L250) — `status = Value.Metadata(result)[Response.Status],`
    * [SmartsheetGlobal.pq line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L93) — `Headers = [#"Content-type" = "application/x-www-form-urlencoded", Accept = "application/json"]`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L221) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [SmartsheetGlobal.pq line 291](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L291) — `#duration(0, 0, 0, delay);`
    * [SmartsheetGlobal.pq line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L162) — `if value < min then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [SmartsheetGlobal.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L5) — `shared SmartsheetGlobal.Query = Value.ReplaceType(Smartsheet.QueryInternal, QueryFunctionType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Uncertain match (older review)**
    * [SmartsheetGlobal.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L34) — `GetEndpointRecord = (region as text) as record => try Endpoints{[RegionCode = region]} otherwise error Error.Record("Expression.Error", "Unexpected region value: " & region);`
    * [SmartsheetGlobal.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L34) — `GetEndpointRecord = (region as text) as record => try Endpoints{[RegionCode = region]} otherwise error Error.Record("Expression.Error", "Unexpected region value: " & region);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [SmartsheetGlobal.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L81) — `Response = Web.Contents(`
