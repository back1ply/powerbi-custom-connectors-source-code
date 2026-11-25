---
type: Power Query Connector
title: HexagonSmartApi
description: Power BI connector source for HexagonSmartApi.
tags: [diagnostics, errors, oauth, oauth2, odata, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Hexagon
x-pqkb-version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m
  title: HexagonSmartApi.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm
  title: OAuth.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm
  title: ParametricFilter.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm
  title: SelectList.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm
  title: Typecast.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm
  title: UoM.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/HexagonSmartApi/1.2.1/HexagonSmartApi_1.2.1.pqx
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
| Hexagon | 1.2.1 | OAuth |

# Source files

* [HexagonSmartApi.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm)
* [ParametricFilter.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm)
* [SelectList.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm)
* [Typecast.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm)
* [UoM.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [ParametricFilter.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L8) — `(traceLevel as number, message as anynonnull, value, optional delayed) => Diagnostics.Trace(traceLevel, message, value, false)`
    * [ParametricFilter.pqm line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L52) — `navTableFuncType = Diagnostics.LogValue(TraceLevel.Information, "ParaFilter.GenerateNavTableFilterFunction: navTableFuncTypeDefTmp => " & navTableFuncTypeDefTmp,`
    * [SelectList.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L8) — `(traceLevel as number, message as anynonnull, value, optional delayed) => Diagnostics.Trace(traceLevel, message, value, false)`
    * [SelectList.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L46) — `navTableFuncType = Diagnostics.LogValue(TraceLevel.Verbose, "navTableFuncTypeDef: " & navTableFuncTypeDefTmp, navTableFuncTypeDefTmp, false),`
    * [Typecast.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L8) — `(traceLevel as number, message as anynonnull, value, optional delayed) => Diagnostics.Trace(traceLevel, message, value, false)`
    * [Typecast.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L66) — `Diagnostics.LogValue(TraceLevel.Information, "Typecast.GetTablePath: " & odataId{0}[Value], odataId{0}[Value], false)`
    * [UoM.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L8) — `(traceLevel as number, message as anynonnull, value, optional delayed) => Diagnostics.Trace(traceLevel, message, value, false)`
    * [UoM.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L65) — `navTableFuncType = Diagnostics.LogValue(TraceLevel.Verbose, "navTableFuncTypeDef: " & navTableFuncTypeDefTmp, navTableFuncTypeDefTmp, false),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L52) — `uriType = Uri.Type meta [Documentation.FieldCaption = Extension.LoadString("HexagonSmartApi.Feed.Parameter.url.FieldCaption"),`
    * [HexagonSmartApi.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L50) — `shared HexagonSmartApi.Feed = Value.ReplaceType(SmartApiFeedImpl, SmartApiFeedType);`
    * [HexagonSmartApi.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L65) — `SmartApiFeedType = type function (url as uriType, optional headers as headersType, optional odataFeedVersion as odataFeedVersion) as table`
    * [ParametricFilter.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L55) — `navTableFuncWithDoc = Value.ReplaceType(navTableFunc, navTableFuncTypeWithDoc)`
    * [SelectList.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L24) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
    * [Typecast.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L28) — `TypecastFuncTypeWithDoc = type function (typecastTarget as (type any meta [Documentation.FieldCaption = "typecastTarget"]),`
    * [Typecast.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L24) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
    * [Typecast.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L28) — `TypecastFuncTypeWithDoc = type function (typecastTarget as (type any meta [Documentation.FieldCaption = "typecastTarget"]),`
    * [UoM.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L27) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L145) — `OAuth = [`
    * [HexagonSmartApi.m line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L146) — `StartLogin = OAuth.StartLogin,`
    * [HexagonSmartApi.m line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L147) — `FinishLogin = OAuth.FinishLogin,`
    * [HexagonSmartApi.m line 189](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L189) — `result = Xml.Tables(Web.Contents(validUrl,`
    * [OAuth.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L18) — `OAuth.StartLogin = (resourceUrl, state, display) =>`
    * [OAuth.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L42) — `OAuth.FinishLogin = (context, callbackUri, state) =>`
    * [OAuth.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L59) — `grant_type = "refresh_token",`
    * [OAuth.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L57) — `refreshTokenResponse = try Json.Document(Web.Contents(tokenUrl, [`
    * [ParametricFilter.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L31) — `Source = Json.Document(Web.Contents(url, wcOpt3))`
    * [SelectList.pqm line 439](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L439) — `response = Web.Contents(selectListItemTarget,`
    * [UoM.pqm line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L125) — `unitData = Web.Contents(uomServiceUrl, options),`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L108) — `content = OData.Feed(validUrl, headerRecord, oDataOptions),`
    * [UoM.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L33) — `Source = OData.Feed(uomServiceUrl, null, [ODataVersion = 4.0, Implementation="2.0"]),`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [ParametricFilter.pqm line 786](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L786) — `Table.GenerateByPage((previous) =>`
    * [ParametricFilter.pqm line 791](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L791) — `page = if (nextLink <> null) then GetPage(nextLink, body as binary) else null`
    * [SelectList.pqm line 471](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L471) — `pageTable = Table.GenerateByPage((previous) =>`
    * [SelectList.pqm line 479](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L479) — `page = if (nextLink <> null) then`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L52) — `uriType = Uri.Type meta [Documentation.FieldCaption = Extension.LoadString("HexagonSmartApi.Feed.Parameter.url.FieldCaption"),`
    * [OAuth.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L8) — `client_id_tmp = Text.FromBinary(Extension.Contents("client_id")),`
    * [Typecast.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L31) — `Documentation.LongDescription = Extension.LoadString("TypecastFunc.Documentation.LongDescription")],`
    * [UoM.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L14) — `uomServiceUrl_tmp = Text.FromBinary(Extension.Contents("uom_service")),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L131) — `sourceTypeMetadata = Value.Metadata(Value.Type(source)),`
    * [HexagonSmartApi.m line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L191) — `Headers = headerRecord,`
    * [OAuth.pqm line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L102) — `descriptionJson = if Value.Metadata(descriptionDocument)[Response.Status] = 200 then`
    * [OAuth.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L65) — `Headers = [`
    * [ParametricFilter.pqm line 561](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L561) — `md = Value.Metadata(filterRecord),`
    * [ParametricFilter.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L22) — `wcOpt1 = [Headers=hr2],`
    * [SelectList.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L18) — `sourceTypeMetadata = Value.Metadata(Value.Type(source)),`
    * [SelectList.pqm line 440](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L440) — `[Headers = [#"Content-Type"="application/json",`
    * [Typecast.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L18) — `sourceTypeMetadata = Value.Metadata(Value.Type(source)),`
    * [UoM.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L21) — `sourceTypeMetadata = Value.Metadata(Value.Type(source)),`
    * [UoM.pqm line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L126) — `responseStatusTmp = Value.Metadata(unitData)[Response.Status],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L50) — `shared HexagonSmartApi.Feed = Value.ReplaceType(SmartApiFeedImpl, SmartApiFeedType);`
    * [ParametricFilter.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L55) — `navTableFuncWithDoc = Value.ReplaceType(navTableFunc, navTableFuncTypeWithDoc)`
    * [ParametricFilter.pqm line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L71) — `filterSource = if (Type.Is(Value.Type(inputFilterSource), type record) = true) or (Type.Is(Value.Type(inputFilterSource), type table) = true) then`
    * [SelectList.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L24) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
    * [SelectList.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L64) — `selectListTarget = if (Type.Is(Value.Type(inputSelectListTarget), type table)) then`
    * [Typecast.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L24) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
    * [Typecast.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L37) — `typecastTarget = if (Type.Is(Value.Type(inputTypecastTarget), type table)) then`
    * [UoM.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L27) — `newDestination = Value.ReplaceType(destination, newDestinationType)`
    * [UoM.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L83) — `uomTarget = if (Type.Is(Value.Type(unitsOfMeasureTarget), type table)) then`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L92) — `otherwise error Error.Record("Error",`
    * [HexagonSmartApi.m line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L91) — `try ParseHeaders(headers)`
    * [OAuth.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L46) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [OAuth.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L9) — `client_id = if (Text.Length(Text.Trim(client_id_tmp)) > 0)  then client_id_tmp else error "Missing client ID in client_id file",`
    * [ParametricFilter.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L83) — `error Error.Record("Error", "Source is not a filter record or table type", "")`
    * [ParametricFilter.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L12) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error "Url scheme must be HTTPS" else url,`
    * [SelectList.pqm line 324](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L324) — `error error Error.Record("Error", "Single tenant entity container has more than one select list", ""),`
    * [SelectList.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L12) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error "Url scheme must be HTTPS" else url,`
    * [Typecast.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm#L12) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error "Url scheme must be HTTPS" else url,`
    * [UoM.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L12) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error "Url scheme must be HTTPS" else url,`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [HexagonSmartApi.m line 189](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L189) — `result = Xml.Tables(Web.Contents(validUrl,`
    * [HexagonSmartApi.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L192) — `RelativePath = "$metadata"`
    * [OAuth.pqm line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm#L57) — `refreshTokenResponse = try Json.Document(Web.Contents(tokenUrl, [`
    * [ParametricFilter.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L31) — `Source = Json.Document(Web.Contents(url, wcOpt3))`
    * [SelectList.pqm line 439](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm#L439) — `response = Web.Contents(selectListItemTarget,`
    * [UoM.pqm line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L125) — `unitData = Web.Contents(uomServiceUrl, options),`
    * [UoM.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm#L124) — `RelativePath = path],`
