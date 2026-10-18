---
type: Power Query Connector
title: SmartsheetGlobal
description: Power BI connector source for SmartsheetGlobal.
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, response-metadata, retry-polling, schema]
publisher: Smartsheet
version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq
  title: SmartsheetGlobal.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SmartsheetGlobal/1.1.1/SmartsheetGlobal_1.1.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Smartsheet | 1.1.1 | OAuth |

# Source files

* [SmartsheetGlobal.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [SmartsheetGlobal.pq line 163](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L163)
* [Navigation tables and connection checks](../patterns/navigation.md): [SmartsheetGlobal.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L11)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [SmartsheetGlobal.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L19)
* [Resources and modular source loading](../patterns/packaging.md): [SmartsheetGlobal.pq line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L51)
* [Response and pagination metadata](../patterns/response-metadata.md): [SmartsheetGlobal.pq line 250](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L250)
* [Retries, delays, and polling](../patterns/retry-polling.md): [SmartsheetGlobal.pq line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L221)
* [Schema and type enforcement](../patterns/schema.md): [SmartsheetGlobal.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L5)
* [Structured errors and HTTP status handling](../patterns/errors.md): [SmartsheetGlobal.pq line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L34)
