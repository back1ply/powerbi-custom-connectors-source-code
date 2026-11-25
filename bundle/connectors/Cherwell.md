---
type: Power Query Connector
title: Cherwell
description: Connect to Cherwell Service Management
tags: [oauth]
x-pqkb-publisher: Cherwell
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm
  title: Auth.RequestToken.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m
  title: Cherwell.m
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Uri.ValidateUrlScheme.pqm
  title: Uri.ValidateUrlScheme.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cherwell/1.0.0/Cherwell_1.0.0.pqx
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
| Cherwell | 1.0.0 | OAuth |

# Source files

* [Auth.RequestToken.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Auth.RequestToken.pqm)
* [Cherwell.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Table.ToNavigationTable.pqm)
* [Uri.ValidateUrlScheme.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Uri.ValidateUrlScheme.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Cherwell.m line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Cherwell.m line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Cherwell.m line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L73) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Cherwell. [Cherwell.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L7) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Cherwell.SavedSearches. [Cherwell.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Cherwell.m line 23](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L23) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Cherwell.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L30) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Cherwell.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L162) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Cherwell.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L26) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Cherwell.m line 448](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Cherwell/Cherwell.m#L448) |
