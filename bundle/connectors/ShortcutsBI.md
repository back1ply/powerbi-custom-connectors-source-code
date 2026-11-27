---
type: Power Query Connector
title: Shortcuts Business Insights
description: Connect to Shortcuts Business Insights
tags: [key]
x-pqkb-publisher: Shortcuts
x-pqkb-version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm
  title: Function.ExtractCommunityID.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetAccessCode.pqm
  title: Function.GetAccessCode.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm
  title: Function.GetData.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm
  title: Function.OAuthSignatureGenerator.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm
  title: Function.RandomStringGenerator.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.TimestampGenerator.pqm
  title: Function.TimestampGenerator.pqm
- id: file-7
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq
  title: ShortcutsBI.pq
- id: file-8
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/ShortcutsBI/1.0.0/ShortcutsBI_1.0.0.pqx
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
| Shortcuts | 1.0.0 | Key |

# Source files

* [Function.ExtractCommunityID.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.ExtractCommunityID.pqm)
* [Function.GetAccessCode.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetAccessCode.pqm)
* [Function.GetData.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.GetData.pqm)
* [Function.OAuthSignatureGenerator.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.OAuthSignatureGenerator.pqm)
* [Function.RandomStringGenerator.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.RandomStringGenerator.pqm)
* [Function.TimestampGenerator.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Function.TimestampGenerator.pqm)
* [ShortcutsBI.pq](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [ShortcutsBI.pq line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [ShortcutsBI.pq line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L1) |
| Provide function documentation metadata. | MUST | Fail | No Documentation.* metadata. |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for ShortcutsBI. [ShortcutsBI.pq line 87](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L87) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: ShortcutsBI.Contents. [ShortcutsBI.pq line 24](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L24) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [ShortcutsBI.pq line 97](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L97) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [ShortcutsBI.pq line 100](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L100) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Table.ToNavigationTable.pqm line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/Table.ToNavigationTable.pqm#L3) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [ShortcutsBI.pq line 90](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L90) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [ShortcutsBI.pq line 30](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L30) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [ShortcutsBI.pq line 5](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/ShortcutsBI/ShortcutsBI.pq#L5) |
