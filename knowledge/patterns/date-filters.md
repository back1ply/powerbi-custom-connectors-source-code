---
type: Power Query Pattern
title: Date-range request filters
description: Optional date bounds, request serialization, and validation before paging.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-19T09:37:15.896791+00:00'
detect: [\bRangeStart\b]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L71
  title: InformationGrid/InformationGrid.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L32
  title: SolarwindsServiceDesk/SolarWindsServiceDesk.pq
- id: defaults
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L58
  title: SolarwindsServiceDesk/SolarWindsServiceDesk.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L47
  title: InformationGrid/InformationGrid.pq
- id: paging
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L115
  title: SolarwindsServiceDesk/SolarWindsServiceDesk.pq
- id: query
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/InformationGrid/InformationGrid.pq#L89
  title: InformationGrid/InformationGrid.pq
verified:
  by: codex/gpt-6
  at: '2026-10-19T10:10:51Z'
review:
  content_sha256: 51985b7dae1067dfa5bfdc8efce7acbae17e898984c0e70b2ec634c7885259a3
  sources_sha256:
    example: 57692c235ea7f33763489154d14c500f2a1a0885e77178b72cdcf4874e8f89a9
    variant: 370dc5d1abea6ed13ba0ee182c5b03038cc7a8add2896d3fff3937b3158d7f26
    defaults: 370dc5d1abea6ed13ba0ee182c5b03038cc7a8add2896d3fff3937b3158d7f26
    caller: 57692c235ea7f33763489154d14c500f2a1a0885e77178b72cdcf4874e8f89a9
    paging: 370dc5d1abea6ed13ba0ee182c5b03038cc7a8add2896d3fff3937b3158d7f26
    query: 57692c235ea7f33763489154d14c500f2a1a0885e77178b72cdcf4874e8f89a9
---

# Date-range request filters

## Select a boundary contract first

Use request-level date filters when a service accepts explicit time bounds and the connector needs to limit what it retrieves. Keep this separate from [pagination](pagination.md): a date window selects the logical data interval, while page state traverses the rows returned for that interval. The two examples below disagree on omitted bounds, so copying a signature alone is insufficient.[^example][^defaults]

A connector function accepting `RangeStart` and `RangeEnd` is not by itself proof of a correctly configured incremental-refresh policy. Microsoft's [incremental refresh configuration](https://learn.microsoft.com/en-us/power-bi/connect-data/incremental-refresh-configure) also describes model parameters, filtering, and policy configuration. This page studies request construction in the archive, not a tested service refresh deployment.

## InformationGrid: both bounds or an unbounded request

`InformationGridImpl` obtains a service list and chooses `GetIncrementalRefreshServiceData` for entries with non-empty parameter lists. That factory returns a function with two optional nullable `datetime` arguments. The returned function closes over the base URL, service name, and credential-bearing options record.[^caller][^example]

If either argument is null, the function builds a request without either range parameter. If both are supplied, it formats them as text and appends a literal `Z`, then supplies them to `BuildRequestUrl`. That helper merges the range record with `biClient` and `biClientVersion` and encodes the resulting query with `Uri.BuildQueryString`. The factory does not compare start and end or perform a timezone conversion before adding that suffix.[^example][^query]

## SolarWinds: reject invalid pairs, default missing values

`ContentsV110` and `ContentsV113` forward arguments to `NavigationV`. Its first guard rejects a supplied pair with `RangeStart >= RangeEnd`; the next uses `Duration.Days(RangeEnd - RangeStart) > 365*2`. Both require non-null arguments. The unversioned `Contents` instead calls the beta entry point, bypassing these guards. The implementation defaults a missing start to one month before local `DateTime.LocalNow()` and a missing end to that value, formats both using a resource string, and forwards them to paging.[^variant][^defaults]

| Input case | InformationGrid | SolarWinds |
| --- | --- | --- |
| Both null | Omits both bounds. | Uses a rolling default window. |
| One bound supplied | Omits both bounds. | Defaults the missing bound separately. |
| Equal or reversed supplied bounds | No local order check in the factory. | Raises the invalid-range error before navigation construction. |
| Both valid | Serializes both into query parameters. | Formats both, then hands them to paging. |

The table describes these functions' local decisions, not the servers' interpretation of timestamp boundaries.[^example][^variant][^defaults]

## Adaptation and failure checks

Choose and test null behavior explicitly. A partially supplied range should not silently become a full-history request unless that is your intended API contract. Decide which timezone the input represents before formatting it; appending `Z` does not add a conversion step to this source. Verify with the service whether the upper bound is inclusive or exclusive, and test adjacent windows for gaps and duplicates.[^example]

SolarWinds already passes its chosen bounds unchanged across pages. `GetQuery` sends them as `updated_custom_gte` and `updated_custom_lt`; confirm the service's interpretation of those names. Preserve that consistency when adapting paging. Inspect the localized date format before copying the defaults; the resource value is not retained here, so the final zone representation is unknown.[^paging][^defaults]

## Examples

