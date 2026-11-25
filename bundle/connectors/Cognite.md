---
type: Power Query Connector
title: Cognite Data Fusion (OData)
description: Connect to Cognite Data Fusion (CDF)
tags: [aad, credentials, errors, odata, packaging, parameter-metadata, response-metadata, schema, web-requests]
x-pqkb-publisher: Cognite
x-pqkb-version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq
  title: Cognite.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cognite/1.0.9/Cognite_1.0.9.pqx
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
| Cognite | 1.0.9 | Aad |

# Source files

* [Cognite.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq)
* [Value.ToText.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Cognite.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L129) — `current = Extension.CurrentCredential()[AuthenticationKind],`
    * [Cognite.pq line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L129) — `current = Extension.CurrentCredential()[AuthenticationKind],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Cognite.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L52) — `Documentation.FieldCaption = Extension.LoadString("ProjectName"),`
    * [Cognite.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L48) — `shared Cognite.Contents = Value.ReplaceType(CogniteImpl, CogniteType);`
    * [Cognite.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L50) — `CogniteType = type function (`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [Cognite.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L147) — `source = OData.Feed(queryUrl, null, [ Concurrent=true, Implementation="2.0", MaxUriLength=32768, Headers=headers ]),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Cognite.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L52) — `Documentation.FieldCaption = Extension.LoadString("ProjectName"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Cognite.pq line 246](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L246) — `if (List.Contains(responseCodes, Value.Metadata(endpointResponse)[Response.Status]?)) then`
    * [Cognite.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L147) — `source = OData.Feed(queryUrl, null, [ Concurrent=true, Implementation="2.0", MaxUriLength=32768, Headers=headers ]),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Cognite.pq line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L48) — `shared Cognite.Contents = Value.ReplaceType(CogniteImpl, CogniteType);`
    * [Value.ToText.pqm line 170](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm#L170) — `if base = type table then "table" else`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Cognite.pq line 257](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L257) — `error Error.Record("DataSource.Error", "Unexpected WWW-Authenticate header format or value during authentication.", [`
    * [Cognite.pq line 242](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L242) — `ManualStatusHandling = responseCodes,`
    * [Value.ToText.pqm line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm#L10) — `try`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Cognite.pq line 240](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L240) — `endpointResponse = Web.Contents(url, [`
