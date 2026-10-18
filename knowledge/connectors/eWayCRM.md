---
type: Power Query Connector
title: eWay-CRM
description: Connect to eWay-CRM
tags: [credentials, navigation, oauth, oauth2, packaging, pkce, schema]
publisher: eWayCRM
version: 2.2.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m
  title: eWay_CRM.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/eWayCRM/2.2.0/eWayCRM_2.2.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| eWayCRM | 2.2.0 | OAuth |

# Source files

* [eWay_CRM.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [eWay_CRM.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L13)
* [Navigation tables and connection checks](../patterns/navigation.md): [eWay_CRM.m line 326](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L326)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [eWay_CRM.m line 370](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L370)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [eWay_CRM.m line 378](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L378)
* [Resources and modular source loading](../patterns/packaging.md): [eWay_CRM.m line 358](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L358)
* [Schema and type enforcement](../patterns/schema.md): [eWay_CRM.m line 6](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L6)
