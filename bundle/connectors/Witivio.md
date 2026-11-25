---
type: Power Query Connector
title: PQExtension1
description: Connect to PQExtension1
tags: [aad]
x-pqkb-publisher: Witivio
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq
  title: Witivio.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Witivio/1.0.0/Witivio_1.0.0.pqx
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
| Witivio | 1.0.0 | Aad |

# Source files

* [Witivio.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Witivio.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Witivio.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Witivio.pq line 154](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L154) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Witivio. [Witivio.pq line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L22) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Witivio.Contents. [Witivio.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L149) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Witivio.pq line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L45) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Witivio.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L49) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Witivio.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Witivio/Witivio.pq#L175) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
