---
type: Power Query Connector
title: AnaplanConnector
description: Connect to AnaplanConnectorV2
tags: [oauth, usernamepassword]
x-pqkb-publisher: Anaplan
x-pqkb-version: 2.9.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq
  title: Anaplan.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/TraceContext.pqm
  title: TraceContext.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Anaplan/2.9.0/Anaplan_2.9.0.pqx
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
| Anaplan | 2.9.0 | OAuth, UsernamePassword |

# Source files

* [Anaplan.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm)
* [TraceContext.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/TraceContext.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Anaplan.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Anaplan.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Anaplan.pq line 294](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L294) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Anaplan. [Anaplan.pq line 218](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L218) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Anaplan.Contents. [Anaplan.pq line 286](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L286) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Anaplan.pq line 239](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L239) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Anaplan.pq line 243](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L243) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Anaplan.pq line 357](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L357) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Anaplan.pq line 234](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L234) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Anaplan.pq line 311](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L311) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Anaplan.pq line 802](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Anaplan/Anaplan.pq#L802) |
