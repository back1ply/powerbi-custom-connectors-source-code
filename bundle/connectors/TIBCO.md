---
type: Power Query Connector
title: TIBCO.ODBC.TDV
description: Connect to TIBCO.ODBC.TDV
tags: [credentials, implicit, odbc, packaging, parameter-metadata, usernamepassword, windows]
x-pqkb-publisher: TIBCO
x-pqkb-version: 20.0.7806
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m
  title: TIBCO.ODBC.TDV.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TIBCO/20.0.7806/TIBCO_20.0.7806.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-02T11:27:27Z'
stale_after: '2026-11-16T11:27:27Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| TIBCO | 20.0.7806 | Implicit, UsernamePassword, Windows |

# Source files

* [TIBCO.ODBC.TDV.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [TIBCO.ODBC.TDV.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L62) — `Credential = Extension.CurrentCredential(),`
    * [TIBCO.ODBC.TDV.m line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L67) — `if (Credential[AuthenticationKind]?) = "UsernamePassword" then`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [TIBCO.ODBC.TDV.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L128) — `Documentation.FieldCaption = Extension.LoadString("DSNFieldCaption"),`
    * [TIBCO.ODBC.TDV.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L9) — `shared TibcoTdv.DataSource = Value.ReplaceType(DatabaseImpl, DatabaseType);`
    * [TIBCO.ODBC.TDV.m line 126](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L126) — `DatabaseType = type function(`
* [ODBC and DirectQuery configuration](../patterns/odbc.md)
  * **Match from a review of older source**
    * [TIBCO.ODBC.TDV.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L40) — `sysInfo = Odbc.Query(connectionString, "SELECT VALUE FROM sys_sqlinfo WHERE NAME = 'SUPPORTS_MULTIPLE_CATALOGS'"),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [TIBCO.ODBC.TDV.m line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/TIBCO/TIBCO.ODBC.TDV.m#L128) — `Documentation.FieldCaption = Extension.LoadString("DSNFieldCaption"),`
