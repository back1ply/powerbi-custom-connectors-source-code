---
type: Power Query Connector
title: kxkdbinsightsenterprise
description: Power BI connector source for kxkdbinsightsenterprise.
tags: [diagnostics, errors, oauth, oauth2, packaging, parameter-metadata, pkce, response-metadata, retry-polling, schema, table-view, web-requests]
x-pqkb-publisher: KX
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm
  title: AuthHelpers.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm
  title: CommonHelpers.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq
  title: kxkdbinsightsenterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/kxkdbinsightsenterprise/1.0.0/kxkdbinsightsenterprise_1.0.0.pqx
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
| KX | 1.0.0 | OAuth |

# Source files

* [AuthHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm)
* [CommonHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm)
* [kxkdbinsightsenterprise.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq)

# Pattern evidence

* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L5) — `Diagnostics.Trace(`
    * [Diagnostics.pqm line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L6) — `TraceLevel.Information,`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [CommonHelpers.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L65) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [kxkdbinsightsenterprise.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L44) — `Documentation.FieldCaption = Extension.LoadString("UserInput_URLCaption"),`
    * [kxkdbinsightsenterprise.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L35) — `shared kxkdbinsightsenterprise.Contents = Value.ReplaceType(GetRootNavTable, kxkdbinsightsenterpriseType);`
    * [kxkdbinsightsenterprise.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L49) — `type function (HostUrl as HostUrlType) as table meta [`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L62) — `AuthHelpers.StartLogin = (DataSourcePath, State, Display) =>`
    * [AuthHelpers.pqm line 89](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L89) — `AuthHelpers.FinishLogin = (clientApplication, DataSourcePath, Context, CallbackUri, State) =>`
    * [AuthHelpers.pqm line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L26) — `grant_type = GrantType,`
    * [AuthHelpers.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L29) — `Response = Web.Contents(`
    * [kxkdbinsightsenterprise.pq line 567](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L567) — `OAuth = [`
    * [kxkdbinsightsenterprise.pq line 568](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L568) — `StartLogin = AuthHelpers.StartLogin,`
    * [kxkdbinsightsenterprise.pq line 569](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L569) — `FinishLogin = AuthHelpers.FinishLogin,`
    * [kxkdbinsightsenterprise.pq line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L347) — `result = Web.Contents(`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L75) — `code_challenge = CodeChallenge,`
    * [AuthHelpers.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L20) — `CodeVerifier = if (Verifier <> null) then [code_verifier = Verifier] else [],`
    * [AuthHelpers.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L12) — `Hash = Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(CodeVerifier)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L44) — `error Error.Record(JsonResponse[error], Extension.LoadString("error_login"), JsonResponse)`
    * [kxkdbinsightsenterprise.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L44) — `Documentation.FieldCaption = Extension.LoadString("UserInput_URLCaption"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L33) — `Headers = [`
    * [CommonHelpers.pqm line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L116) — `previousMeta = Value.Metadata(schema)`
    * [kxkdbinsightsenterprise.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L278) — `responseMetadata = Value.Metadata(result),`
    * [kxkdbinsightsenterprise.pq line 279](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L279) — `responseCode = responseMetadata[Response.Status],`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L20) — `CodeVerifier = if (Verifier <> null) then [code_verifier = Verifier] else [],`
    * [CommonHelpers.pqm line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L104) — `{1 + state{0}, Function.InvokeAfter(() => producer(state{0}), delay(state{0}))},`
    * [CommonHelpers.pqm line 99](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L99) — `if state{0} > 0 and state{1}[status] = 200`
    * [Diagnostics.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L17) — `if result[HasError] then`
    * [kxkdbinsightsenterprise.pq line 330](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L330) — `(iteration) => #duration(0, 0, 0, iteration * 0.25),`
    * [kxkdbinsightsenterprise.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L204) — `if Record.HasFields(state, "Top") then Text.From(state[Top]) else`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [CommonHelpers.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L65) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [CommonHelpers.pqm line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L118) — `type table (toType) meta previousMeta,`
    * [Diagnostics.pqm line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L114) — `else if base = type table then`
    * [kxkdbinsightsenterprise.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L35) — `shared kxkdbinsightsenterprise.Contents = Value.ReplaceType(GetRootNavTable, kxkdbinsightsenterpriseType);`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L42) — `error Error.Record(JsonResponse[error], JsonResponse[error_description], JsonResponse)`
    * [AuthHelpers.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L42) — `error Error.Record(JsonResponse[error], JsonResponse[error_description], JsonResponse)`
    * [Diagnostics.pqm line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L7) — `prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"),`
    * [kxkdbinsightsenterprise.pq line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L395) — `error Error.Record(Extension.LoadString("error_param_agg")),`
    * [kxkdbinsightsenterprise.pq line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L244) — `aggParam = try List.Count(aggOptions{0}) otherwise 0,`
* [Table.View handlers](../patterns/table-view.md)
  * **Match from a review of older source**
    * [kxkdbinsightsenterprise.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L191) — `View = (state as record) => Table.View(null, Diagnostics.WrapHandlers([`
    * [kxkdbinsightsenterprise.pq line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L192) — `GetType = () => Value.Type(GetRows(true)),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AuthHelpers.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L29) — `Response = Web.Contents(`
    * [kxkdbinsightsenterprise.pq line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L347) — `result = Web.Contents(`
    * [kxkdbinsightsenterprise.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L350) — `RelativePath = SERVICE_GATEWAY_ROUTE & apiEndpoint,`
