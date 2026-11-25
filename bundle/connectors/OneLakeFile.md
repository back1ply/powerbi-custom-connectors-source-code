---
type: Power Query Connector
title: OneLake Files
description: Power BI connector source for OneLake Files.
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.2.13
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq
  title: OneLakeFile.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm
  title: Table.NavigationTableView.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm
  title: Utils.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm
  title: Workspace.PrivateLink.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm
  title: Workspace.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/OneLakeFile/1.2.13/OneLakeFile_1.2.13.pqx
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
| Microsoft | 1.2.13 | Aad |

# Source files

* [OneLakeFile.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq)
* [Table.NavigationTableView.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Table.NavigationTableView.pqm)
* [Utils.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm)
* [Workspace.PrivateLink.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.PrivateLink.pqm)
* [Workspace.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Workspace.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [OneLakeFile.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [OneLakeFile.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [OneLakeFile.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L144) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for OneLakeFile. [OneLakeFile.pq line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L40) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Fail | Shared function OneLake.Contents (kind OneLakeFile) does not follow DataSourceKind.FunctionName or uses 'Power BI', 'Connector', or 'API'. [OneLakeFile.pq line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L136) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [OneLakeFile.pq line 302](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L302) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [OneLakeFile.pq line 308](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L308) |
| Provide a navigation table. | SHOULD | Fail | No navigation table found. |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [OneLakeFile.pq line 144](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L144) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [Utils.pqm line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/Utils.pqm#L432) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [OneLakeFile.pq line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L213) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [OneLakeFile.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/OneLakeFile/OneLakeFile.pq#L10) |
