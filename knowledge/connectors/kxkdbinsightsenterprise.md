---
type: Power Query Connector
title: kxkdbinsightsenterprise
description: Power BI connector source for kxkdbinsightsenterprise.
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, pkce, response-metadata, retry-polling, schema, table-view, web-requests]
publisher: KX
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm
  title: AuthHelpers.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm
  title: CommonHelpers.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq
  title: kxkdbinsightsenterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/kxkdbinsightsenterprise/1.0.0/kxkdbinsightsenterprise_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| KX | 1.0.0 | OAuth |

# Source files

* [AuthHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm)
* [CommonHelpers.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/Diagnostics.pqm)
* [kxkdbinsightsenterprise.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L5)
* [Navigation tables and connection checks](../patterns/navigation.md): [kxkdbinsightsenterprise.pq line 565](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L565)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [AuthHelpers.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L47), [kxkdbinsightsenterprise.pq line 568](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L568)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [AuthHelpers.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L75)
* [Resources and modular source loading](../patterns/packaging.md): [AuthHelpers.pqm line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L44), [CommonHelpers.pqm line 212](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L212), [kxkdbinsightsenterprise.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L44)
* [Response and pagination metadata](../patterns/response-metadata.md): [CommonHelpers.pqm line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L116), [kxkdbinsightsenterprise.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L278)
* [Retries, delays, and polling](../patterns/retry-polling.md): [CommonHelpers.pqm line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L104), [kxkdbinsightsenterprise.pq line 321](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L321)
* [Schema and type enforcement](../patterns/schema.md): [CommonHelpers.pqm line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L65), [kxkdbinsightsenterprise.pq line 35](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L35)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AuthHelpers.pqm line 42](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L42), [kxkdbinsightsenterprise.pq line 353](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L353)
* [Table.View handlers](../patterns/table-view.md): [kxkdbinsightsenterprise.pq line 191](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L191)
* [Web requests and relative paths](../patterns/web-requests.md): [kxkdbinsightsenterprise.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L350)
