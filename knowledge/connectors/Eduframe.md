---
type: Power Query Connector
title: Eduframe
description: Power BI connector source for Eduframe.
tags: [credentials, errors, key, navigation, oauth, oauth2, packaging, response-metadata, retry-polling, schema]
publisher: Eduframe
version: 2.3.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq
  title: EduFrame.pq
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm
  title: Requests.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Eduframe/2.3.0/Eduframe_2.3.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Eduframe | 2.3.0 | Key, OAuth |

# Source files

* [EduFrame.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq)
* [Requests.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Requests.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L27)
* [Navigation tables and connection checks](../patterns/navigation.md): [EduFrame.pq line 143](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L143)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [EduFrame.pq line 253](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L253)
* [Resources and modular source loading](../patterns/packaging.md): [EduFrame.pq line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L5)
* [Response and pagination metadata](../patterns/response-metadata.md): [Requests.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L20)
* [Retries, delays, and polling](../patterns/retry-polling.md): [Requests.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L9)
* [Schema and type enforcement](../patterns/schema.md): [EduFrame.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L14)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Requests.pqm line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L17)
