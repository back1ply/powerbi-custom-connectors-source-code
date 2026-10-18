---
type: Power Query Connector
title: Automy Analytics
description: Obtain information on a process through a direct connection with AUTOMY
tags: [credentials, errors, key, navigation, packaging, response-metadata, schema]
publisher: AceRoyalty
version: 1.2.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq
  title: AutomyDataAnalytics.pq
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/AutomyDataAnalytics/1.2.1/AutomyDataAnalytics_1.2.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| AceRoyalty | 1.2.1 | Key |

# Source files

* [AutomyDataAnalytics.pq](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq)

# Detected patterns

* [Credential access](../patterns/credentials.md): [AutomyDataAnalytics.pq line 10](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L10)
* [Navigation tables and connection checks](../patterns/navigation.md): [AutomyDataAnalytics.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L19)
* [Resources and modular source loading](../patterns/packaging.md): [AutomyDataAnalytics.pq line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L15)
* [Response and pagination metadata](../patterns/response-metadata.md): [AutomyDataAnalytics.pq line 86](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L86)
* [Schema and type enforcement](../patterns/schema.md): [AutomyDataAnalytics.pq line 458](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L458)
* [Structured errors and HTTP status handling](../patterns/errors.md): [AutomyDataAnalytics.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutomyDataAnalytics/AutomyDataAnalytics.pq#L83)
