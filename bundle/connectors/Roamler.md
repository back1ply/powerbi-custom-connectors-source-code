---
type: Power Query Connector
title: Roamler
description: Roamler
tags: [key]
x-pqkb-publisher: Roamler
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m
  title: Roamler.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Roamler/1.0.0/Roamler_1.0.0.pqx
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
| Roamler | 1.0.0 | Key |

# Source files

* [Roamler.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Roamler.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Roamler.m line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Roamler.m line 82](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L82) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Roamler. [Roamler.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L13) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Roamler.Contents. [Roamler.m line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L48) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Roamler.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L23) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Roamler.m line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L27) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Roamler.m line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L74) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Roamler.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L18) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Roamler.m line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Roamler/Roamler.m#L8) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
