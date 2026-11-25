---
type: Power Query Connector
title: Azure Databricks
description: Import data from Azure Databricks
tags: [aad, key, oauth, usernamepassword]
x-pqkb-publisher: Databricks
x-pqkb-version: 2.0.34
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm
  title: AdvancedOptions.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq
  title: Databricks.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryHelpers.pqm
  title: QueryHelpers.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryTagsHelper.pqm
  title: QueryTagsHelper.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Databricks/2.0.34/Databricks_2.0.34.pqx
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
| Databricks | 2.0.34 | Aad, Key, OAuth, UsernamePassword |

# Source files

* [AdvancedOptions.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm)
* [Databricks.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/OdbcConstants.pqm)
* [QueryHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryHelpers.pqm)
* [QueryTagsHelper.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/QueryTagsHelper.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Databricks.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Databricks.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Databricks.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L49) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Databricks, DatabricksMultiCloud. [Databricks.pq line 873](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L873) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Databricks.Catalogs, Databricks.Contents, Databricks.Query, DatabricksMultiCloud.Catalogs, DatabricksMultiCloud.Query. [Databricks.pq line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L21) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Databricks.pq line 996](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L996) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Databricks.pq line 1604](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L1604) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AdvancedOptions.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/AdvancedOptions.pqm#L28) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Databricks.pq line 283](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L283) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Databricks.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L164) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Databricks.pq line 2033](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Databricks/Databricks.pq#L2033) |
