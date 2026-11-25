---
type: Power Query Connector
title: FactSetAnalytics
description: Power BI connector source for FactSetAnalytics.
tags: [oauth, usernamepassword]
x-pqkb-publisher: FactSet
x-pqkb-version: 2.6.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq
  title: FactSetAnalytics.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm
  title: api-factset-analytics-calculations-deprecated.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm
  title: api-factset-analytics-calculations.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm
  title: api-factset-analytics-request.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm
  title: api-factset-analytics-util.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm
  title: api-factset-analytics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm
  title: api-factset-irn.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm
  title: api-formula.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm
  title: convert-stach.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm
  title: request-long-running.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm
  title: request-pagination.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm
  title: request-request.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-api-loader.pqm
  title: util-api-loader.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm
  title: util-convert-to-table.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm
  title: util-deep-merge.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm
  title: util-oauth.pqm
- id: file-17
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm
  title: util-throttled-function-iterator.pqm
- id: file-18
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm
  title: util-unpivot-other-columns.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetAnalytics/2.6.2/FactSetAnalytics_2.6.2.pqx
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
| FactSet | 2.6.2 | OAuth, UsernamePassword |

# Source files

* [FactSetAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq)
* [api-factset-analytics-calculations-deprecated.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm)
* [api-factset-analytics-calculations.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm)
* [api-factset-analytics-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-request.pqm)
* [api-factset-analytics-util.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-util.pqm)
* [api-factset-analytics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics.pqm)
* [api-factset-irn.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-irn.pqm)
* [api-formula.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-formula.pqm)
* [convert-stach.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/convert-stach.pqm)
* [request-long-running.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-long-running.pqm)
* [request-pagination.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-pagination.pqm)
* [request-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/request-request.pqm)
* [util-api-loader.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-api-loader.pqm)
* [util-convert-to-table.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-convert-to-table.pqm)
* [util-deep-merge.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-deep-merge.pqm)
* [util-oauth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-oauth.pqm)
* [util-throttled-function-iterator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm)
* [util-unpivot-other-columns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [FactSetAnalytics.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [FactSetAnalytics.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [api-factset-analytics-calculations-deprecated.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L8) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for FactSetAnalytics. [FactSetAnalytics.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L59) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: FactSetAnalytics.ConnectionCheck, FactSetAnalytics.Contents, FactSetAnalytics.Functions. [FactSetAnalytics.pq line 72](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L72) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [FactSetAnalytics.pq line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L90) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [FactSetAnalytics.pq line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L134) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [FactSetAnalytics.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L34) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [FactSetAnalytics.pq line 403](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/FactSetAnalytics/FactSetAnalytics.pq#L403) |
