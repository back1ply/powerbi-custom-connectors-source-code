---
type: Power Query Connector
title: Emigo Data Source
description: Connect with Emigo Data Source
tags: [odata, packaging, parameter-metadata, usernamepassword]
x-pqkb-publisher: Sagra
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m
  title: Emigo.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Emigo/1.0.6/Emigo_1.0.6.pqx
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
| Sagra | 1.0.6 | UsernamePassword |

# Source files

* [Emigo.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m)

# Pattern evidence

* [Function parameters and data-source identity](../patterns/parameter-metadata.md)
  * **Match from a review of older source**
    * [Emigo.m line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L53) — `Documentation.FieldCaption = Extension.LoadString("DataRestrictionType") ,`
    * [Emigo.m line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L46) — `shared Emigo.Contents =Value.ReplaceType(EmigoDataSourceConnector.NavigationWithCustomError, EmigoDataSourceConnector.NavigationFunctionType); //EmigoDataSourceConnector.Navigation; //production`
    * [Emigo.m line 51](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L51) — `shared EmigoDataSourceConnector.NavigationFunctionType = type function (`
* [OData feeds](../patterns/odata.md)
  * **Match from a review of older source**
    * [Emigo.m line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L234) — `feeeeed = OData.Feed(_Url, null, [Query = [RestrictData =  _RestrictData, RestrictType = OgraniczenieExactTmp]]),`
* [Resources and modular source loading](../patterns/packaging.md)
  * **Match from a review of older source**
    * [Emigo.m line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L18) — `UsernameLabel =Extension.LoadString("LoginUsernameLabel"),`
* [Schema and type enforcement](../patterns/schema.md)
  * **Uncertain match (older review)**
    * [Emigo.m line 46](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Emigo/Emigo.m#L46) — `shared Emigo.Contents =Value.ReplaceType(EmigoDataSourceConnector.NavigationWithCustomError, EmigoDataSourceConnector.NavigationFunctionType); //EmigoDataSourceConnector.Navigation; //production`
