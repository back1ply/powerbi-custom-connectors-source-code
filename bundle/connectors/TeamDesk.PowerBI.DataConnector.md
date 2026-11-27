---
type: Power Query Connector
title: TeamDesk.PowerBI.DataConnector
description: Power BI connector source for TeamDesk.PowerBI.DataConnector.
tags: [key, usernamepassword]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m
  title: TeamDesk.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamDesk/1.0.2/TeamDesk_1.0.2.pqx
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
| Microsoft | 1.0.2 | Key, UsernamePassword |

# Source files

* [TeamDesk.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [TeamDesk.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L4) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [TeamDesk.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L2) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [TeamDesk.m line 42](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L42) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for TeamDesk. [TeamDesk.m line 10](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L10) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: TeamDesk.Database, TeamDesk.SelectView, TeamDesk.Select. [TeamDesk.m line 39](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L39) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = true in this version. [TeamDesk.m line 26](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L26) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [TeamDesk.m line 30](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L30) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [TeamDesk.m line 157](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L157) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [TeamDesk.m line 11](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L11) |
| Send credentials only over HTTPS. | SECURITY | Review | Credentials used; no explicit https check found. [TeamDesk.m line 266](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L266) |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | Pass | No credential in a Query record. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | N/A | No Expression.Evaluate use. |
