---
type: Power Query Connector
title: Google Sheets
description: Power BI connector source for Google Sheets.
tags: [oauth]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq
  title: GoogleSheets.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/GoogleSheets/1.0.6/GoogleSheets_1.0.6.pqx
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
| Microsoft | 1.0.6 | OAuth |

# Source files

* [GoogleSheets.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [GoogleSheets.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [GoogleSheets.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [GoogleSheets.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L95) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for GoogleSheets. [GoogleSheets.pq line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L64) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: GoogleSheets.Contents. [GoogleSheets.pq line 79](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L79) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [GoogleSheets.pq line 300](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L300) |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [GoogleSheets.pq line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L124) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [GoogleSheets.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/GoogleSheets/GoogleSheets.pq#L74) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
