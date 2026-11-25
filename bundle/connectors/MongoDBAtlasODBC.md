---
type: Power Query Connector
title: MongoDB Atlas SQL
description: Connect to MongoDB Atlas SQL
tags: [usernamepassword]
x-pqkb-publisher: MongoDBAtlasODBC
x-pqkb-version: 1.2.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq
  title: MongoDBAtlasODBC.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MongoDBAtlasODBC/1.2.4/MongoDBAtlasODBC_1.2.4.pqx
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
| MongoDBAtlasODBC | 1.2.4 | UsernamePassword |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/Diagnostics.pqm)
* [MongoDBAtlasODBC.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [MongoDBAtlasODBC.pq line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L3) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [MongoDBAtlasODBC.pq line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [MongoDBAtlasODBC.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L25) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for MongoDBAtlasODBC. [MongoDBAtlasODBC.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L122) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: MongoDBAtlasODBC.Contents. [MongoDBAtlasODBC.pq line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L12) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [MongoDBAtlasODBC.pq line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L140) |
| Have icons. | SHOULD | Fail | No SourceImage in a Publish record. |
| Provide a navigation table. | SHOULD | Pass | Navigation comes from the source function. [MongoDBAtlasODBC.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L47) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [MongoDBAtlasODBC.pq line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L142) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [MongoDBAtlasODBC.pq line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L55) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | Pass | Tracing is gated by a flag. [MongoDBAtlasODBC.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L9) |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [MongoDBAtlasODBC.pq line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MongoDBAtlasODBC/MongoDBAtlasODBC.pq#L209) |
