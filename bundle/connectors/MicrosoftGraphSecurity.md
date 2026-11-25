---
type: Power Query Connector
title: Microsoft Graph Security
description: Connect to Microsoft Graph Security API
tags: [oauth]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m
  title: MicrosoftGraphSecurity.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrosoftGraphSecurity/1.0.2/MicrosoftGraphSecurity_1.0.2.pqx
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
| Microsoft | 1.0.2 | OAuth |

# Source files

* [MicrosoftGraphSecurity.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MicrosoftGraphSecurity.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MicrosoftGraphSecurity.m line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MicrosoftGraphSecurity.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L80) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MicrosoftGraphSecurity. [MicrosoftGraphSecurity.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L126) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MicrosoftGraphSecurity.Contents. [MicrosoftGraphSecurity.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L49) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [MicrosoftGraphSecurity.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L143) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [MicrosoftGraphSecurity.m line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L146) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [MicrosoftGraphSecurity.m line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L73) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MicrosoftGraphSecurity.m line 136](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L136) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [MicrosoftGraphSecurity.m line 277](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L277) |
