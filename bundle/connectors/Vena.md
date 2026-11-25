---
type: Power Query Connector
title: Vena
description: Connect to Vena
tags: [usernamepassword]
x-pqkb-publisher: Vena
x-pqkb-version: 1.1.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm
  title: Main.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm
  title: Utils.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq
  title: Vena.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Vena/1.1.1/Vena_1.1.1.pqx
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
| Vena | 1.1.1 | UsernamePassword |

# Source files

* [Main.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Utils.pqm)
* [Vena.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Vena.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L10) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Vena.pq line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L4) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Vena.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L19) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Vena. [Vena.pq line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L209) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Vena.Contents. [Vena.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L13) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Vena.pq line 232](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L232) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Main.pqm line 8](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Main.pqm#L8) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Vena.pq line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L224) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Vena.pq line 52](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L52) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Review | VenaImpl evaluates an expression not loaded from the package. [Vena.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Vena/Vena.pq#L40) |
