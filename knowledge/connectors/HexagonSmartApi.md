---
type: Power Query Connector
title: HexagonSmartApi
description: Power BI connector source for HexagonSmartApi.
tags: [diagnostics, errors, navigation, oauth, oauth2, odata, packaging, pagination, response-metadata, schema, web-requests]
publisher: Hexagon
version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m
  title: HexagonSmartApi.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm
  title: OAuth.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm
  title: ParametricFilter.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm
  title: SelectList.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm
  title: Typecast.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm
  title: UoM.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/HexagonSmartApi/1.2.1/HexagonSmartApi_1.2.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Hexagon | 1.2.1 | OAuth |

# Source files

* [HexagonSmartApi.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m)
* [OAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm)
* [ParametricFilter.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm)
* [SelectList.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm)
* [Typecast.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm)
* [UoM.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm)

# Detected patterns

* [Diagnostic tracing](../patterns/diagnostics.md): [ParametricFilter.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L8), [SelectList.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L8), [Typecast.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L8), [UoM.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L8)
* [Navigation tables and connection checks](../patterns/navigation.md): [HexagonSmartApi.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L143)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [HexagonSmartApi.m line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L146), [OAuth.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L18)
* [OData feeds](../patterns/odata.md): [HexagonSmartApi.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L108), [UoM.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L33)
* [Page generation and cursor traversal](../patterns/pagination.md): [ParametricFilter.pqm line 786](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L786), [SelectList.pqm line 471](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L471)
* [Resources and modular source loading](../patterns/packaging.md): [HexagonSmartApi.m line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L52), [OAuth.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L8), [ParametricFilter.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L45), [SelectList.pqm line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L39), [Typecast.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L31), [UoM.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L14)
* [Response and pagination metadata](../patterns/response-metadata.md): [HexagonSmartApi.m line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L131), [OAuth.pqm line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L102), [ParametricFilter.pqm line 561](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L561), [SelectList.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L18), [Typecast.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L18), [UoM.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L21)
* [Schema and type enforcement](../patterns/schema.md): [HexagonSmartApi.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L50), [ParametricFilter.pqm line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L55), [SelectList.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L24), [Typecast.pqm line 24](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/Typecast.pqm#L24), [UoM.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L27)
* [Structured errors and HTTP status handling](../patterns/errors.md): [HexagonSmartApi.m line 92](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L92), [OAuth.pqm line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L46), [ParametricFilter.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L83), [SelectList.pqm line 324](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L324), [UoM.pqm line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L123)
* [Web requests and relative paths](../patterns/web-requests.md): [HexagonSmartApi.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L192), [UoM.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L124)
