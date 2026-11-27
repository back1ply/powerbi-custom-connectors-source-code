---
type: Power Query Connector
title: kxkdbinsightsenterprise
description: Power BI connector source for kxkdbinsightsenterprise.
tags: [oauth]
x-pqkb-publisher: KX
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm
  title: AuthHelpers.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm
  title: CommonHelpers.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq
  title: kxkdbinsightsenterprise.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/kxkdbinsightsenterprise/1.0.0/kxkdbinsightsenterprise_1.0.0.pqx
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
| KX | 1.0.0 | OAuth |

# Source files

* [AuthHelpers.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm)
* [CommonHelpers.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm)
* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm)
* [kxkdbinsightsenterprise.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [kxkdbinsightsenterprise.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [kxkdbinsightsenterprise.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [kxkdbinsightsenterprise.pq line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L44) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for kxkdbinsightsenterprise. [kxkdbinsightsenterprise.pq line 563](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L563) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: kxkdbinsightsenterprise.Contents. [kxkdbinsightsenterprise.pq line 34](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L34) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [kxkdbinsightsenterprise.pq line 533](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L533) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [kxkdbinsightsenterprise.pq line 540](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L540) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [CommonHelpers.pqm line 59](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L59) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AuthHelpers.pqm line 44](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L44) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/Diagnostics.pqm#L5) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Review | CommonHelpers.pqm evaluates an expression not loaded from the package. [CommonHelpers.pqm line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L1) |
