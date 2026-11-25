---
type: Power Query Connector
title: Zucchetti
description: Power BI connector source for Zucchetti.
tags: [usernamepassword]
x-pqkb-publisher: Zuchetti
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m
  title: Zucchetti.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Zucchetti/1.0.1/Zucchetti_1.0.1.pqx
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
| Zuchetti | 1.0.1 | UsernamePassword |

# Source files

* [Zucchetti.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Zucchetti.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L5) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Zucchetti.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L4) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Zucchetti.m line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L83) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Zucchetti. [Zucchetti.m line 48](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L48) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Zucchetti.Contents. [Zucchetti.m line 7](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L7) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [Zucchetti.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L64) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Zucchetti.m line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L68) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Zucchetti.m line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L21) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Zucchetti.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Zucchetti/Zucchetti.m#L60) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
