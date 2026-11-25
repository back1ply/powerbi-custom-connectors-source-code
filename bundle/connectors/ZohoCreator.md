---
type: Power Query Connector
title: Zoho Creator
description: Connect to Zoho Creator
tags: [errors, oauth, oauth2, packaging, parameter-metadata, retry-polling, web-requests]
x-pqkb-publisher: Zoho
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m
  title: ZohoCreator.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ZohoCreator/2.0.0/ZohoCreator_2.0.0.pqx
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
| Zoho | 2.0.0 | OAuth |

# Source files

* [ZohoCreator.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L62) — `exec =  Binary.Buffer(Web.Contents(urii,[ManualStatusHandling = {401,400,500},Headers=[#"User-Agent"= user_agent, #"Agent-Version-Number"=version_number]])),`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L90) — `Documentation.FieldCaption = "Domain",`
    * [ZohoCreator.m line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L86) — `shared ZohoCreator.Contents = Value.ReplaceType(ConnectorEntryPoint,DialogInput);`
    * [ZohoCreator.m line 88](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L88) — `DialogInput = type function (`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L133) — `OAuth = [`
    * [ZohoCreator.m line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L134) — `StartLogin=StartLogin,`
    * [ZohoCreator.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L135) — `FinishLogin=FinishLogin,`
    * [ZohoCreator.m line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L188) — `grant_type = grantType,`
    * [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L62) — `exec =  Binary.Buffer(Web.Contents(urii,[ManualStatusHandling = {401,400,500},Headers=[#"User-Agent"= user_agent, #"Agent-Version-Number"=version_number]])),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L15) — `properties = Json.Document ( Extension.Contents( "WebApp.json") );`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L43) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [ZohoCreator.m line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L69) — `(iteration) => #duration(0, 0, 0, Number.Power(2, iteration)),max_retry)`
    * [ZohoCreator.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L43) — `(state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 174](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L174) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [ZohoCreator.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L34) — `finaldomain = try Table.SelectRows(param2, each [domain] = creatordomain){0}[host] otherwise Table.SelectRows(param2, each [domain] = "zoho.com"){0}[host]`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/ZohoCreator/ZohoCreator.m#L62) — `exec =  Binary.Buffer(Web.Contents(urii,[ManualStatusHandling = {401,400,500},Headers=[#"User-Agent"= user_agent, #"Agent-Version-Number"=version_number]])),`
