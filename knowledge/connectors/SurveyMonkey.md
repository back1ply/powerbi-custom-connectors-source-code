---
type: Power Query Connector
title: SurveyMonkey
description: Connect to SurveyMonkey
tags: [credentials, diagnostics, errors, key, navigation, packaging, pagination, response-metadata, schema]
publisher: SurveyMonkey
version: 1.1.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/Diagnostics.pqm
  title: Diagnostics.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm
  title: FetchResource.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m
  title: SurveyMonkey.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/SurveyMonkey/1.1.0/SurveyMonkey_1.1.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| SurveyMonkey | 1.1.0 | Key |

# Source files

* [Diagnostics.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/Diagnostics.pqm)
* [FetchResource.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm)
* [SurveyMonkey.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [SurveyMonkey.m line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L66)
* [Diagnostic tracing](../patterns/diagnostics.md): [Diagnostics.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/Diagnostics.pqm#L2)
* [Navigation tables and connection checks](../patterns/navigation.md): [SurveyMonkey.m line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L78)
* [Page generation and cursor traversal](../patterns/pagination.md): [FetchResource.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm#L27)
* [Resources and modular source loading](../patterns/packaging.md): [SurveyMonkey.m line 142](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L142)
* [Response and pagination metadata](../patterns/response-metadata.md): [FetchResource.pqm line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm#L30), [SurveyMonkey.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L32)
* [Schema and type enforcement](../patterns/schema.md): [FetchResource.pqm line 21](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm#L21), [SurveyMonkey.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L13)
* [Structured errors and HTTP status handling](../patterns/errors.md): [SurveyMonkey.m line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/SurveyMonkey.m#L30)
