---
type: Power Query Connector
title: Azure Cosmos DB for MongoDB vCore
description: Connect to Azure Cosmos DB for MongoDB vCore
tags: [diagnostics, errors, navigation, packaging, response-metadata, schema, table-view, usernamepassword]
publisher: Microsoft
version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq
  title: AzureCosmosDBForMongoDBvCore.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm
  title: DateTimeZones.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm
  title: ExtendedJson.Extract.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm
  title: Visitors.VisitAstKind.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCosmosDBForMongoDBvCore/1.0.2/AzureCosmosDBForMongoDBvCore_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | UsernamePassword |

# Source files

* [AzureCosmosDBForMongoDBvCore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq)
* [DateTimeZones.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm)
* [ExtendedJson.Extract.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm)
* [Visitors.VisitAstKind.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm#L3)
* [Navigation tables and connection checks](../patterns/navigation.md): [AzureCosmosDBForMongoDBvCore.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L149)
* [Resources and modular source loading](../patterns/packaging.md): [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95), [ExtendedJson.Extract.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm#L63), [Visitors.VisitAstKind.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm#L3)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L16)
* [Schema and type enforcement](../patterns/schema.md): [AzureCosmosDBForMongoDBvCore.pq line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L46), [Table.ChangeType.pqm line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L84)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm#L32)
* [Table.View handlers](../patterns/table-view.md): [AzureCosmosDBForMongoDBvCore.pq line 975](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L975)
