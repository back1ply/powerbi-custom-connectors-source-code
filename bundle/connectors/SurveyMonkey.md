---
type: Power Query Connector
title: SurveyMonkey
description: Connect to SurveyMonkey
tags: [key]
x-pqkb-publisher: SurveyMonkey
x-pqkb-version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm
  title: FetchResource.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m
  title: SurveyMonkey.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SurveyMonkey/1.1.0/SurveyMonkey_1.1.0.pqx
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
| SurveyMonkey | 1.1.0 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/Diagnostics.pqm)
* [FetchResource.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/FetchResource.pqm)
* [SurveyMonkey.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [SurveyMonkey.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [SurveyMonkey.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [SurveyMonkey.m line 17](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L17) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for SurveyMonkey. [SurveyMonkey.m line 127](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L127) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: SurveyMonkey.Contents. [SurveyMonkey.m line 12](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L12) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [SurveyMonkey.m line 140](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L140) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [SurveyMonkey.m line 144](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L144) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [SurveyMonkey.m line 78](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L78) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [SurveyMonkey.m line 142](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L142) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [SurveyMonkey.m line 66](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L66) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [SurveyMonkey.m line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L5) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [SurveyMonkey.m line 155](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/SurveyMonkey/SurveyMonkey.m#L155) |
