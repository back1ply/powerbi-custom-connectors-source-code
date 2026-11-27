---
type: Power Query Connector
title: Denodo
description: Connect to Denodo
tags: [aad, usernamepassword, windows]
x-pqkb-publisher: Denodo
x-pqkb-version: 1.1.2
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m
  title: DenodoForPowerBI.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm
  title: Validation.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Denodo/1.1.2/Denodo_1.1.2.pqx
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
| Denodo | 1.1.2 | Aad, UsernamePassword, Windows |

# Source files

* [DenodoForPowerBI.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/Diagnostics.pqm)
* [Validation.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/Validation.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [DenodoForPowerBI.m line 23](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L23) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [DenodoForPowerBI.m line 22](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L22) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [DenodoForPowerBI.m line 32](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L32) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for DenodoForPowerBI. [DenodoForPowerBI.m line 551](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L551) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function Denodo.Contents (kind DenodoForPowerBI) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [DenodoForPowerBI.m line 25](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L25) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [DenodoForPowerBI.m line 602](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L602) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [DenodoForPowerBI.m line 609](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L609) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [DenodoForPowerBI.m line 209](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L209) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [DenodoForPowerBI.m line 595](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L595) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [DenodoForPowerBI.m line 101](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L101) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [DenodoForPowerBI.m line 111](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L111) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [DenodoForPowerBI.m line 639](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Denodo/DenodoForPowerBI.m#L639) |
