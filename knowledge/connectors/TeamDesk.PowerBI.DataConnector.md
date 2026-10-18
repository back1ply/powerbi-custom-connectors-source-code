---
type: Power Query Connector
title: TeamDesk.PowerBI.DataConnector
description: Power BI connector source for TeamDesk.PowerBI.DataConnector.
tags: [credentials, errors, key, navigation, packaging, response-metadata, schema, usernamepassword]
publisher: ForeSoft
version: 1.0.1
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m
  title: TeamDesk.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/TeamDesk/1.0.1/TeamDesk_1.0.1.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| ForeSoft | 1.0.1 | Key, UsernamePassword |

# Source files

* [TeamDesk.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [TeamDesk.m line 266](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L266)
* [Navigation tables and connection checks](../patterns/navigation.md): [TeamDesk.m line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L12)
* [Resources and modular source loading](../patterns/packaging.md): [TeamDesk.m line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L11)
* [Response and pagination metadata](../patterns/response-metadata.md): [TeamDesk.m line 272](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L272)
* [Schema and type enforcement](../patterns/schema.md): [TeamDesk.m line 40](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L40)
* [Structured errors and HTTP status handling](../patterns/errors.md): [TeamDesk.m line 256](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TeamDesk.PowerBI.DataConnector/TeamDesk.m#L256)
