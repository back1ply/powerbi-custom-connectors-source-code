---
type: Power Query Connector
title: CloudBluePSA
description: Power BI connector source for CloudBluePSA.
tags: [credentials, key, navigation, packaging, retry-polling, schema]
publisher: CloudBluePSA
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m
  title: CloudBluePSAConnector.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/CloudBluePSA/1.0.1/CloudBluePSA_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| CloudBluePSA | 1.0.1 | Key |

# Source files

* [CloudBluePSAConnector.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [CloudBluePSAConnector.m line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L33)
* [Navigation tables and connection checks](../patterns/navigation.md): [CloudBluePSAConnector.m line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L68)
* [Resources and modular source loading](../patterns/packaging.md): [CloudBluePSAConnector.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L9)
* [Retries, delays, and polling](../patterns/retry-polling.md): [CloudBluePSAConnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L45)
* [Schema and type enforcement](../patterns/schema.md): [CloudBluePSAConnector.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L5)
