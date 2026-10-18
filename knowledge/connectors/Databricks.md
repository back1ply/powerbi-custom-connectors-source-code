---
type: Power Query Connector
title: Azure Databricks
description: Import data from Azure Databricks
tags: [aad, buffering, credentials, diagnostics, errors, key, navigation, oauth, oauth2, odbc, packaging, pkce, response-metadata, schema, table-view, usernamepassword]
publisher: Databricks
version: 2.0.34
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm
  title: AdvancedOptions.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq
  title: Databricks.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/QueryHelpers.pqm
  title: QueryHelpers.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/QueryTagsHelper.pqm
  title: QueryTagsHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Databricks/2.0.34/Databricks_2.0.34.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Databricks | 2.0.34 | Aad, Key, OAuth, UsernamePassword |

# Source files

* [AdvancedOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm)
* [Databricks.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/OdbcConstants.pqm)
* [QueryHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/QueryHelpers.pqm)
* [QueryTagsHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/QueryTagsHelper.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [Databricks.pq line 1708](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1708)
* [Credential access](../patterns/credentials.md): [Databricks.pq line 283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L283)
* [Diagnostic tracing](../patterns/diagnostics.md): [Databricks.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L164), [Diagnostics.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm#L19)
* [Navigation tables and connection checks](../patterns/navigation.md): [Databricks.pq line 925](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L925)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [Databricks.pq line 952](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L952)
* [ODBC and DirectQuery configuration](../patterns/odbc.md): [Databricks.pq line 591](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L591)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [Databricks.pq line 1162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1162)
* [Resources and modular source loading](../patterns/packaging.md): [AdvancedOptions.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm#L28), [Databricks.pq line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L43)
* [Response and pagination metadata](../patterns/response-metadata.md): [Databricks.pq line 593](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L593), [Diagnostics.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Diagnostics.pqm#L8)
* [Schema and type enforcement](../patterns/schema.md): [Databricks.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L22)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AdvancedOptions.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/AdvancedOptions.pqm#L11), [Databricks.pq line 247](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L247)
* [Table.View handlers](../patterns/table-view.md): [Databricks.pq line 1367](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1367)
