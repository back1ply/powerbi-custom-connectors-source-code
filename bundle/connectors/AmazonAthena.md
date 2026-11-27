---
type: Power Query Connector
title: AmazonAthena
description: Connect to Athena
tags: [aad, implicit]
x-pqkb-publisher: Amazon
x-pqkb-version: 1.2.8
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m
  title: AmazonAthena.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/OdbcConstants.pqm
  title: OdbcConstants.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AmazonAthena/1.2.8/AmazonAthena_1.2.8.pqx
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
| Amazon | 1.2.8 | Aad, Implicit |

# Source files

* [AmazonAthena.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m)
* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/OdbcConstants.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AmazonAthena.m line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L11) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AmazonAthena.m line 8](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L8) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AmazonAthena.m line 23](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L23) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AmazonAthena. [AmazonAthena.m line 211](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L211) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AmazonAthena.Databases. [AmazonAthena.m line 16](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L16) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AmazonAthena.m line 244](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L244) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AmazonAthena.m line 254](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L254) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [AmazonAthena.m line 124](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L124) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AmazonAthena.m line 76](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L76) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [AmazonAthena.m line 53](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L53) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AmazonAthena.m line 285](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AmazonAthena/AmazonAthena.m#L285) |
