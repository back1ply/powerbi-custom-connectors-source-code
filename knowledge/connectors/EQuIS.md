---
type: Power Query Connector
title: EQuIS
description: Power BI connector source for EQuIS.
tags: [aad, buffering, credentials, errors, key, navigation, packaging, schema, usernamepassword]
publisher: EarthSoft
version: 7.23.10067
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m
  title: EQuIS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/EQuIS/7.23.10067/EQuIS_7.23.10067.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| EarthSoft | 7.23.10067 | Aad, Key, UsernamePassword |

# Source files

* [EQuIS.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m)

# Detected patterns

* [Buffering tables, lists, and binaries](../patterns/buffering.md): [EQuIS.m line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L97)
* [Credential access](../patterns/credentials.md): [EQuIS.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L64)
* [Navigation tables and connection checks](../patterns/navigation.md): [EQuIS.m line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L34)
* [Resources and modular source loading](../patterns/packaging.md): [EQuIS.m line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L20)
* [Schema and type enforcement](../patterns/schema.md): [EQuIS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L14)
* [Structured errors and HTTP status handling](../patterns/errors.md): [EQuIS.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L85)
