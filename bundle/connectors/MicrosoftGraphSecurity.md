---
type: Power Query Connector
title: Microsoft Graph Security
description: Connect to Microsoft Graph Security API
tags: [errors, navigation, oauth, oauth2, odata, packaging, parameter-metadata, schema, web-requests]
x-pqkb-publisher: Microsoft
x-pqkb-version: 1.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m
  title: MicrosoftGraphSecurity.m
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/MicrosoftGraphSecurity/1.0.2/MicrosoftGraphSecurity_1.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-25T11:49:44Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Microsoft | 1.0.2 | OAuth |

# Source files

* [MicrosoftGraphSecurity.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L80) — `Documentation.FieldCaption = " Select Mirosoft Graph Security API Version",`
    * [MicrosoftGraphSecurity.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L50) — `shared MicrosoftGraphSecurity.Contents = Value.ReplaceType(MicrosoftGraphSecurityImpl, MicrosoftGraphSecurityType);`
    * [MicrosoftGraphSecurity.m line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L78) — `MicrosoftGraphSecurityType = type function (`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 73](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L73) — `asNav = Table.ToNavigationTable(withFunction, {"Entity"}, "DisplayName", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm#L14) — `NavigationTable.NameColumn = nameColumn,`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L129) — `OAuth = [`
    * [MicrosoftGraphSecurity.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L130) — `StartLogin=StartLogin,`
    * [MicrosoftGraphSecurity.m line 131](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L131) — `FinishLogin=FinishLogin,`
    * [MicrosoftGraphSecurity.m line 243](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L243) — `grant_type = grantType,`
    * [MicrosoftGraphSecurity.m line 248](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L248) — `tokenResponse = Web.Contents(token_uri, [`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L112) — `root = OData.Feed(urlWithFilter, null, options)`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 4](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L4) — `client_id = Text.FromBinary(Extension.Contents("client_id"));`
* [Schema and type enforcement](../patterns/schema.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L50) — `shared MicrosoftGraphSecurity.Contents = Value.ReplaceType(MicrosoftGraphSecurityImpl, MicrosoftGraphSecurityType);`
    * [MicrosoftGraphSecurity.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L33) — `type table [`
    * [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/Table.ToNavigationTable.pqm#L20) — `navigationTable = Value.ReplaceType(table, newTableType)`
* [Structured errors and HTTP status handling](../patterns/errors.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 223](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L223) — `error Error.Record(parts[error], parts[error_description], parts)`
    * [MicrosoftGraphSecurity.m line 119](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L119) — `error "Unsupported version: " & version & ". Expected: " & Text.Combine(SupportedVersions, ",")`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [MicrosoftGraphSecurity.m line 248](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L248) — `tokenResponse = Web.Contents(token_uri, [`
