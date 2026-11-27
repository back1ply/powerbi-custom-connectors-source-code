---
type: Power Query Connector
title: Siteimprove
description: Connect to Siteimprove
tags: [usernamepassword]
x-pqkb-publisher: SiteImprove
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq
  title: Siteimprove.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SiteImprove/1.1.0/SiteImprove_1.1.0.pqx
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
| SiteImprove | 1.1.0 | UsernamePassword |

# Source files

* [Siteimprove.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq)
* [Table.ChangeType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Siteimprove.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Siteimprove.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Siteimprove.pq line 34](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L34) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Siteimprove. [Siteimprove.pq line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L9) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Siteimprove.Contents. [Siteimprove.pq line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L5) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Siteimprove.pq line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L19) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Siteimprove.pq line 23](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L23) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Siteimprove.pq line 58](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L58) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Siteimprove.pq line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L14) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Siteimprove.pq line 168](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SiteImprove/Siteimprove.pq#L168) |
