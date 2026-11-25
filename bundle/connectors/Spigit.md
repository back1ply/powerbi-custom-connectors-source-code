---
type: Power Query Connector
title: Planview IdeaPlace
description: Connect to Planview IdeaPlace
tags: [oauth, odata, packaging, parameter-metadata]
x-pqkb-publisher: Planview
x-pqkb-version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m
  title: Spigit.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Spigit/2.0.0/Spigit_2.0.0.pqx
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
| Planview | 2.0.0 | OAuth |

# Source files

* [Spigit.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Spigit.m line 139](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L139) — `Documentation.FieldCaption = Extension.LoadString("Spigit.Contents.Parameter.url.FieldCaption"),`
    * [Spigit.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L5) — `shared Spigit.Contents = Value.ReplaceType(Spigit.ContentsInternal, Spigit.ContentsType);`
    * [Spigit.m line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L142) — `t = type function (ODataURL as ODataURL) as table`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Uncertain match (older review)**
    * [Spigit.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [Spigit.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [Spigit.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [Spigit.m line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L59) — `[client_id = client_id, code = code, grant_type = "authorization_code", redirect_uri = redirect_uri, scope = "", token_endpoint = token_endpoint, sslValidate = "true" ])),`
    * [Spigit.m line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L54) — `Response = Web.Contents(`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [Spigit.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L132) — `content = OData.Feed(ValidateUrlScheme(ODataURL), null, [ODataVersion = 4, Implementation = "2.0"])`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Spigit.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L14) — `Label = Extension.LoadString("ResourceLabel"),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [Spigit.m line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Spigit/Spigit.m#L54) — `Response = Web.Contents(`
