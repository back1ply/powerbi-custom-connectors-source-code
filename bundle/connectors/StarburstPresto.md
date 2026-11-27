---
type: Power Query Connector
title: StarburstPresto
description: Power BI connector source for StarburstPresto.
tags: [aad, key, oauth, usernamepassword, windows]
x-pqkb-publisher: Starburst
x-pqkb-version: 5.4.4
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/OdbcConstants.pqm
  title: OdbcConstants.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq
  title: StarburstEnterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/StarburstPresto/5.4.4/StarburstPresto_5.4.4.pqx
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
| Starburst | 5.4.4 | Aad, Key, OAuth, UsernamePassword, Windows |

# Source files

* [OdbcConstants.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/OdbcConstants.pqm)
* [StarburstEnterprise.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [StarburstEnterprise.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [StarburstEnterprise.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [StarburstEnterprise.pq line 146](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L146) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for StarburstAad, StarburstPresto. [StarburstEnterprise.pq line 61](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L61) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: StarburstPresto.Contents, StarburstAad.Contents. [StarburstEnterprise.pq line 20](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L20) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [StarburstEnterprise.pq line 97](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L97) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [StarburstEnterprise.pq line 104](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L104) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [StarburstEnterprise.pq line 741](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L741) |
| Place UI strings in resources.resx. | SHOULD | Fail | No Extension.LoadString calls. |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [StarburstEnterprise.pq line 196](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L196) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [StarburstEnterprise.pq line 1067](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/StarburstPresto/StarburstEnterprise.pq#L1067) |
