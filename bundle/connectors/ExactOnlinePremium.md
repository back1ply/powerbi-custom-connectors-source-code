---
type: Power Query Connector
title: Exact Online Premium
description: Connect to Exact Online Premium
tags: [oauth]
x-pqkb-publisher: ExactOnlinePremium
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m
  title: ExactOnlinePremium.m
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm
  title: OAuth.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ExactOnlinePremium/1.0.1/ExactOnlinePremium_1.0.1.pqx
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
| ExactOnlinePremium | 1.0.1 | OAuth |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm)
* [ExactOnlinePremium.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m)
* [OAuth.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/OAuth.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ExactOnlinePremium.m line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ExactOnlinePremium.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [ExactOnlinePremium.m line 18](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L18) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ExactOnlinePremium. [ExactOnlinePremium.m line 118](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L118) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ExactOnlinePremium.Contents. [ExactOnlinePremium.m line 12](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L12) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [ExactOnlinePremium.m line 133](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L133) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ExactOnlinePremium.m line 137](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L137) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [ExactOnlinePremium.m line 108](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L108) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ExactOnlinePremium.m line 18](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L18) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [Diagnostics.pqm line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/Diagnostics.pqm#L2) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [ExactOnlinePremium.m line 163](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L163) |
