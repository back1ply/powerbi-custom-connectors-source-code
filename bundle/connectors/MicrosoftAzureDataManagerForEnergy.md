---
type: Power Query Connector
title: MicrosoftAzureDataManagerForEnergy
description: Power BI connector source for MicrosoftAzureDataManagerForEnergy.
tags: [aad]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq
  title: MicrosoftAzureDataManagerForEnergy.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrosoftAzureDataManagerForEnergy/1.0.1/MicrosoftAzureDataManagerForEnergy_1.0.1.pqx
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
| Microsoft | 1.0.1 | Aad |

# Source files

* [MicrosoftAzureDataManagerForEnergy.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MicrosoftAzureDataManagerForEnergy.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L5) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MicrosoftAzureDataManagerForEnergy.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L3) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MicrosoftAzureDataManagerForEnergy.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L16) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MicrosoftAzureDataManagerForEnergy. [MicrosoftAzureDataManagerForEnergy.pq line 195](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L195) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MicrosoftAzureDataManagerForEnergy.Search. [MicrosoftAzureDataManagerForEnergy.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L11) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [MicrosoftAzureDataManagerForEnergy.pq line 217](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L217) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [MicrosoftAzureDataManagerForEnergy.pq line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L221) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [MicrosoftAzureDataManagerForEnergy.pq line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L74) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MicrosoftAzureDataManagerForEnergy.pq line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L16) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
