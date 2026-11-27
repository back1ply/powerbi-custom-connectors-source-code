---
type: Power Query Connector
title: Funnel
description: Power BI connector source for Funnel.
tags: [oauth]
x-pqkb-publisher: Funnel
x-pqkb-version: 5.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm
  title: DataLoading.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq
  title: Funnel.pq
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm
  title: NavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Funnel/5.0.1/Funnel_5.0.1.pqx
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
| Funnel | 5.0.1 | OAuth |

# Source files

* [DataLoading.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm)
* [Funnel.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq)
* [NavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm)
* [OAuth.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/OAuth.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Funnel.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Funnel.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [NavigationTable.pqm line 15](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L15) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Funnel. [Funnel.pq line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L9) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Funnel.Contents. [Funnel.pq line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [Funnel.pq line 24](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L24) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Funnel.pq line 28](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L28) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [NavigationTable.pqm line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/NavigationTable.pqm#L47) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [DataLoading.pqm line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L10) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [DataLoading.pqm line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/DataLoading.pqm#L10) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Funnel.pq line 38](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Funnel/Funnel.pq#L38) |
