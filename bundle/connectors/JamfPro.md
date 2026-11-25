---
type: Power Query Connector
title: Jamf Pro
description: Import data from Jamf Pro
tags: [credentials, key, navigation, packaging, parameter-metadata, response-metadata, retry-polling, usernamepassword, web-requests]
x-pqkb-publisher: Jamf
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/ComputerMappings.pqm
  title: ComputerMappings.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq
  title: JamfPro.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/MobileDeviceMappings.pqm
  title: MobileDeviceMappings.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JamfPro/2.0.0/JamfPro_2.0.0.pqx
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
| Jamf | 2.0.0 | Key, UsernamePassword |

# Source files

* [ComputerMappings.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/ComputerMappings.pqm)
* [JamfPro.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq)
* [MobileDeviceMappings.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/MobileDeviceMappings.pqm)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L259) — `credentials = Extension.CurrentCredential(),`
    * [JamfPro.pq line 261](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L261) — `if credentials[AuthenticationKind] = "Key" then`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L15) — `Documentation.FieldCaption = Extension.LoadString("FunctionParamJamfUrlFieldCaption"),`
    * [JamfPro.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L9) — `shared JamfPro.Contents = Value.ReplaceType(`
    * [JamfPro.pq line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L11) — `type function (`
* [Navigation tables and connection checks](../patterns/navigation.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L44) — `navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")`
    * [JamfPro.pq line 721](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L721) — `NavigationTable.NameColumn = nameColumn,`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L14) — `Documentation.Name = Extension.LoadString("FunctionParamJamfUrlName"),`
* [Response and pagination metadata](../patterns/response-metadata.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L185) — `responseMetadata = Value.Metadata(response),`
    * [JamfPro.pq line 160](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L160) — `Headers = [`
* [Retries, delays, and polling](../patterns/retry-polling.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L190) — `Function.InvokeAfter(`
    * [JamfPro.pq line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L199) — `#duration(0, 0, 0, 3)`
    * [JamfPro.pq line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L49) — `if (Uri.Parts(url)[Scheme] <> "https") then`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [JamfPro.pq line 157](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L157) — `Web.Contents(`
    * [JamfPro.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/JamfPro/JamfPro.pq#L164) — `RelativePath = relativepath,`
