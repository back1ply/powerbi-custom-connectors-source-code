---
type: Power Query Connector
title: Bloomberg
description: Power BI connector source for Bloomberg.
tags: [oauth]
x-pqkb-publisher: Bloomberg
x-pqkb-version: 2.0.12
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm
  title: Auth.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m
  title: Bloomberg.m
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Configuration.pqm
  title: Configuration.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm
  title: Data-Handler.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm
  title: Folding.pqm
- id: file-7
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/JWT.pqm
  title: JWT.pqm
- id: file-8
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm
  title: Utils.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Bloomberg/2.0.12/Bloomberg_2.0.12.pqx
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
| Bloomberg | 2.0.12 | OAuth |

# Source files

* [Auth.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm)
* [Bloomberg.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m)
* [Configuration.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Configuration.pqm)
* [Data-Handler.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Data-Handler.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Diagnostics.pqm)
* [Folding.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Folding.pqm)
* [JWT.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/JWT.pqm)
* [Utils.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Bloomberg.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Bloomberg.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Bloomberg.m line 66](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L66) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for BQL, Bloomberg. [Bloomberg.m line 177](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L177) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Bloomberg.Query, BQL.Query. [Bloomberg.m line 6](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L6) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Bloomberg.m line 172](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L172) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Utils.pqm line 82](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Utils.pqm#L82) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Bloomberg.m line 66](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Bloomberg.m#L66) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [Configuration.pqm line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Configuration.pqm#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Auth.pqm line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Bloomberg/Auth.pqm#L1) |
