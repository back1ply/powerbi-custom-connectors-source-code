---
type: Power Query Connector
title: Supermetrics
description: Power BI connector source for Supermetrics.
tags: [errors, navigation, oauth, packaging, pkce, schema, web-requests]
x-pqkb-publisher: Supermetrics
x-pqkb-version: 3.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Icons.pqm
  title: Icons.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m
  title: Supermetrics.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Supermetrics/3.3.0/Supermetrics_3.3.0.pqx
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
| Supermetrics | 3.3.0 | OAuth |

# Source files

* [Icons.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Icons.pqm)
* [Supermetrics.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Uncertain match (older review)**
    * [Supermetrics.m line 334](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L334) — `_response = Binary.Buffer(_httpResponse) meta Value.Metadata(_httpResponse),`
* [Credential access](../patterns/credentials.md)
  * **Uncertain match (older review)**
    * [Supermetrics.m line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L293) — `#"Authorization" = "Bearer " & Extension.CurrentCredential()[access_token],`
    * [Supermetrics.m line 293](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L293) — `#"Authorization" = "Bearer " & Extension.CurrentCredential()[access_token],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Uncertain match (older review)**
    * [Supermetrics.m line 471](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L471) — `Documentation.FieldCaption = title,`
    * [Supermetrics.m line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L77) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Supermetrics.m line 537](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L537) — `type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Supermetrics.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L43) — `_resultWithEvent = (eventResponse) => Table.ToNavigationTable(`
    * [Supermetrics.m line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L71) — `NavigationTable.NameColumn = nameColumn,`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [Supermetrics.m line 184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L184) — `code_challenge = this.createHash(_codeVerifier),`
    * [Supermetrics.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L132) — `code_verifier = verifier`
    * [Supermetrics.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L122) — `Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii)),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Icons.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Icons.pqm#L3) — `Extension.Contents("Supermetrics16.png"),`
    * [Supermetrics.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L7) — `Expression.Evaluate(Text.FromBinary(Extension.Contents(filename)), #shared);`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Uncertain match (older review)**
    * [Supermetrics.m line 305](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L305) — `{[#"X-Pbi-Iteration" = Number.ToText(iteration)], try Value.Metadata(body)[headers] otherwise []}`
    * [Supermetrics.m line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L157) — `Headers = [`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Uncertain match (older review)**
    * [Supermetrics.m line 282](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L282) — `{1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},`
    * [Supermetrics.m line 342](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L342) — `#duration(0, 0, 0, _retryDelay)`
    * [Supermetrics.m line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L81) — `if dataType = "bool" then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Supermetrics.m line 77](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L77) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Supermetrics.m line 803](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L803) — `type table [`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Supermetrics.m line 168](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L168) — `error Error.Record(_response[error], _response[message]?)`
    * [Supermetrics.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L162) — `ManualStatusHandling = ManualHandlingStatusCodes`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Supermetrics.m line 153](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Supermetrics/Supermetrics.m#L153) — `Response = Web.Contents(`
