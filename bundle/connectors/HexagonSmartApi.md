---
type: Power Query Connector
title: HexagonSmartApi
description: Power BI connector source for HexagonSmartApi.
tags: [oauth]
x-pqkb-publisher: Hexagon
x-pqkb-version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m
  title: HexagonSmartApi.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm
  title: OAuth.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm
  title: ParametricFilter.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm
  title: SelectList.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm
  title: Typecast.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm
  title: UoM.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/HexagonSmartApi/1.2.1/HexagonSmartApi_1.2.1.pqx
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
| Hexagon | 1.2.1 | OAuth |

# Source files

* [HexagonSmartApi.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m)
* [OAuth.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/OAuth.pqm)
* [ParametricFilter.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm)
* [SelectList.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/SelectList.pqm)
* [Typecast.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/Typecast.pqm)
* [UoM.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/UoM.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [HexagonSmartApi.m line 42](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L42) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [HexagonSmartApi.m line 41](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L41) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [HexagonSmartApi.m line 52](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L52) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for HexagonSmartApi. [HexagonSmartApi.m line 142](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L142) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: HexagonSmartApi.Feed, HexagonSmartApi.GetODataMetadata. [HexagonSmartApi.m line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L49) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [HexagonSmartApi.m line 158](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L158) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [HexagonSmartApi.m line 160](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L160) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [HexagonSmartApi.m line 108](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L108) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [HexagonSmartApi.m line 52](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/HexagonSmartApi.m#L52) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [ParametricFilter.pqm line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L6) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Review | ParametricFilter.pqm evaluates an expression not loaded from the package. [ParametricFilter.pqm line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/HexagonSmartApi/ParametricFilter.pqm#L1) |
