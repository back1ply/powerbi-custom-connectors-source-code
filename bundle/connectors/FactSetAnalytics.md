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
  at: '2026-11-25T20:59:46Z'
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
