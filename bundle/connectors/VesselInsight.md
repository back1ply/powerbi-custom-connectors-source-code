---
type: Power Query Connector
title: Vessel Insight
description: Connect to Vessel Insight
tags: [oauth]
x-pqkb-publisher: Kognitwin
x-pqkb-version: 1.0.6
sources:
- id: file-1
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm
  title: Documentation.galoreCustomDataQueryType.pqm
- id: file-2
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm
  title: Documentation.galoreEdgeDataQueryType.pqm
- id: file-3
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm
  title: Documentation.voyage.pqm
- id: file-4
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm
  title: Documentation.voyageAis.pqm
- id: file-5
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm
  title: Documentation.voyageHistory.pqm
- id: file-6
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm
  title: Table.ToNavigationTable.pqm
- id: file-7
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.createNavTableDataRow.pqm
  title: Table.createNavTableDataRow.pqm
- id: file-8
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm
  title: Util.convertNumericTimestampToDateTime.pqm
- id: file-9
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm
  title: VIAuth.pqm
- id: file-10
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm
  title: VIServices.pqm
- id: file-11
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m
  title: VesselInsight.m
- id: file-12
  resource: https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm
  title: VoyageServices.pqm
resource: https://content.prod.powerquery.microsoft.com/api/certifiedExtensions/VesselInsight/1.0.6/VesselInsight_1.0.6.pqx
generated:
  by: process:pqkb-build
  at: '2026-11-27T12:12:40Z'
verified:
  by: process:pqkb-refresh
  at: '2026-11-25T17:23:17Z'
stale_after: '2026-12-09T17:23:17Z'
---

| Publisher | Version | Authentication |
| --- | --- | --- |
| Kognitwin | 1.0.6 | OAuth |

# Source files

* [Documentation.galoreCustomDataQueryType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm)
* [Documentation.galoreEdgeDataQueryType.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreEdgeDataQueryType.pqm)
* [Documentation.voyage.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyage.pqm)
* [Documentation.voyageAis.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageAis.pqm)
* [Documentation.voyageHistory.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.voyageHistory.pqm)
* [Table.ToNavigationTable.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm)
* [Table.createNavTableDataRow.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.createNavTableDataRow.pqm)
* [Util.convertNumericTimestampToDateTime.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Util.convertNumericTimestampToDateTime.pqm)
* [VIAuth.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm)
* [VIServices.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm)
* [VesselInsight.m](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m)
* [VoyageServices.pqm](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VoyageServices.pqm)

# Certification checklist

Microsoft's published certification rules, checked by reading this version's source ([archived rules](https://web.archive.org/web/20240809185021/https://learn.microsoft.com/en-us/power-query/connector-certification)). Review means the code needs judgement; this is not Microsoft's review.

| Rule | Level | Status | Details |
| --- | --- | --- | --- |
| Use section document format. | MUST | Pass | Section document. [VesselInsight.m line 2](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L2) |
| Contain a version header above the section document. | MUST | Pass | Version header present. [VesselInsight.m line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L1) |
| Provide function documentation metadata. | MUST | Pass | Documentation metadata present. [Documentation.galoreCustomDataQueryType.pqm line 3](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Documentation.galoreCustomDataQueryType.pqm#L3) |
| Have a TestConnection handler. | MUST | Pass | TestConnection defined for VesselInsight. [VesselInsight.m line 425](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L425) |
| Name shared functions DataSourceKind.FunctionName, without 'Power BI', 'Connector', or 'API'. | MUST | Pass | Shared functions: VesselInsight.Contents. [VesselInsight.m line 4](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L4) |
| Set the Beta flag to true on the initial release. | MUST | Info | Beta = false in this version. [VesselInsight.m line 444](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L444) |
| Have icons. | SHOULD | Pass | Publish record sets icons. [VesselInsight.m line 448](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VesselInsight.m#L448) |
| Provide a navigation table. | SHOULD | Pass | Builds a navigation table. [Table.ToNavigationTable.pqm line 14](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/Table.ToNavigationTable.pqm#L14) |
| Place UI strings in resources.resx. | SHOULD | Pass | Uses Extension.LoadString. [VIAuth.pqm line 77](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIAuth.pqm#L77) |
| Send credentials only over HTTPS. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Pass credentials in a GET query only through CredentialQueryString. | SECURITY | N/A | No Extension.CurrentCredential use. |
| Gate tracing behind a flag that is off at submission. | SECURITY | N/A | No Diagnostics tracing. |
| Never evaluate user-provided or fetched expressions. | SECURITY | Pass | Only the module loader evaluates packaged files. [VIServices.pqm line 1](https://github.com/back1ply/power-bi-custom-connectors-source-code/blob/main/connectors/VesselInsight/VIServices.pqm#L1) |
