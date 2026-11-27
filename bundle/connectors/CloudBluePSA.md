---
type: Power Query Connector
title: CloudBluePSA
description: Power BI connector source for CloudBluePSA.
tags: [key]
x-pqkb-publisher: CloudBluePSA
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m
  title: CloudBluePSAConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CloudBluePSA/1.0.1/CloudBluePSA_1.0.1.pqx
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
| CloudBluePSA | 1.0.1 | Key |

# Source files

* [CloudBluePSAConnector.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [CloudBluePSAConnector.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [CloudBluePSAConnector.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [CloudBluePSAConnector.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for CloudBluePSA. [CloudBluePSAConnector.m line 67](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L67) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: CloudBluePSA.Feed. [CloudBluePSAConnector.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [CloudBluePSAConnector.m line 85](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L85) |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [CloudBluePSAConnector.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [CloudBluePSAConnector.m line 33](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/CloudBluePSA/CloudBluePSAConnector.m#L33) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
