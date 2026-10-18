---
type: Power Query Connector
title: Usercube
description: Connect to Usercube
tags: [credentials, errors, navigation, packaging, pagination, response-metadata, schema, table-view, usernamepassword, web-requests]
publisher: Usercube
version: 1.0.0
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm
  title: Table.ChangeType.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.GenerateByPage.pqm
  title: Table.GenerateByPage.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m
  title: Usercube.m
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/Usercube/1.0.0/Usercube_1.0.0.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Usercube | 1.0.0 | UsernamePassword |

# Source files

* [Table.ChangeType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm)
* [Table.GenerateByPage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.GenerateByPage.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ToNavigationTable.pqm)
* [Usercube.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m)

# Detected patterns

* [Credential access](../patterns/credentials.md): [Usercube.m line 241](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L241)
* [Navigation tables and connection checks](../patterns/navigation.md): [Usercube.m line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L28)
* [Page generation and cursor traversal](../patterns/pagination.md): [Usercube.m line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L185)
* [Resources and modular source loading](../patterns/packaging.md): [Usercube.m line 44](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L44)
* [Response and pagination metadata](../patterns/response-metadata.md): [Table.ChangeType.pqm line 12](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm#L12), [Usercube.m line 181](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L181)
* [Schema and type enforcement](../patterns/schema.md): [Table.ChangeType.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm#L58), [Table.GenerateByPage.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.GenerateByPage.pqm#L20), [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ToNavigationTable.pqm#L20), [Usercube.m line 5](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L5)
* [Structured errors and HTTP status handling](../patterns/errors.md): [Table.ChangeType.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Table.ChangeType.pqm#L27), [Usercube.m line 213](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L213)
* [Table.View handlers](../patterns/table-view.md): [Usercube.m line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L111)
* [Web requests and relative paths](../patterns/web-requests.md): [Usercube.m line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L199)
