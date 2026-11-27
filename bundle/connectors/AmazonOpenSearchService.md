---
type: Power Query Connector
title: Amazon OpenSearch Service
description: Connect to OpenSearch
tags: [implicit, key, usernamepassword]
x-pqkb-publisher: Amazon
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m
  title: AmazonOpenSearchService.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonOpenSearchService/1.0.1/AmazonOpenSearchService_1.0.1.pqx
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
| Amazon | 1.0.1 | Implicit, Key, UsernamePassword |

# Source files

* [AmazonOpenSearchService.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/Diagnostics.pqm)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AmazonOpenSearchService.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AmazonOpenSearchService.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AmazonOpenSearchService.m line 17](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L17) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AmazonOpenSearchService. [AmazonOpenSearchService.m line 181](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L181) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AmazonOpenSearchService.Contents. [AmazonOpenSearchService.m line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L11) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [AmazonOpenSearchService.m line 227](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L227) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AmazonOpenSearchService.m line 234](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L234) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AmazonOpenSearchService.m line 154](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L154) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AmazonOpenSearchService.m line 222](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L222) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AmazonOpenSearchService.m line 38](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L38) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [AmazonOpenSearchService.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AmazonOpenSearchService.m line 244](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonOpenSearchService/AmazonOpenSearchService.m#L244) |
