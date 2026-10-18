---
type: Power Query Connector
title: Planview OKR
description: Connect to Planview OKR
tags: [navigation, oauth, oauth2, odata, packaging, pkce, schema]
publisher: Planview
version: 2.0.2
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m
  title: PlanviewOKR.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/PlanviewOKR/2.0.2/PlanviewOKR_2.0.2.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Planview | 2.0.2 | OAuth |

# Source files

* [PlanviewOKR.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [PlanviewOKR.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L12)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [PlanviewOKR.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L13)
* [OData feeds](../patterns/odata.md): [PlanviewOKR.m line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L173)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [PlanviewOKR.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L85)
* [Resources and modular source loading](../patterns/packaging.md): [PlanviewOKR.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L14)
* [Schema and type enforcement](../patterns/schema.md): [PlanviewOKR.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L5)
