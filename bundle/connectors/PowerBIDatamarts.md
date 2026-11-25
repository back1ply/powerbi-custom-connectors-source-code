---
type: Power Query Connector
title: Datamarts
description: Import Datamarts
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.12
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq
  title: PowerBIDatamarts.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PowerBIDatamarts/1.0.12/PowerBIDatamarts_1.0.12.pqx
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
| Microsoft | 1.0.12 | Aad |

# Source files

* [PowerBIDatamarts.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [PowerBIDatamarts.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [PowerBIDatamarts.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [PowerBIDatamarts.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L125) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for PowerBIDatamarts. [PowerBIDatamarts.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L11) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function PowerBI.Datamarts (kind PowerBIDatamarts) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [PowerBIDatamarts.pq line 95](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L95) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [PowerBIDatamarts.pq line 286](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L286) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [PowerBIDatamarts.pq line 284](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L284) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [PowerBIDatamarts.pq line 218](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L218) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [PowerBIDatamarts.pq line 125](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L125) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [PowerBIDatamarts.pq line 260](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L260) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [PowerBIDatamarts.pq line 187](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PowerBIDatamarts/PowerBIDatamarts.pq#L187) |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