### A factory that closes over request context

This complete InformationGrid factory shows both null handling and request construction. `BuildRequestUrl` and `GetServiceData` remain dependencies in the surrounding file.[^example]

<!-- source: example -->

```powerquery
GetIncrementalRefreshServiceData = (baseUrl as text, serviceName as text, options as record) as function =>
    (optional RangeStart as nullable datetime, optional RangeEnd as nullable datetime) as table =>
        let
            // Build URL with range parameters if provided
            url = if (RangeStart = null or RangeEnd = null) then
                    BuildRequestUrl(baseUrl, "retrieve/" & serviceName)
            else
            let
                // Convert datetime to ISO-8601 format
                rangeStartStr = DateTime.ToText(RangeStart, "yyyy-MM-ddTHH:mm:ss") & "Z",
                rangeEndStr = DateTime.ToText(RangeEnd, "yyyy-MM-ddTHH:mm:ss") & "Z"
            in
                BuildRequestUrl(baseUrl, "retrieve/" & serviceName, [RangeStart = rangeStartStr, RangeEnd = rangeEndStr]),

            result = GetServiceData(url, options)
        in
            result;
```

### Validate a supplied pair before building navigation

SolarWinds' complete navigation function gives the guard conditions a clear position before request dispatch.[^variant]

<!-- source: variant -->

```powerquery
SolarWindsServiceDesk.NavigationV = (version as text, optional RangeStart as datetime, optional RangeEnd as datetime, optional CustomFieldsStr as text) =>
    if (RangeStart <> null and RangeEnd <> null and RangeStart >= RangeEnd) then error Extension.LoadString("ErrorInvalidRange")
    else if (RangeStart <> null and RangeEnd <> null and Duration.Days(RangeEnd - RangeStart) > 365*2) then error Extension.LoadString("ErrorLimitRangeMessage") // 2 years limit
    else
    let
        objects =  #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {            
                { "Incidents", SolarWindsServiceDeskImpl(version, "incidents", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true }
        }),
        assets = #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {
            { "Hardwares", SolarWindsServiceDeskImpl(version, "hardwares", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true },
            { "Softwares", SolarWindsServiceDeskImpl(version, "softwares", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true },
            { "Mobiles", SolarWindsServiceDeskImpl(version, "mobiles", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true },
            { "Printers", SolarWindsServiceDeskImpl(version, "printers", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true },
            { "Network Devices", SolarWindsServiceDeskImpl(version, "discovery_hardwares", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true },
            { "Other Assets", SolarWindsServiceDeskImpl(version, "other_assets", RangeStart, RangeEnd, CustomFieldsStr), "Table", "Table", true }
        }),
        objectsFolder = Table.ToNavigationTable(objects, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),     
        assetsFolder = Table.ToNavigationTable(assets, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf"),
        source = #table({"Name", "Data", "ItemKind", "ItemName", "IsLeaf"}, {            
                { "All Objects", objectsFolder, "Folder", "Folder", false },
                { "Assets", assetsFolder, "Folder", "Folder", false }                            
            }),
        navTable = Table.ToNavigationTable(source, {"Name"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf")
    in
        navTable;
```

### Defaults belong to the consumer

This complete implementation shows what happens when only one bound is supplied, which the preceding guards do not reject.[^defaults]

<!-- source: defaults -->

```powerquery
SolarWindsServiceDeskImpl = (version as text, dataType as text, optional RangeStart as datetime, optional RangeEnd as datetime, optional CustomFieldsStr as text) as table =>
    let
        today = DateTime.LocalNow(),
        startDate = if RangeStart = null then DateTime.ToText(Date.AddMonths(today, -1), Extension.LoadString("DateFormat")) else DateTime.ToText(RangeStart, Extension.LoadString("DateFormat")),
        endDate = if RangeEnd = null then DateTime.ToText(today, Extension.LoadString("DateFormat")) else DateTime.ToText(RangeEnd, Extension.LoadString("DateFormat")),
        tracedStartDate = Diagnostics.Trace(TraceLevel.Information, GetTraceData(version, dataType, startDate, endDate), () =>  startDate, true),
        // make sure customFieldsNames is a list - empty or not - but not an option List
        customFieldsNames = if CustomFieldsStr <> null and CustomFieldsStr <> "" then List.Transform(Text.Split(CustomFieldsStr, ","), each Text.Trim(_)) else {},
        rows = GetAllPagesByNextLink(version, tracedStartDate, endDate, dataType, customFieldsNames)
    in
        rows;
```

See [web requests](web-requests.md) and [function parameters](parameter-metadata.md).

[^example]: InformationGrid optional date-bound factory and serialization.
[^variant]: SolarWinds pair validation and versioned navigation dispatch.
[^defaults]: SolarWinds per-bound defaults and paging handoff.
[^caller]: InformationGrid chooses the factory using service-list parameter presence.
[^query]: InformationGrid merges client metadata and encodes range query parameters.
[^paging]: SolarWinds preserves the bounds through its paging callback and constructs the date query fields.
