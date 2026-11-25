---
type: Power Query Connector
title: TIBCO.ODBC.TDV
description: Connect to TIBCO.ODBC.TDV
tags: [implicit, usernamepassword, windows]
x-pqkb-publisher: TIBCO
x-pqkb-version: 20.0.7806
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m
  title: TIBCO.ODBC.TDV.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TIBCO/20.0.7806/TIBCO_20.0.7806.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T22:15:39Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| TIBCO | 20.0.7806 | Implicit, UsernamePassword, Windows |

# Source files

* [TIBCO.ODBC.TDV.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [TIBCO.ODBC.TDV.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L6) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [TIBCO.ODBC.TDV.m line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [TIBCO.ODBC.TDV.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L128) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for TibcoTdv. [TIBCO.ODBC.TDV.m line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L161) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: TibcoTdv.DataSource. [TIBCO.ODBC.TDV.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L8) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [TIBCO.ODBC.TDV.m line 188](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L188) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [TIBCO.ODBC.TDV.m line 193](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L193) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [TIBCO.ODBC.TDV.m line 118](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L118) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [TIBCO.ODBC.TDV.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L128) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [TIBCO.ODBC.TDV.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L62) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
