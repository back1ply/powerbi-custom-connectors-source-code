---
type: Power Query Connector
title: Usercube
description: Connect to Usercube
tags: [usernamepassword]
x-pqkb-publisher: Usercube
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m
  title: Usercube.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Usercube/1.0.0/Usercube_1.0.0.pqx
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
| Usercube | 1.0.0 | UsernamePassword |

# Source files

* [Table.ChangeType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm)
* [Usercube.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Usercube.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Usercube.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Usercube.m line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L11) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Usercube. [Usercube.m line 27](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L27) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Usercube.Universes. [Usercube.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Usercube.m line 49](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L49) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Usercube.m line 53](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L53) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Table.ToNavigationTable.pqm#L14) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Usercube.m line 51](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L51) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Usercube.m line 241](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L241) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Usercube.m line 275](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Usercube/Usercube.m#L275) |
