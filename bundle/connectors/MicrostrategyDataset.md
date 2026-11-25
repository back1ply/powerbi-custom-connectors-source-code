---
type: Power Query Connector
title: MicrostrategyDataset
description: Import data from Strategy Dataset
tags: [oauth, usernamepassword]
x-pqkb-publisher: MicroStrategy
x-pqkb-version: 2.5.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m
  title: MicroStrategyDataset.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrostrategyDataset/2.5.0/MicrostrategyDataset_2.5.0.pqx
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
| MicroStrategy | 2.5.0 | OAuth, UsernamePassword |

# Source files

* [MicroStrategyDataset.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MicroStrategyDataset.m line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MicroStrategyDataset.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MicroStrategyDataset.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L62) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MicroStrategyDataset. [MicroStrategyDataset.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L28) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MicroStrategyDataset.Contents, MicroStrategyDataset.TestConnection. [MicroStrategyDataset.m line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L17) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [MicroStrategyDataset.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L49) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [MicroStrategyDataset.m line 329](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L329) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MicroStrategyDataset.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L9) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [MicroStrategyDataset.m line 102](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L102) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
