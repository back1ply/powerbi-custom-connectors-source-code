---
type: Power Query Connector
title: Azure Synapse Analytics workspace
description: Import data from Azure Synapse Analytics workspace
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.5
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq
  title: Synapse.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Synapse/1.0.5/Synapse_1.0.5.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-27T12:12:40Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.5 | Aad |

# Source files

* [Synapse.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Synapse.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Synapse.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Synapse.pq line 45](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L45) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Synapse. [Synapse.pq line 451](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L451) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Synapse.Contents. [Synapse.pq line 37](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L37) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Synapse.pq line 479](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L479) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Synapse.pq line 483](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L483) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Synapse.pq line 53](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L53) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Synapse.pq line 45](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L45) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Synapse.pq line 400](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L400) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Synapse.pq line 415](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Synapse/Synapse.pq#L415) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
