---
type: Power Query Connector
title: SolarwindsServiceDesk
description: Power BI connector source for SolarwindsServiceDesk.
tags: [key]
x-pqkb-publisher: SolarwindsServiceDesk
x-pqkb-version: 1.1.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq
  title: SolarWindsServiceDesk.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SolarwindsServiceDesk/1.1.3/SolarwindsServiceDesk_1.1.3.pqx
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
| SolarwindsServiceDesk | 1.1.3 | Key |

# Source files

* [SolarWindsServiceDesk.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SolarWindsServiceDesk.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SolarWindsServiceDesk.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SolarWindsServiceDesk. [SolarWindsServiceDesk.pq line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L285) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SolarWindsServiceDesk.Contents, SolarWindsServiceDesk.ContentsV110, SolarWindsServiceDesk.ContentsV113. [SolarWindsServiceDesk.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SolarWindsServiceDesk.pq line 300](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L300) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [SolarWindsServiceDesk.pq line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L28) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SolarWindsServiceDesk.pq line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L33) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [SolarWindsServiceDesk.pq line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L139) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [SolarWindsServiceDesk.pq line 63](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L63) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
