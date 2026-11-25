---
type: Power Query Connector
title: AutomationAnywhere
description: Connect to Automation Anywhere
tags: [credentials, packaging, parameter-metadata, usernamepassword, web-requests]
x-pqkb-publisher: Automation Anywhere
x-pqkb-version: 1.0.4
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m
  title: AutomationAnywhere.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutomationAnywhere/1.0.4/AutomationAnywhere_1.0.4.pqx
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
| Automation Anywhere | 1.0.4 | UsernamePassword |

# Source files

* [AutomationAnywhere.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m)

# Pattern evidence

* [Credential access](../patterns/credentials.md)
  * **Match from a review of older source**
    * [AutomationAnywhere.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L34) — `CRusername = Extension.CurrentCredential()[Username],`
    * [AutomationAnywhere.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L34) — `CRusername = Extension.CurrentCredential()[Username],`
* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [AutomationAnywhere.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L12) — `Documentation.FieldCaption = "Control Room Version",`
    * [AutomationAnywhere.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L6) — `shared AutomationAnywhere.Feed  = Value.ReplaceType(AutomationAnywhereImpl, AutomationAnywhereType);`
    * [AutomationAnywhere.m line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L10) — `AutomationAnywhereType = type function (`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [AutomationAnywhere.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L15) — `Documentation.AllowedValues = {Extension.LoadString("ElevenxVersion"), Extension.LoadString("A2019Version"), Extension.LoadString("ElevenThreeFiveOneVersion")}`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [AutomationAnywhere.m line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AutomationAnywhere/AutomationAnywhere.m#L49) — `tokenResonse = Json.Document(Web.Contents(AuthenticationUrl, options)),`
