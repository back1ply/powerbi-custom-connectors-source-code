---
type: Power Query Connector
title: ADPAnalytics
description: Connect to ADPAnalytics
tags: [errors, navigation, oauth, oauth2, packaging, web-requests]
x-pqkb-publisher: ADP
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m
  title: ADPAnalytics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ADPAnalytics/1.0.3/ADPAnalytics_1.0.3.pqx
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
| ADP | 1.0.3 | OAuth |

# Source files

* [ADPAnalytics.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [ADPAnalytics.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L98) — `access_token=  Extension.CurrentCredential()[access_token],`
    * [ADPAnalytics.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L98) — `access_token=  Extension.CurrentCredential()[access_token],`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [ADPAnalytics.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L80) — `else Table.ToNavigationTable( ConvertToNavigationTable, {"sequence_number"}, "metric_desc", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [ADPAnalytics.m line 227](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L227) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [ADPAnalytics.m line 339](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L339) — `OAuth = [`
    * [ADPAnalytics.m line 238](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L238) — `StartLogin = (resourceUrl, state, display) =>`
    * [ADPAnalytics.m line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L256) — `FinishLogin = (context, callbackUri, state) =>`
    * [ADPAnalytics.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L17) — `source = Web.Contents(metric_selection_uri,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ADPAnalytics.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L5) — `EnvType = Extension.LoadString("EnvType");`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [ADPAnalytics.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L23) — `GetMetadata = Value.Metadata(source),`
    * [ADPAnalytics.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L19) — `Headers = [#"Content-Type"="application/json",#"Accept"="application/json", #"Culture"="en_us"],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [ADPAnalytics.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L122) — `#"Changed Type" = Table.TransformColumnTypes(#"Split Column by Delimiter",{}),`
    * [ADPAnalytics.m line 322](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L322) — `Type.AddTableKey(type table [#"Json Type" = text, #"Actual Type" = type], {"Json Type"}, true)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [ADPAnalytics.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L30) — `if (response[selectedMetrics]={}) then error Error.Record("DataSource.Error", "No metrics configured. Please configure the metrics 		      	 from your Power BI Data Manager by clicking on Manage Now on the Power BI tile under Data Mashup in Reports & Analytics and Sign In   		      	 again.")`
    * [ADPAnalytics.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L20) — `ManualStatusHandling = {401}`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [ADPAnalytics.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ADPAnalytics/ADPAnalytics.m#L17) — `source = Web.Contents(metric_selection_uri,`
