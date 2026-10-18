---
type: Power Query Connector
title: qbconnector
description: Connect to qbconnector
tags: [buffering, credentials, errors, key, navigation, packaging, pagination, response-metadata, retry-polling, schema]
publisher: QuickBase
version: 1.4.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m
  title: qbconnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/QuickBase/1.4.0/QuickBase_1.4.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| QuickBase | 1.4.0 | Key |

# Source files

* [qbconnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [qbconnector.m line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L70)
* [Credential access](../patterns/credentials.md): [qbconnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L33)
* [Navigation tables and connection checks](../patterns/navigation.md): [qbconnector.m line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L96)
* [Page generation and cursor traversal](../patterns/pagination.md): [qbconnector.m line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L285)
* [Resources and modular source loading](../patterns/packaging.md): [qbconnector.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L12)
* [Response and pagination metadata](../patterns/response-metadata.md): [qbconnector.m line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L71)
* [Retries, delays, and polling](../patterns/retry-polling.md): [qbconnector.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L57)
* [Schema and type enforcement](../patterns/schema.md): [qbconnector.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L11)
* [Structured errors and HTTP status handling](../patterns/errors.md): [qbconnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L45)
