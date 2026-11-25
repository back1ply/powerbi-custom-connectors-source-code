---
type: Power Query Connector
title: Azure Synapse Analytics workspace
description: Import data from Azure Synapse Analytics workspace
tags: [aad, credentials, diagnostics, errors, navigation, packaging, response-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq
  title: Synapse.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Synapse/1.0.5/Synapse_1.0.5.pqx
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
| Microsoft | 1.0.5 | Aad |

# Source files

* [Synapse.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [Synapse.pq line 400](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L400) — `currentCredentials = Extension.CurrentCredential(),`
    * [Synapse.pq line 422](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L422) — `currentCredentials[access_token])`
* [Diagnostic tracing](../patterns/diagnostics.md)
  * **Match from a review of older source**
    * [Synapse.pq line 415](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L415) — `Diagnostics.Trace(`
    * [Synapse.pq line 416](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L416) — `TraceLevel.Error,`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [Synapse.pq line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L90) — `navTable = Table.ToNavigationTable(withIsLeaf, {"Name"}, "Name", "Name", "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Synapse.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L68) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Synapse.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L45) — `Documentation.Name = Extension.LoadString("ButtonTitle"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [Synapse.pq line 352](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L352) — `httpStatus = Value.Metadata(content)[Response.Status],`
    * [Synapse.pq line 292](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L292) — `workspaces = GetARMContents(url, [Headers = [#"Content-Type"="application/json"], Content=Text.ToBinary(content)])[data][rows],`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [Synapse.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L38) — `shared Synapse.Contents = Value.ReplaceType((optional options as record) as table =>`
    * [Synapse.pq line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L85) — `addData = Table.AddColumn(addName, "Data", each CreateNavForDatabases([Value]), type table),`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [Synapse.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L364) — `error Error.Record(`
    * [Synapse.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L350) — `content = Web.Contents(url, options ?? [] & [ManualStatusHandling = {400, 404, 408, 500, 504}]),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [Synapse.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L350) — `content = Web.Contents(url, options ?? [] & [ManualStatusHandling = {400, 404, 408, 500, 504}]),`
