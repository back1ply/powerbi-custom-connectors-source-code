---
type: Power Query Connector
title: Jamf Pro
description: Import data from Jamf Pro
tags: [credentials, errors, key, navigation, packaging, response-metadata, retry-polling, schema, usernamepassword, web-requests]
publisher: Jamf
version: 2.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/ComputerMappings.pqm
  title: ComputerMappings.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq
  title: JamfPro.pq
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/MobileDeviceMappings.pqm
  title: MobileDeviceMappings.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/JamfPro/2.0.0/JamfPro_2.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Jamf | 2.0.0 | Key, UsernamePassword |

# Source files

* [ComputerMappings.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/ComputerMappings.pqm)
* [JamfPro.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq)
* [MobileDeviceMappings.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/MobileDeviceMappings.pqm)

# Detected patterns

* [Credential access](../patterns/credentials.md): [JamfPro.pq line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L259)
* [Navigation tables and connection checks](../patterns/navigation.md): [JamfPro.pq line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L44)
* [Resources and modular source loading](../patterns/packaging.md): [JamfPro.pq line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L14)
* [Response and pagination metadata](../patterns/response-metadata.md): [JamfPro.pq line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L185)
* [Retries, delays, and polling](../patterns/retry-polling.md): [JamfPro.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L190)
* [Schema and type enforcement](../patterns/schema.md): [JamfPro.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L9)
* [Structured errors and HTTP status handling](../patterns/errors.md): [JamfPro.pq line 165](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L165)
* [Web requests and relative paths](../patterns/web-requests.md): [JamfPro.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L164)
