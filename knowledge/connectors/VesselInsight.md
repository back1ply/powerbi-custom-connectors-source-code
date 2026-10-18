---
type: Power Query Connector
title: Vessel Insight
description: Connect to Vessel Insight
tags: [errors, navigation, oauth, oauth2, packaging, pkce, schema]
publisher: Kognitwin
version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm
  title: Documentation.galoreCustomDataQueryType.pqm
- id: file-2
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm
  title: Documentation.galoreEdgeDataQueryType.pqm
- id: file-3
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyage.pqm
  title: Documentation.voyage.pqm
- id: file-4
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyageAis.pqm
  title: Documentation.voyageAis.pqm
- id: file-5
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyageHistory.pqm
  title: Documentation.voyageHistory.pqm
- id: file-6
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Table.createNavTableDataRow.pqm
  title: Table.createNavTableDataRow.pqm
- id: file-8
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm
  title: Util.convertNumericTimestampToDateTime.pqm
- id: file-9
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm
  title: VIAuth.pqm
- id: file-10
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm
  title: VIServices.pqm
- id: file-11
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m
  title: VesselInsight.m
- id: file-12
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm
  title: VoyageServices.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/VesselInsight/1.0.6/VesselInsight_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-10-18T09:38:15Z'
stale_after: '2026-11-01T09:38:15Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Kognitwin | 1.0.6 | OAuth |

# Source files

* [Documentation.galoreCustomDataQueryType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm)
* [Documentation.galoreEdgeDataQueryType.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm)
* [Documentation.voyage.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyage.pqm)
* [Documentation.voyageAis.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyageAis.pqm)
* [Documentation.voyageHistory.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Documentation.voyageHistory.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Table.ToNavigationTable.pqm)
* [Table.createNavTableDataRow.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Table.createNavTableDataRow.pqm)
* [Util.convertNumericTimestampToDateTime.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm)
* [VIAuth.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm)
* [VIServices.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm)
* [VesselInsight.m](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m)
* [VoyageServices.pqm](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm)

# Detected patterns

* [Navigation tables and connection checks](../patterns/navigation.md): [VesselInsight.m line 408](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L408)
* [OAuth2 login and token refresh](../patterns/oauth2.md): [VIAuth.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L13), [VesselInsight.m line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L432)
* [PKCE and URL-safe encoding](../patterns/pkce.md): [VIAuth.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L31)
* [Resources and modular source loading](../patterns/packaging.md): [VIAuth.pqm line 3](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L3), [VIServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm#L2), [VesselInsight.m line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L22), [VoyageServices.pqm line 2](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm#L2)
* [Schema and type enforcement](../patterns/schema.md): [Table.ToNavigationTable.pqm line 20](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/Table.ToNavigationTable.pqm#L20), [VesselInsight.m line 93](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L93), [VoyageServices.pqm line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm#L64)
* [Structured errors and HTTP status handling](../patterns/errors.md): [VIAuth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L56), [VIServices.pqm line 76](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIServices.pqm#L76), [VesselInsight.m line 135](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L135), [VoyageServices.pqm line 22](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VoyageServices.pqm#L22)
