---
type: Power Query Connector
title: FactSetAnalytics
description: Power BI connector source for FactSetAnalytics.
tags: [errors, navigation, oauth, oauth2, packaging, parameter-metadata, pkce, response-metadata, retry-polling, usernamepassword, web-requests]
x-pqkb-publisher: FactSet
x-pqkb-version: 2.6.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq
  title: FactSetAnalytics.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm
  title: api-factset-analytics-calculations-deprecated.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm
  title: api-factset-analytics-calculations.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm
  title: api-factset-analytics-request.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm
  title: api-factset-analytics-util.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm
  title: api-factset-analytics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm
  title: api-factset-irn.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm
  title: api-formula.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm
  title: convert-stach.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm
  title: request-long-running.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm
  title: request-pagination.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm
  title: request-request.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-api-loader.pqm
  title: util-api-loader.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm
  title: util-convert-to-table.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm
  title: util-deep-merge.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm
  title: util-oauth.pqm
- id: file-17
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm
  title: util-throttled-function-iterator.pqm
- id: file-18
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm
  title: util-unpivot-other-columns.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetAnalytics/2.6.2/FactSetAnalytics_2.6.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| FactSet | 2.6.2 | OAuth, UsernamePassword |

# Source files

* [FactSetAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq)
* [api-factset-analytics-calculations-deprecated.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm)
* [api-factset-analytics-calculations.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm)
* [api-factset-analytics-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm)
* [api-factset-analytics-util.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm)
* [api-factset-analytics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm)
* [api-factset-irn.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm)
* [api-formula.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm)
* [convert-stach.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm)
* [request-long-running.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm)
* [request-pagination.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm)
* [request-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm)
* [util-api-loader.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-api-loader.pqm)
* [util-convert-to-table.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm)
* [util-deep-merge.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm)
* [util-oauth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm)
* [util-throttled-function-iterator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm)
* [util-unpivot-other-columns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L395) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [api-factset-analytics-calculations-deprecated.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L8) — `Documentation.FieldCaption = "Component Identifier",`
    * [api-factset-analytics-calculations-deprecated.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L4) — `FactSetAnalytics.v3.RunPACalculation = Value.ReplaceType(runPAV3CalculationImpl, runPAV3CalculationType),`
    * [api-factset-analytics-calculations-deprecated.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L6) — `runPAV3CalculationType = type function (`
    * [api-factset-analytics-calculations.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L6) — `Documentation.FieldCaption = "Cached Output Age in minutes",`
    * [api-factset-analytics-calculations.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L2) — `FactSetAnalytics.v3.RunPACalculation = Value.ReplaceType(newRunPAV3CalculationImpl, newRunPAV3CalculationType),`
    * [api-factset-analytics-calculations.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L4) — `newRunPAV3CalculationType = type function (`
    * [api-factset-analytics.pqm line 156](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L156) — `Documentation.FieldCaption = "Publisher Document",`
    * [api-factset-analytics.pqm line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L152) — `FactSetAnalytics.Datastore.V1.GetSwivelAsOfDate = Value.ReplaceType(GetSwivelAsOfDateImpl, GetSwivelAsOfDateType),`
    * [api-factset-analytics.pqm line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L154) — `GetSwivelAsOfDateType = type function (`
    * [api-factset-irn.pqm line 525](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L525) — `FactSetIRN.V1.GetNotes = Value.ReplaceType(FactSetIRN.V1.GetNotesImpl, FactSetIRN.V1.GetNotesType),`
    * [api-factset-irn.pqm line 526](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L526) — `FactSetIRN.V1.GetNotesType = type function (`
    * [api-formula.pqm line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L108) — `Documentation.FieldCaption = "List of FQL formulas.",`
    * [api-formula.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L63) — `GetTimeSeriesByIds = Value.ReplaceType(`
    * [api-formula.pqm line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L97) — `type function (`
    * [convert-stach.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm#L11) — `StachV2RowOrganizedTable = Value.ReplaceType(`
    * [convert-stach.pqm line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm#L88) — `type function (Source as record, optional delimiter as text) as table meta [`
    * [util-convert-to-table.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm#L38) — `Value.ReplaceType(`
    * [util-convert-to-table.pqm line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm#L49) — `type function (data as any) as any meta [`
    * [util-deep-merge.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm#L27) — `Value.ReplaceType(`
    * [util-deep-merge.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm#L29) — `type function (record1 as record, record2 as record) as record meta [`
    * [util-throttled-function-iterator.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L26) — `Documentation.FieldCaption = "Function to be called by the iterator"`
    * [util-throttled-function-iterator.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L2) — `ThrottledFunctionIterator = Value.ReplaceType(`
    * [util-throttled-function-iterator.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L22) — `type function (`
    * [util-unpivot-other-columns.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm#L1) — `Value.ReplaceType(`
    * [util-unpivot-other-columns.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm#L10) — `type function (inputTable as table, prefixPivotCols as list, attributeName as text, valueName as text) as table meta [`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L134) — `NavTable = Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [FactSetAnalytics.pq line 389](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L389) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L10) — `OAuth = [`
    * [FactSetAnalytics.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L74) — `Web.Contents(`
    * [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31) — `response = Web.Contents(Url, [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = Query]),`
    * [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111) — `response = Web.Contents(ENGINES_V3_URL & "pa/v3/calculations", [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = [pageNumber = page]]),`
    * [api-factset-irn.pqm line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L144) — `response = Web.Contents(`
    * [request-long-running.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L51) — `statusResponse = Web.Contents(`
    * [request-request.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L46) — `response = Web.Contents(url, requestOptions),`
    * [util-oauth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L56) — `StartLogin = (resourceUrl, state, display) =>`
    * [util-oauth.pqm line 110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L110) — `FinishLogin = (context, callbackUri, state) =>`
    * [util-oauth.pqm line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L89) — `grant_type = grantType,`
    * [util-oauth.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L33) — `response = Web.Contents(`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Uncertain match (older review)**
    * [api-factset-analytics-util.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L11) — `list = List.Generate(`
    * [api-factset-analytics.pqm line 1110](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1110) — `page = if pageNumber is null then "1" else Text.From(pageNumber),`
    * [request-long-running.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L4) — `list = List.Generate(`
    * [request-pagination.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm#L3) — `List.Generate(`
    * [request-pagination.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm#L19) — `currentPage[meta][pagination][next] ?? "endOfPages",`
    * [util-oauth.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L15) — `GenerateList = List.Generate(`
    * [util-throttled-function-iterator.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L6) — `List.Generate(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [util-oauth.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L69) — `code_challenge = CreateCodeChallenge(codeVerifier),`
    * [util-oauth.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L83) — `codeVerifier = if (verifier <> null) then [code_verifier = verifier] else [],`
    * [util-oauth.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L26) — `hash = Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L34) — `Analytics.AdditionalHeadersFromCi = Extension.LoadString("AdditionalHeadersFromCi");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L78) — `Headers = [`
    * [api-factset-analytics-request.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L32) — `responseHeaders = Value.Metadata(response)[Headers],`
    * [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31) — `response = Web.Contents(Url, [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = Query]),`
    * [api-factset-analytics-util.pqm line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L97) — `responseHeaders = Value.Metadata(response)[Headers],`
    * [api-factset-analytics-util.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L59) — `#"Headers" = Table.ToList(#"ColumnRows"),`
    * [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111) — `response = Web.Contents(ENGINES_V3_URL & "pa/v3/calculations", [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = [pageNumber = page]]),`
    * [api-factset-irn.pqm line 145](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L145) — `API_HOST_IRN_V1 & "notes?" & IncludeLastActivityDateParam, [Headers = AdditionalHeaders]`
    * [api-formula.pqm line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L92) — `Headers = [#"X-FactSet-Connector-Origin" = "Formula.GetTimeSeriesByIds"],`
    * [request-long-running.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L18) — `status = Value.Metadata(Response)[Response.Status],`
    * [request-long-running.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L18) — `status = Value.Metadata(Response)[Response.Status],`
    * [request-request.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L47) — `status = Value.Metadata(response)[Response.Status],`
    * [request-request.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L37) — `Headers = headers,`
    * [util-oauth.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L40) — `responseHeaders = Value.Metadata(response)[Headers],`
    * [util-oauth.pqm line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L36) — `Headers = [#"Accept" = "application/json", #"X-FactSet-Connector-Version" = Settings[XFactSetConnectorVersion]],`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L35) — `Analytics.AdditionalHeaders = if Analytics.AdditionalHeadersFromCi <> "null" then Record.Combine({Analytics.AdditionalHeadersBase, Json.Document(Text.FromBinary(Extension.Contents(Analytics.AdditionalHeadersFromCi)))})`
    * [api-factset-analytics-calculations-deprecated.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L75) — `accounts = if _accountid is null and _accountholdingsmode is null then null else {[`
    * [api-factset-analytics-calculations.pqm line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L96) — `accountIdList = if _accountid is null then null else {_accountid},`
    * [api-factset-analytics-request.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L74) — `status =  Value.WaitFor(`
    * [api-factset-analytics-request.pqm line 87](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L87) — `(iteration) => #duration(0, 0, 0, 5))`
    * [api-factset-analytics-request.pqm line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L35) — `result = if status = 200 then HandleCalculationV3ADSResult(json)`
    * [api-factset-analytics-util.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L14) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => Producer(state{0}), Interval(state{0}))},`
    * [api-factset-analytics-util.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L14) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => Producer(state{0}), Interval(state{0}))},`
    * [api-factset-analytics.pqm line 200](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L200) — `pubdoc = if _pubDocInput is null then "" else _pubDocInput,`
    * [api-factset-irn.pqm line 202](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L202) — `if Table.HasColumns(#"Pivoted codeValue", "emptyCustomField") then`
    * [api-formula.pqm line 680](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L680) — `if endpoint = "Time-Series" then`
    * [convert-stach.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm#L20) — `if tableHasHiddenRows then`
    * [request-long-running.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L11) — `{1 + state{0}, Function.InvokeAfter(() => Producer(state{0}), Interval(state{0}))},`
    * [request-long-running.pqm line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L81) — `#duration(0, 0, 0, longRunningDelay)`
    * [request-long-running.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L8) — `if state{1} <> null then`
    * [request-pagination.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm#L16) — `if (currentPage = null) then`
    * [request-request.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L26) — `if Record.HasFields(options ?? [], "Query") then`
    * [util-convert-to-table.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm#L9) — `if currFieldValue is record then`
    * [util-deep-merge.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm#L15) — `if field1 is record and field2 is record then`
    * [util-oauth.pqm line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L43) — `if status = 200 then`
    * [util-throttled-function-iterator.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L9) — `(state) => {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [util-throttled-function-iterator.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L15) — `#duration(0, 0, 0, if Number.Mod(index, iterations_before_wait) = 0 then seconds_to_wait else 0),`
    * [util-throttled-function-iterator.pqm line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L15) — `#duration(0, 0, 0, if Number.Mod(index, iterations_before_wait) = 0 then seconds_to_wait else 0),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [FactSetAnalytics.pq line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L395) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [api-factset-analytics-calculations-deprecated.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L4) — `FactSetAnalytics.v3.RunPACalculation = Value.ReplaceType(runPAV3CalculationImpl, runPAV3CalculationType),`
    * [api-factset-analytics-calculations.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L2) — `FactSetAnalytics.v3.RunPACalculation = Value.ReplaceType(newRunPAV3CalculationImpl, newRunPAV3CalculationType),`
    * [api-factset-analytics.pqm line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L152) — `FactSetAnalytics.Datastore.V1.GetSwivelAsOfDate = Value.ReplaceType(GetSwivelAsOfDateImpl, GetSwivelAsOfDateType),`
    * [api-factset-irn.pqm line 525](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L525) — `FactSetIRN.V1.GetNotes = Value.ReplaceType(FactSetIRN.V1.GetNotesImpl, FactSetIRN.V1.GetNotesType),`
    * [api-formula.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm#L63) — `GetTimeSeriesByIds = Value.ReplaceType(`
    * [convert-stach.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm#L11) — `StachV2RowOrganizedTable = Value.ReplaceType(`
    * [util-convert-to-table.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm#L38) — `Value.ReplaceType(`
    * [util-deep-merge.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm#L27) — `Value.ReplaceType(`
    * [util-throttled-function-iterator.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L2) — `ThrottledFunctionIterator = Value.ReplaceType(`
    * [util-unpivot-other-columns.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm#L1) — `Value.ReplaceType(`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 407](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L407) — `try`
    * [api-factset-analytics-request.pqm line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L36) — `else if status = 400 then error Error.Record("Error", "Invalid input parameters", Text.FromBinary(response))`
    * [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31) — `response = Web.Contents(Url, [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = Query]),`
    * [api-factset-analytics-util.pqm line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L90) — `else if status = "Failed" then error Error.Record("Error", "Calculation Failed", text)`
    * [api-factset-analytics-util.pqm line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L90) — `else if status = "Failed" then error Error.Record("Error", "Calculation Failed", text)`
    * [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111) — `response = Web.Contents(ENGINES_V3_URL & "pa/v3/calculations", [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = [pageNumber = page]]),`
    * [request-long-running.pqm line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L88) — `error Error.Record("Error", "Invalid status location url", locationUrl)`
    * [request-long-running.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L59) — `ManualStatusHandling = {201, 202},`
    * [request-request.pqm line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L135) — `Error.Record(`
    * [request-request.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L40) — `ManualStatusHandling = {400, 401, 403, 404, 408, 500, 201, 202}`
    * [util-oauth.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L47) — `Error.Record(`
    * [util-oauth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L37) — `ManualStatusHandling = {200}`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [FactSetAnalytics.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L74) — `Web.Contents(`
    * [FactSetAnalytics.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L364) — `RelativePath = endpoint,`
    * [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31) — `response = Web.Contents(Url, [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = Query]),`
    * [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111) — `response = Web.Contents(ENGINES_V3_URL & "pa/v3/calculations", [Headers = Record.Combine({[#"Accept" = "application/json"], AdditionalHeaders}), ManualStatusHandling = {200,400,404,500}, Query = [pageNumber = page]]),`
    * [api-factset-irn.pqm line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm#L144) — `response = Web.Contents(`
    * [request-long-running.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L51) — `statusResponse = Web.Contents(`
    * [request-long-running.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm#L54) — `RelativePath = locationUrlStatus,`
    * [request-request.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm#L46) — `response = Web.Contents(url, requestOptions),`
    * [util-oauth.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm#L33) — `response = Web.Contents(`
