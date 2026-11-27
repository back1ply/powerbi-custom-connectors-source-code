---
type: Power Query Connector
title: Emigo Data Source
description: Connect with Emigo Data Source
tags: [usernamepassword]
x-pqkb-publisher: Sagra
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m
  title: Emigo.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Emigo/1.0.6/Emigo_1.0.6.pqx
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
| Sagra | 1.0.6 | UsernamePassword |

# Source files

* [Emigo.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Emigo.m line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L7) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Emigo.m line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L6) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Emigo.m line 53](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L53) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for EmigoDataSourceConnector. [Emigo.m line 13](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L13) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function Emigo.Contents (kind EmigoDataSourceConnector) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [Emigo.m line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L44) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Emigo.m line 28](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L28) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Emigo.m line 32](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L32) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Emigo.m line 103](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L103) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Emigo.m line 18](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L18) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
