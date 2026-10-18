---
type: Power Query Connector
title: FactSetAnalytics
description: Power BI connector source for FactSetAnalytics.
tags: [buffering, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, usernamepassword, web-requests]
publisher: FactSet
version: 2.6.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq
  title: FactSetAnalytics.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm
  title: api-factset-analytics-calculations-deprecated.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm
  title: api-factset-analytics-calculations.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm
  title: api-factset-analytics-request.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm
  title: api-factset-analytics-util.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics.pqm
  title: api-factset-analytics.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-irn.pqm
  title: api-factset-irn.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-formula.pqm
  title: api-formula.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/convert-stach.pqm
  title: convert-stach.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm
  title: request-long-running.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-pagination.pqm
  title: request-pagination.pqm
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm
  title: request-request.pqm
- id: file-13
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-api-loader.pqm
  title: util-api-loader.pqm
- id: file-14
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-convert-to-table.pqm
  title: util-convert-to-table.pqm
- id: file-15
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-deep-merge.pqm
  title: util-deep-merge.pqm
- id: file-16
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm
  title: util-oauth.pqm
- id: file-17
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm
  title: util-throttled-function-iterator.pqm
- id: file-18
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm
  title: util-unpivot-other-columns.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetAnalytics/2.6.2/FactSetAnalytics_2.6.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| FactSet | 2.6.2 | OAuth, UsernamePassword |

# Source files

* [FactSetAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq)
* [api-factset-analytics-calculations-deprecated.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm)
* [api-factset-analytics-calculations.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm)
* [api-factset-analytics-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm)
* [api-factset-analytics-util.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm)
* [api-factset-analytics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics.pqm)
* [api-factset-irn.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-irn.pqm)
* [api-formula.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-formula.pqm)
* [convert-stach.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/convert-stach.pqm)
* [request-long-running.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm)
* [request-pagination.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-pagination.pqm)
* [request-request.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm)
* [util-api-loader.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-api-loader.pqm)
* [util-convert-to-table.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-convert-to-table.pqm)
* [util-deep-merge.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-deep-merge.pqm)
* [util-oauth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm)
* [util-throttled-function-iterator.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm)
* [util-unpivot-other-columns.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [api-factset-analytics-request.pqm line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L78)
* [Navigation tables and connection checks](../patterns/navigation.md): [FactSetAnalytics.pq line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L60)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [util-oauth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L56)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [util-oauth.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L69)
* [Resources and modular source loading](../patterns/packaging.md): [FactSetAnalytics.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L34)
* [Response and pagination metadata](../patterns/response-metadata.md): [api-factset-analytics-request.pqm line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L32), [api-factset-analytics-util.pqm line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L97), [request-long-running.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L18), [request-request.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm#L47), [util-oauth.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L40)
* [Retries, delays, and polling](../patterns/retry-polling.md): [api-factset-analytics-request.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L74), [api-factset-analytics-util.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L14), [request-long-running.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L11), [util-throttled-function-iterator.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L9)
* [Schema and type enforcement](../patterns/schema.md): [FactSetAnalytics.pq line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L395), [api-factset-analytics-calculations-deprecated.pqm line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations-deprecated.pqm#L4), [api-factset-analytics-calculations.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-calculations.pqm#L2), [api-factset-analytics.pqm line 152](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics.pqm#L152), [api-factset-irn.pqm line 525](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-irn.pqm#L525), [api-formula.pqm line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-formula.pqm#L63), [convert-stach.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/convert-stach.pqm#L11), [util-convert-to-table.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-convert-to-table.pqm#L38), [util-deep-merge.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-deep-merge.pqm#L27), [util-throttled-function-iterator.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L2), [util-unpivot-other-columns.pqm line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-unpivot-other-columns.pqm#L1)
* [Structured errors and HTTP status handling](../patterns/errors.md): [api-factset-analytics-request.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L31), [api-factset-analytics-util.pqm line 90](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L90), [api-factset-analytics.pqm line 1111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics.pqm#L1111), [request-long-running.pqm line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L59), [request-request.pqm line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-request.pqm#L40), [util-oauth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L37)
* [Web requests and relative paths](../patterns/web-requests.md): [FactSetAnalytics.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L364), [request-long-running.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L54)
