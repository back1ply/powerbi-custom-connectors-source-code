---
type: Power Query Connector
title: Assemble Views
description: Connect to Assemble Views
tags: [oauth]
x-pqkb-publisher: Autodesk
x-pqkb-version: 4.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m
  title: AssembleViews.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AssembleViews/4.1.0/AssembleViews_4.1.0.pqx
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
| Autodesk | 4.1.0 | OAuth |

# Source files

* [AssembleViews.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AssembleViews.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AssembleViews.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AssembleViews.m line 9](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L9) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AssembleViews. [AssembleViews.m line 789](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L789) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AssembleViews.Feed, AssembleViews.Contents. [AssembleViews.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AssembleViews.m line 887](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L887) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AssembleViews.m line 891](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L891) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AssembleViews.m line 24](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L24) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AssembleViews.m line 801](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L801) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [AssembleViews.m line 346](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L346) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Review | ModelsQuery evaluates an expression not loaded from the package. [AssembleViews.m line 305](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/AssembleViews/AssembleViews.m#L305) |
