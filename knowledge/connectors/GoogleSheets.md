---
type: Power Query Connector
title: Google Sheets
description: Power BI connector source for Google Sheets.
tags: [errors, navigation, oauth, oauth2, packaging, response-metadata, schema]
publisher: Microsoft
version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq
  title: GoogleSheets.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/GoogleSheets/1.0.6/GoogleSheets_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.6 | OAuth |

# Source files

* [GoogleSheets.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [GoogleSheets.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L68)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [GoogleSheets.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L9)
* [Resources and modular source loading](../patterns/packaging.md): [GoogleSheets.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L74)
* [Response and pagination metadata](../patterns/response-metadata.md): [GoogleSheets.pq line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L256)
* [Schema and type enforcement](../patterns/schema.md): [GoogleSheets.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L80)
* [Structured errors and HTTP status handling](../patterns/errors.md): [GoogleSheets.pq line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L32)
