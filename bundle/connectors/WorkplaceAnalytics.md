---
type: Power Query Connector
title: Viva Insights
description: Connect to Viva Insights Data
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 3.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq
  title: WorkplaceAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/WorkplaceAnalytics/3.1.0/WorkplaceAnalytics_3.1.0.pqx
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
| Microsoft | 3.1.0 | Aad |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm)
* [Table.ChangeType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Table.ChangeType.pqm)
* [WorkplaceAnalytics.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [WorkplaceAnalytics.pq line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L5) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [WorkplaceAnalytics.pq line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L4) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Diagnostics.pqm line 178](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L178) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for VivaInsights, VivaInsightsApi. [WorkplaceAnalytics.pq line 953](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L953) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: VivaInsights.Data, VivaInsightsApi.GetResults. [WorkplaceAnalytics.pq line 851](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L851) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [WorkplaceAnalytics.pq line 1021](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L1021) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [WorkplaceAnalytics.pq line 1025](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L1025) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [WorkplaceAnalytics.pq line 699](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L699) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [WorkplaceAnalytics.pq line 217](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L217) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [WorkplaceAnalytics.pq line 1042](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L1042) |
