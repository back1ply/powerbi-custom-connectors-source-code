---
type: Power Query Connector
title: Autodesk Construction Cloud
description: Connect to Autodesk Construction Cloud
tags: [oauth]
x-pqkb-publisher: Autodesk
x-pqkb-version: 1.8.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq
  title: AutodeskConstructionCloud.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm
  title: Diagnostics.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutodeskConstructionCloud/1.8.1/AutodeskConstructionCloud_1.8.1.pqx
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
| Autodesk | 1.8.1 | OAuth |

# Source files

* [AutodeskConstructionCloud.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq)
* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/Diagnostics.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [AutodeskConstructionCloud.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [AutodeskConstructionCloud.pq line 1](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [AutodeskConstructionCloud.pq line 248](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L248) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for AutodeskConstructionCloud. [AutodeskConstructionCloud.pq line 123](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L123) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: AutodeskConstructionCloud.Feed, AutodeskConstructionCloud.Contents. [AutodeskConstructionCloud.pq line 141](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L141) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [AutodeskConstructionCloud.pq line 728](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L728) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [AutodeskConstructionCloud.pq line 732](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L732) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [AutodeskConstructionCloud.pq line 149](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L149) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [AutodeskConstructionCloud.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L5) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Review | Tracing without a recognised flag. [AutodeskConstructionCloud.pq line 562](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L562) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [AutodeskConstructionCloud.pq line 685](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L685) |
