---
type: Power Query Pattern
title: Retries, delays, and polling
description: Retry producers, page delays, and exhaustion behavior.
category: Data retrieval
tags: [data-retrieval]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: ['\b(?:Value\.WaitFor|Function\.InvokeAfter)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L85
  title: AzureResourceGraph/AzureResourceGraph.pq
---

**Draft: awaiting human review.**

# Mechanism

AzureResourceGraph uses two distinct delays. Page traversal applies a random one-to-three-second delay before `GetPage`. Inside a request, `WaitForResult` uses `Value.WaitFor` with an exponential interval, manually handles HTTP 500 and 400, and sets `IsRetry` when the iteration is greater than zero. A retryable 500 produces `null`; a handled 400 produces an error record for its caller.[^example]

`Value.WaitFor` is defined in the connector itself with `List.Generate`. Its state contains an iteration and a result, and it stops when a non-null result has been produced or the configured count is reached. Read that definition rather than treating the helper name as a built-in guarantee.[^example]

# Adaptation and failure paths

Derive the attempt budget from both the producer and the helper's count condition. This source passes a count of three while its producer also tests `iteration < 3`; the branch threshold alone is not an attempt-count specification. Review what happens when repeated null results exhaust the helper: `List.Last` can return null, while the caller expects a record with `IsError` and `Content`.[^example]

When adapting the code, give exhaustion an explicit outcome before accessing result fields. Keep throttling between successful pages separate from retry handling for a failed request. The shown `WaitForResult` interval does not parse `Retry-After`; do not infer header-aware behavior from the presence of a delay.[^example]

See [response metadata](response-metadata.md) and [structured errors](errors.md).

# Examples

The following excerpt is copied from `AzureResourceGraph/AzureResourceGraph.pq`, lines 85–118.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
WaitForResult = (postData as binary) => 
    let
        apiUrl = Uri.Combine(GetEndpointConfig()[AzureResourceManager], "/providers/Microsoft.ResourceGraph/resources?api-version=2021-03-01"),
        waitForResult = Value.WaitFor(
            (iteration) =>
                let
                    result = Web.Contents(apiUrl, 
                        [Headers = [#"Content-Type" = "application/json", #"X-Ms-Command-Name" = "ARGPBI"],
                        Content = postData,
                        ManualStatusHandling = {500, 400},
                        IsRetry = iteration > 0]),
                    status = Value.Metadata(result)[Response.Status],
                    body = Json.Document(result),
                    statusCode = Value.Metadata(result)[Response.Status],
                    errorMessage = if statusCode <> 200 then body[error][message] else "",
                    details = if statusCode <> 200 then Record.Field(body[error], "details") else {},
                    detailedErrorMessage = if statusCode <> 200 and List.IsEmpty(details) then "" else if List.IsEmpty(details) <> true then List.Accumulate(details, "", (state, current) => state & " " & current[message]) else "",
                    errorCheck = if statusCode <> 200 then errorMessage & " Details:" & detailedErrorMessage else null,
                    actualResult = if status = 500 then if iteration < 3 then null else [IsError = true, Content = errorCheck] else if status = 400 then [IsError = true, Content = errorCheck] else [IsError = false, Content = body]
                in
                    actualResult,
            (iteration) => #duration(0, 0, 0, Number.Power(2, iteration)), 3)
    in
        waitForResult;

Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} < count),
            (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1})
    in
        List.Last(list);
```

[^example]: AzureResourceGraph/AzureResourceGraph.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **33** connectors in this archive.

* [Acterys : Model Automation & Planning](../connectors/Acterys.md): [Acterys.pq line 67](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Acterys/Acterys.pq#L67)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 637](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L637)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 348](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L348)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 186](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L186)
* [Azure Device Registry (ADR)](../connectors/AzureDeviceRegistry.md): [AzureDeviceRegistry.pq line 155](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureDeviceRegistry/AzureDeviceRegistry.pq#L155)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 59](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L59)
* [Bloomberg](../connectors/Bloomberg.md): [Data-Handler.pqm line 70](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Data-Handler.pqm#L70), [Utils.pqm line 111](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Utils.pqm#L111)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 527](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L527)
* [CloudBluePSA](../connectors/CloudBluePSA.md): [CloudBluePSAConnector.m line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CloudBluePSA/CloudBluePSAConnector.m#L45)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 715](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L715)
* [Dynamics 365 Customer Insights](../connectors/CustomerInsights.md): [CustomerInsights.m line 359](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CustomerInsights/CustomerInsights.m#L359)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 335](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L335)
* [Eduframe](../connectors/Eduframe.md): [Requests.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/Requests.pqm#L9)
* [SQL database](../connectors/FabricSql.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FabricSql/Utils.pqm#L231)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [api-factset-analytics-request.pqm line 74](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-request.pqm#L74), [api-factset-analytics-util.pqm line 14](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/api-factset-analytics-util.pqm#L14), [request-long-running.pqm line 11](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L11), [util-throttled-function-iterator.pqm line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-throttled-function-iterator.pqm#L9)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 190](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L190)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [CommonHelpers.pqm line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/CommonHelpers.pqm#L104), [kxkdbinsightsenterprise.pq line 321](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L321)
* [Lakehouse](../connectors/LakeHouse.md): [DeltaTableFastCopy.pqm line 66](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DeltaTableFastCopy.pqm#L66), [MDSync.pqm line 596](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L596), [SparkComputeUtils.pqm line 161](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkComputeUtils.pqm#L161), [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/Utils.pqm#L231)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 725](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L725)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 1473](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L1473)
* [OneLake Files](../connectors/OneLakeFile.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeFile/Utils.pqm#L231)
* [OneLakeSql](../connectors/OneLakeSql.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneLakeSql/Utils.pqm#L231)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 768](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L768)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/Utils.pqm#L231)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 57](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L57)
* [Samsara](../connectors/Samsara.md): [Samsara.Client.Depage.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Depage.pqm#L38), [Samsara.Client.Retry.pqm line 49](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Samsara/Samsara.Client.Retry.pqm#L49)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 221](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L221)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 282](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L282)
* [Vena](../connectors/Vena.md): [Utils.pqm line 178](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Utils.pqm#L178)
* [Warehouse](../connectors/Warehouse.md): [Utils.pqm line 231](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/Utils.pqm#L231)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 416](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L416)
* [Wrike](../connectors/Wrike.md): [wrike.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L108)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 43](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L43)

<!-- seen-in:end -->
