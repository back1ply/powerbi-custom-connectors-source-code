---
type: Power Query Connector
title: Planview OKR
description: Connect to Planview OKR
tags: [oauth, oauth2, odata, packaging, parameter-metadata, pkce, web-requests]
x-pqkb-publisher: Planview
x-pqkb-version: 2.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m
  title: PlanviewOKR.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PlanviewOKR/2.0.2/PlanviewOKR_2.0.2.pqx
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
| Planview | 2.0.2 | OAuth |

# Source files

* [PlanviewOKR.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 180](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L180) — `Documentation.FieldCaption = Extension.LoadString("PlanviewOKR.Contents.Parameter.url.FieldCaption"),`
    * [PlanviewOKR.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L5) — `shared PlanviewOKR.Contents = Value.ReplaceType(PlanviewOKR.ContentsInternal, PlanviewOKR.ContentsType);`
    * [PlanviewOKR.m line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L183) — `t = type function (ODataURL as ODataUrl) as table`
* [OAuth2 login and token refresh](../patterns/oauth2.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewOKR.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewOKR.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L13) — `Authentication = [OAuth = [StartLogin = StartLogin, FinishLogin = FinishLogin, Refresh = Refresh]],`
    * [PlanviewOKR.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L65) — `[code = code, grant_type = "authorization_code", code_verifier = verifier , client_id = client_id, redirect_uri = redirect_uri])),`
    * [PlanviewOKR.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L60) — `Response = Web.Contents(`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L173) — `content = OData.Feed(ValidateUrlScheme(OdataUrl))`
* [PKCE and URL-safe encoding](../patterns/pkce.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L85) — `code_challenge = Base64UrlEncodeWithoutPadding(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
    * [PlanviewOKR.m line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L65) — `[code = code, grant_type = "authorization_code", code_verifier = verifier , client_id = client_id, redirect_uri = redirect_uri])),`
    * [PlanviewOKR.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L85) — `code_challenge = Base64UrlEncodeWithoutPadding(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L14) — `Label = Extension.LoadString("ResourceLabel"),`
* [Web requests and relative paths](../patterns/web-requests.md)
  * **Match from a review of older source**
    * [PlanviewOKR.m line 60](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/PlanviewOKR/PlanviewOKR.m#L60) — `Response = Web.Contents(`
