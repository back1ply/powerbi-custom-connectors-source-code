---
type: Power Query Connector
title: Paxata
description: Connect to Paxata
tags: [key]
x-pqkb-publisher: Paxata
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m
  title: Paxata.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Paxata/1.0.3/Paxata_1.0.3.pqx
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
| Paxata | 1.0.3 | Key |

# Source files

* [Paxata.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Paxata.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Paxata.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Paxata.m line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L31) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Paxata. [Paxata.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L6) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Paxata.Contents. [Paxata.m line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L25) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Paxata.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L21) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Paxata.m line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L140) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Paxata.m line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L19) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Paxata.m line 41](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Paxata/Paxata.m#L41) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
