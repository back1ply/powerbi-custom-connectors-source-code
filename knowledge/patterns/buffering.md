---
type: Power Query Pattern
title: Buffering tables, lists, and binaries
description: Binary response snapshots and buffered configuration lists.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Table|List|Binary)\.Buffer\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L170
  title: Anaplan/Anaplan.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: 96dda9bfe9bafc330f5c8116c85cb7438563b629ce53395149d6762ec0093d6f
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Anaplan buffers a configuration HTTP response with `Binary.Buffer(response)` and later parses that buffered value with `Json.Document(buffered)`. Status handling reads metadata from the original response. The code therefore gives separate names to the body snapshot and the response used for status inspection.[^example]

Elsewhere in the same connector, `Anaplan.Connect` wraps its token, API URL, authentication URL, and trace-context values in `List.Buffer`. Its username/password branch resolves and validates authentication hosts before constructing that list; its OAuth branch reads an access token and supplies a different list of values.[^example]

# Adaptation and failure paths

Follow which consumers use a buffered binding before assuming it prevents repeated work throughout a query. A nearby unbuffered binding can still be used elsewhere, as the status read in this example shows. Buffering also does not replace the surrounding status branches: this function raises specific errors for unauthorized, server-error, and other non-200 responses.[^example]

Keep configuration evaluation separate from large result-table buffering when assessing a change. This page records uses of binary and list buffering in one connector; its detection list can also find table-buffer calls elsewhere. Measure the target workload before making a performance claim, and recheck error propagation when moving network expressions into buffered structures.

See [response metadata](response-metadata.md), [web requests](web-requests.md), and [diagnostics](diagnostics.md).

# Examples

The following excerpt is copied from `Anaplan/Anaplan.pq`, lines 170–181.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
                    else
                        responseTry[Value],
                buffered = Binary.Buffer(response),
                statusCode = Value.Metadata(response)[Response.Status],
                config =
                    if statusCode = 401 then
                        error Error.Record(
                            "Unauthorized",
                            "API returned 401 Unauthorized when calling " & dynamicConfigApiClientUrl & " with authUrl: " & authUrl,
                            null
                        )
                    else if statusCode >= 500 then
```

[^example]: Anaplan/Anaplan.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **29** connectors in this archive.

* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 172](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L172)
* [Bloomberg](../connectors/Bloomberg.md): [Folding.pqm line 216](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Folding.pqm#L216)
* [Celonis EMS](../connectors/Celonis.md): [Celonis.m line 64](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Celonis/Celonis.m#L64)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 1708](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1708)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L432)
* [Dremio](../connectors/Dremio.md): [DremioAdbcDataSource.pqm line 448](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Dremio/DremioAdbcDataSource.pqm#L448)
* [EQuIS](../connectors/EQuIS.md): [EQuIS.m line 97](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L97)
* [SQL database](../connectors/FabricSql.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L295)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [api-factset-analytics-request.pqm line 78](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L78)
* [FHIR](../connectors/Fhir.md): [Fhir.pq line 214](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Fhir/Fhir.pq#L214)
* [InterSystems Health Insight](../connectors/IntersystemsHealthInsight.md): [IntersystemsHealthInsight.pq line 440](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntersystemsHealthInsight/IntersystemsHealthInsight.pq#L440)
* [InterSystems IRIS](../connectors/IRIS.md): [Iris_PowerBI_Connector.m line 414](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IRIS/Iris_PowerBI_Connector.m#L414)
* [Lakehouse](../connectors/LakeHouse.md): [DeltaTableFastCopy.pqm line 58](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DeltaTableFastCopy.pqm#L58), [LakeHouse.pq line 96](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L96), [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L295)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 743](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L743)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 648](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L648)
* [OneLake Files](../connectors/OneLakeFile.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L295)
* [OneLakeSql](../connectors/OneLakeSql.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L295)
* [Paxata](../connectors/Paxata.md): [Paxata.m line 226](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Paxata/Paxata.m#L226)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L295)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L70)
* [SIS-CC SDMX](../connectors/SDMX.md): [SDMX.m line 55](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SDMX/SDMX.m#L55)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 98](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L98)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 334](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L334)
* [Tenforce (Smart)List](../connectors/Tenforce.md): [Tenforce.m line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Tenforce/Tenforce.m#L80)
* [Azure Time Series Insights](../connectors/TimeSeriesInsights.md): [TimeSeriesInsightsConnector.m line 500](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/TimeSeriesInsights/TimeSeriesInsightsConnector.m#L500)
* [Vena](../connectors/Vena.md): [Utils.pqm line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L108)
* [Warehouse](../connectors/Warehouse.md): [Utils.pqm line 295](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L295), [WarehouseOutputInterceptor.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L69)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L278)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 62](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L62)

<!-- seen-in:end -->
