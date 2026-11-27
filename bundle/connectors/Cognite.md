---
type: Power Query Connector
title: Cognite Data Fusion (OData)
description: Connect to Cognite Data Fusion (CDF)
tags: [aad]
x-pqkb-publisher: Cognite
x-pqkb-version: 1.0.9
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq
  title: Cognite.pq
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm
  title: Value.ToText.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Cognite/1.0.9/Cognite_1.0.9.pqx
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
| Cognite | 1.0.9 | Aad |

# Source files

* [Cognite.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq)
* [Value.ToText.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Value.ToText.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [Cognite.pq line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [Cognite.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Cognite.pq line 52](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L52) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for Cognite. [Cognite.pq line 67](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L67) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: Cognite.Contents. [Cognite.pq line 47](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L47) |
| Set the Beta flag to true on the initial release. | MUST | Info | No Beta flag in the Publish record. |
| Have icons. | SHOULD | Pass | Publish record sets icons. [Cognite.pq line 118](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L118) |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [Cognite.pq line 147](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L147) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [Cognite.pq line 52](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L52) |
| Send credentials only over HTTPS. | SECURITY | Pass | Validates the https scheme. [Cognite.pq line 12](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L12) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [Cognite.pq line 267](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/Cognite/Cognite.pq#L267) |
