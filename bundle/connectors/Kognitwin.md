---
type: Power Query Connector
title: Kognitwin
description: Connect to Kognitwin
tags: [oauth]
x-pqkb-publisher: Kongsberg
x-pqkb-version: 2.5.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq
  title: Kognitwin.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Kognitwin/2.5.1/Kognitwin_2.5.1.pqx
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
| Kongsberg | 2.5.1 | OAuth |

# Source files

* [Kognitwin.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Kognitwin.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L1) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Kognitwin.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Kognitwin.pq line 284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L284) |
| Have a TestConnection handler. | MUST | Review | No data source kind found. |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Review | No shared function with a data source kind found. |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Kognitwin.pq line 251](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L251) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Kognitwin.pq line 81](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L81) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Kognitwin.pq line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Kognitwin/Kognitwin.pq#L121) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
