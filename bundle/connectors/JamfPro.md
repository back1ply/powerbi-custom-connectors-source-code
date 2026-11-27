---
type: Power Query Connector
title: Jamf Pro
description: Import data from Jamf Pro
tags: [key, usernamepassword]
x-pqkb-publisher: Jamf
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/ComputerMappings.pqm
  title: ComputerMappings.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq
  title: JamfPro.pq
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/MobileDeviceMappings.pqm
  title: MobileDeviceMappings.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JamfPro/2.0.0/JamfPro_2.0.0.pqx
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
| Jamf | 2.0.0 | Key, UsernamePassword |

# Source files

* [ComputerMappings.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/ComputerMappings.pqm)
* [JamfPro.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq)
* [MobileDeviceMappings.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/MobileDeviceMappings.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [JamfPro.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [JamfPro.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [JamfPro.pq line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L14) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for JamfPro. [JamfPro.pq line 670](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L670) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: JamfPro.Contents. [JamfPro.pq line 7](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [JamfPro.pq line 686](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L686) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [JamfPro.pq line 690](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L690) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [JamfPro.pq line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L44) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [JamfPro.pq line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L14) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [JamfPro.pq line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L49) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [JamfPro.pq line 731](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L731) |
