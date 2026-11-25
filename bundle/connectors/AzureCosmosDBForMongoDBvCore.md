---
type: Power Query Connector
title: Azure Cosmos DB for MongoDB vCore
description: Connect to Azure Cosmos DB for MongoDB vCore
tags: [usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq
  title: AzureCosmosDBForMongoDBvCore.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm
  title: DateTimeZones.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm
  title: ExtendedJson.Extract.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm
  title: Visitors.VisitAstKind.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AzureCosmosDBForMongoDBvCore/1.0.2/AzureCosmosDBForMongoDBvCore_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T22:15:39Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | UsernamePassword |

# Source files

* [AzureCosmosDBForMongoDBvCore.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq)
* [DateTimeZones.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/DateTimeZones.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Diagnostics.pqm)
* [ExtendedJson.Extract.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/ExtendedJson.Extract.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Table.ChangeType.pqm)
* [Visitors.VisitAstKind.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/Visitors.VisitAstKind.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AzureCosmosDBForMongoDBvCore.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AzureCosmosDBForMongoDBvCore.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AzureCosmosDBForMongoDBvCore. [AzureCosmosDBForMongoDBvCore.pq line 170](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L170) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AzureCosmosDBForMongoDBvCore.Contents. [AzureCosmosDBForMongoDBvCore.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L45) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [AzureCosmosDBForMongoDBvCore.pq line 1011](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L1011) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AzureCosmosDBForMongoDBvCore.pq line 1015](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L1015) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AzureCosmosDBForMongoDBvCore.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L149) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AzureCosmosDBForMongoDBvCore.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L95) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [AzureCosmosDBForMongoDBvCore.pq line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L130) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AzureCosmosDBForMongoDBvCore.pq line 1057](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureCosmosDBForMongoDBvCore/AzureCosmosDBForMongoDBvCore.pq#L1057) |
