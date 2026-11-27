---
type: Power Query Connector
title: Asana
description: Connect to Asana
tags: [oauth]
x-pqkb-publisher: Asana
x-pqkb-version: 1.0.3
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m
  title: Asana.m
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Asana/1.0.3/Asana_1.0.3.pqx
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
| Asana | 1.0.3 | OAuth |

# Source files

* [Asana.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Asana.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Asana.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Asana.m line 16](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L16) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Asana. [Asana.m line 81](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L81) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Asana.Tables. [Asana.m line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L11) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Asana.m line 94](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L94) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Asana.m line 98](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L98) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Asana.m line 32](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L32) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Asana.m line 16](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L16) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Asana.m line 194](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L194) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Asana.m line 243](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Asana/Asana.m#L243) |
