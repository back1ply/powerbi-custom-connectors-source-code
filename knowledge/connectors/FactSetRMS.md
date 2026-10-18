---
type: Power Query Connector
title: FactSet RMS
description: Connect to FactSet RMS
tags: [navigation, packaging, schema, usernamepassword]
publisher: FactSet
version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m
  title: FactSetRMS.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/FactSetRMS/1.1.0/FactSetRMS_1.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| FactSet | 1.1.0 | UsernamePassword |

# Source files

* [FactSetRMS.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [FactSetRMS.m line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m#L9)
* [Resources and modular source loading](../patterns/packaging.md): [FactSetRMS.m line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m#L14)
* [Schema and type enforcement](../patterns/schema.md): [FactSetRMS.m line 224](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetRMS/FactSetRMS.m#L224)
