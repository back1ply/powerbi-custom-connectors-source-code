---
type: Power Query Connector
title: Planview ProjectPlace
description: Connect to Planview ProjectPlace
tags: [oauth, oauth2, odata, packaging, parameter-metadata]
x-pqkb-publisher: Planview
x-pqkb-version: 3.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m
  title: PlanviewProjectplace.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PlanviewProjectplace/3.0.0/PlanviewProjectplace_3.0.0.pqx
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
| Planview | 3.0.0 | OAuth |

# Source files

* [PlanviewProjectplace.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [PlanviewProjectplace.m line 140](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L140) — `Documentation.FieldCaption = Extension.LoadString("PlanviewProjectplace.Contents.Parameter.url.FieldCaption"),`
    * [PlanviewProjectplace.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L5) — `shared PlanviewProjectplace.Contents = Value.ReplaceType(PlanviewProjectplace.ContentsInternal, PlanviewProjectplace.ContentsType);`
    * [PlanviewProjectplace.m line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L143) — `t = type function (ODataURL as ODataURL) as table`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [PlanviewProjectplace.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewProjectplace.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewProjectplace.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewProjectplace.m line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L58) — `[client_id = client_id, client_secret = client_secret, code = code, grant_type = "authorization_code"])),`
    * [PlanviewProjectplace.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L53) — `Response = Web.Contents(`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [PlanviewProjectplace.m line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L133) — `content = OData.Feed(ValidateUrlScheme(ODataURL))`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [PlanviewProjectplace.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L14) — `Label = Extension.LoadString("ResourceLabel"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [PlanviewProjectplace.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L5) — `shared PlanviewProjectplace.Contents = Value.ReplaceType(PlanviewProjectplace.ContentsInternal, PlanviewProjectplace.ContentsType);`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Uncertain match (older review)**
    * [PlanviewProjectplace.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L53) — `Response = Web.Contents(`
