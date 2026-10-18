---
type: Power Query Connector
title: Assemble Views
description: Connect to Assemble Views
tags: [diagnostics, errors, navigation, oauth, oauth2, packaging, pagination, response-metadata, schema, table-view]
publisher: Autodesk
version: 4.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m
  title: AssembleViews.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AssembleViews/4.1.0/AssembleViews_4.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Autodesk | 4.1.0 | OAuth |

# Source files

* [AssembleViews.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [AssembleViews.m line 346](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L346)
* [Navigation tables and connection checks](../patterns/navigation.md): [AssembleViews.m line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L24)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [AssembleViews.m line 793](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L793)
* [Page generation and cursor traversal](../patterns/pagination.md): [AssembleViews.m line 635](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L635)
* [Resources and modular source loading](../patterns/packaging.md): [AssembleViews.m line 347](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L347)
* [Response and pagination metadata](../patterns/response-metadata.md): [AssembleViews.m line 318](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L318)
* [Schema and type enforcement](../patterns/schema.md): [AssembleViews.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L5)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AssembleViews.m line 244](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L244)
* [Table.View handlers](../patterns/table-view.md): [AssembleViews.m line 478](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L478)
