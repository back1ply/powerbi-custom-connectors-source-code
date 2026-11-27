---
type: Power Query Connector
title: Palantir Foundry Datasets
description: Connect to Palantir Foundry datasets
tags: [key, oauth, usernamepassword]
x-pqkb-publisher: Palantir
x-pqkb-version: 1.3.1
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m
  title: Foundry.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Foundry/1.3.1/Foundry_1.3.1.pqx
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
| Palantir | 1.3.1 | Key, OAuth, UsernamePassword |

# Source files

* [Foundry.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Foundry.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Foundry.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Foundry.m line 25](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L25) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Foundry. [Foundry.m line 364](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L364) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Foundry.Contents. [Foundry.m line 19](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L19) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Foundry.m line 395](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L395) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Foundry.m line 113](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L113) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Foundry.m line 25](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L25) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Foundry.m line 243](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Foundry/Foundry.m#L243) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
