---
type: Power Query Connector
title: Vena
description: Connect to Vena
tags: [buffering, credentials, navigation, packaging, pagination, parameter-metadata, response-metadata, retry-polling, schema, usernamepassword, web-requests]
x-pqkb-publisher: Vena
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm
  title: Main.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm
  title: Utils.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq
  title: Vena.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Vena/1.1.1/Vena_1.1.1.pqx
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
| Vena | 1.1.1 | UsernamePassword |

# Source files

* [Main.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm)
* [Vena.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq)

# Pattern evidence

* [Buffering tables, lists, and binaries](../patterns/buffering.md)
  * **Match from a review of older source**
    * [Utils.pqm line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L108) — `buffered = Csv.Document(Binary.Buffer(binary))`
* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Vena.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L52) — `Credentials = Extension.CurrentCredential(),`
    * [Vena.pq line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L53) — `apiUser = Credentials[Username],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Utils.pqm line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L290) — `navigationTable = Value.ReplaceType(table, newTableType)`
    * [Vena.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L19) — `Documentation.FieldCaption = "Source Region",`
    * [Vena.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L14) — `shared Vena.Contents = Value.ReplaceType(VenaImpl, VenaInputs);`
    * [Vena.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L17) — `VenaInputs = type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Main.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm#L34) — `Table.ToNavigationTable(`
    * [Utils.pqm line 284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L284) — `NavigationTable.NameColumn = nameColumn,`
* [Page generation and cursor traversal](../patterns/pagination.md)
  * **Match from a review of older source**
    * [Utils.pqm line 197](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L197) — `listOfDataWithHeaders = List.Generate(`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Vena.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L204) — `Main.pqm = Text.FromBinary(Extension.Contents("Main.pqm")),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Utils.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L66) — `responseMetadata = Value.Metadata(response),`
    * [Utils.pqm line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L43) — `Headers = [`
    * [Vena.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L142) — `statusCode = Value.Metadata(response)[Response.Status],`
    * [Vena.pq line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L94) — `response = try Web.Contents(splitConfigURL, [Headers = headers, IsRetry = true]) otherwise null,`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [Main.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm#L27) — `validationResponse = if modelQuery <> null then`
    * [Utils.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L178) — `Function.InvokeAfter(`
    * [Utils.pqm line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L180) — `#duration(0, 0, 0, 5)`
    * [Utils.pqm line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L53) — `if content = null then`
    * [Vena.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L44) — `if Text.StartsWith(source, "http", Comparer.OrdinalIgnoreCase) then`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Utils.pqm line 127](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L127) — `TextTypeTransformation = Table.TransformColumnTypes(Promoted, TextTransformationList)`
    * [Vena.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L14) — `shared Vena.Contents = Value.ReplaceType(VenaImpl, VenaInputs);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Utils.pqm line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm#L52) — `response = Web.Contents(url,`
    * [Vena.pq line 94](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L94) — `response = try Web.Contents(splitConfigURL, [Headers = headers, IsRetry = true]) otherwise null,`
    * [Vena.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L122) — `RelativePath = "/split-evaluator/client/get-treatment-with-config",`
