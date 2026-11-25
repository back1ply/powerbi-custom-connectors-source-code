---
type: Power Query Connector
title: Funnel
description: Power BI connector source for Funnel.
tags: [credentials, errors, navigation, oauth, oauth2, packaging, pagination, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Funnel
x-pqkb-version: 5.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm
  title: DataLoading.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq
  title: Funnel.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm
  title: NavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Funnel/5.0.1/Funnel_5.0.1.pqx
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
| Funnel | 5.0.1 | OAuth |

# Source files

* [DataLoading.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm)
* [Funnel.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq)
* [NavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L18) — `#"X-Auth-Token" = Extension.CurrentCredential()[access_token]`
    * [DataLoading.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L18) — `#"X-Auth-Token" = Extension.CurrentCredential()[access_token]`
    * [OAuth.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L65) — `refresh_token = oldCredential[refresh_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L119) — `Value.ReplaceType(`
    * [Funnel.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L5) — `shared Funnel.Contents = Value.ReplaceType(BuildNavigationTable, NavigationTableType); //Means: run FunnelAccounts as NavContentsType (metadata)`
    * [NavigationTable.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L22) — `Documentation.FieldCaption =  Text.Format(Extension.LoadString("NumberOfMonthsFieldCaption"), {DataLoading.DefaultNumberOfMonths}),`
    * [NavigationTable.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L51) — `withData = Table.AddColumn(viewsTable, "Data", each Value.ReplaceType((optional numberOfMonths as number) as table =>`
    * [NavigationTable.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L13) — `NavigationTableType = type function ()`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [NavigationTable.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L47) — `Table.ToNavigationTable(objects, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf", true)`
    * [NavigationTable.pqm line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L105) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L27) — `response = Web.Contents(url_,[Headers = headers, ManualStatusHandling = {400, 401, 404, 500, 502}]),`
    * [Funnel.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L12) — `OAuth = [`
    * [Funnel.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L13) — `StartLogin = OAuth.StartLogin,`
    * [Funnel.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L14) — `FinishLogin = OAuth.FinishLogin,`
    * [OAuth.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L16) — `StartLogin = (resourceUrl, state, display) =>`
    * [OAuth.pqm line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L36) — `FinishLogin = (context, callbackUri, state) =>`
    * [OAuth.pqm line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L48) — `grant_type = "authorization_code",`
    * [OAuth.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L45) — `Response = Web.Contents(tokenUrl, [`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 105](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L105) — `listOfPages = List.Generate(`
    * [DataLoading.pqm line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L97) — `page = if nextUrl = null then null else GetPage(nextUrl, headers)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L10) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error Extension.LoadString("UrlSchemeError") else url,`
    * [Funnel.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L16) — `Label = Extension.LoadString("AuthenticationLabel")`
    * [NavigationTable.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L4) — `binary = Extension.Contents(name),`
    * [OAuth.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L4) — `binary = Extension.Contents(name),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L29) — `status = Value.Metadata(response)[Response.Status],`
    * [DataLoading.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L27) — `response = Web.Contents(url_,[Headers = headers, ManualStatusHandling = {400, 401, 404, 500, 502}]),`
    * [OAuth.pqm line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L52) — `Headers=[`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L81) — `withTypes = Table.TransformColumnTypes(withFirstColumnRemoved, datatypesList)`
    * [Funnel.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L5) — `shared Funnel.Contents = Value.ReplaceType(BuildNavigationTable, NavigationTableType); //Means: run FunnelAccounts as NavContentsType (metadata)`
    * [NavigationTable.pqm line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L51) — `withData = Table.AddColumn(viewsTable, "Data", each Value.ReplaceType((optional numberOfMonths as number) as table =>`
    * [NavigationTable.pqm line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L52) — `DataLoading.LoadData(instanceId, accountId, [viewId], numberOfMonths), PeriodType), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L154) — `errorRecord = error Error.Record(code, message, Extension.LoadString("RemoteErrorDetail"))`
    * [DataLoading.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L10) — `ValidateUrlScheme = (url as text) as text => if (Uri.Parts(url)[Scheme] <> "https") then error Extension.LoadString("UrlSchemeError") else url,`
    * [NavigationTable.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L76) — `accountsTableOrWarning = if Table.IsEmpty(accountsTable) then error Error.Record("Error", "No workspaces found", "Check your credentials to Funnel") else accountsTable,`
    * [NavigationTable.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L66) — `accountsJsonEU = try DataLoading.GetAccounts("EU") otherwise {},`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [DataLoading.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L27) — `response = Web.Contents(url_,[Headers = headers, ManualStatusHandling = {400, 401, 404, 500, 502}]),`
    * [OAuth.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm#L45) — `Response = Web.Contents(tokenUrl, [`
