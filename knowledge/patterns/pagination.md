---
type: Power Query Pattern
title: Page generation and cursor traversal
description: Cursor and offset pagination through table metadata.
category: Data retrieval
tags: [data-retrieval]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: [\bTable\.GenerateByPage\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L107
  title: Attio/Attio.pq
---

**Draft: awaiting human review.**

# Mechanism

Attio selects paging settings by matching an endpoint suffix. Its cursor page function adds a cursor parameter only after an initial page, reads the next cursor from the response, and attaches it to the returned table as `NextCursor` metadata. A false `hasMore` value, a null cursor, or a blank text cursor becomes a null continuation marker.[^example]

The offset variant sends the configured offset and limit, converts the response items to a table, and calculates `NextOffset`. An empty page returns `null`; a shorter-than-page-size response marks the continuation as finished. The `Table.GenerateByPage` callbacks read those metadata fields to decide whether to request another page.[^example]

# Adaptation and failure paths

Treat the item extraction, continuation field, and stop condition as one endpoint-specific contract. Do not assume that an empty collection, an absent cursor, and an HTTP error mean the same thing. Check the longest-suffix selection when endpoints have overlapping route names; the configuration lookup is part of this implementation's paging behavior.[^example]

When adapting the offset branch, check whether the endpoint actually accepts its configured limit and offset parameters. The request-building code gates those parameters through `__sendsLimit`. A page helper's name alone does not establish which strategy an endpoint uses.[^example]

See [response metadata](response-metadata.md) and [retries and polling](retry-polling.md).

# Examples

The following excerpt is copied from `Attio/Attio.pq`, lines 107–118.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
                    if rowCount = 0 then null else asTable meta [NextOffset = nextOffset],
            result =
                if __style = "cursor" then Table.GenerateByPage((previous) => if previous = null then getPageCursor(null) else let nc = Value.Metadata(previous)[NextCursor] in if nc = null then null else getPageCursor(nc))
                else if __style = "offsetLimit" then Table.GenerateByPage((previous) => let off = if previous = null then 0 else Value.Metadata(previous)[NextOffset] in if off = null then null else getPageOffset(off))
                else
                    let
                        response = Json.Document(Web.Contents(url, [Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                        items    = if response is record then pickCollection(response)
                                   else if response is list then response
                                   else {},
                        r        = toTable(items)
                    in
```

[^example]: Attio/Attio.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **25** connectors in this archive.

* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 635](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L635)
* [Attio](../connectors/Attio.md): [Attio.pq line 109](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L109)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 299](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L299)
* [Azure Cost Management](../connectors/AzureCostManagement.md): [AzureCostManagement.pq line 2451](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureCostManagement/AzureCostManagement.pq#L2451)
* [Azure Resource Graph](../connectors/AzureResourceGraph.md): [AzureResourceGraph.pq line 53](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L53)
* [Solver](../connectors/BI360.md): [Solver.m line 71](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BI360/Solver.m#L71)
* [Bitbucket](../connectors/Bitbucket.md): [Bitbucket.pq line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bitbucket/Bitbucket.pq#L146)
* [Bitsight Security Ratings](../connectors/BitSightSecurityRatings.md): [BitSightSecurityRatings.pq line 1816](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BitSightSecurityRatings/BitSightSecurityRatings.pq#L1816)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 465](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L465)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 696](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L696)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [ParametricFilter.pqm line 786](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/ParametricFilter.pqm#L786), [SelectList.pqm line 471](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/SelectList.pqm#L471)
* [inwink](../connectors/inwink.md): [inwink.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/inwink.pq#L364)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 809](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L809)
* [MicrosoftAzureDataManagerForEnergy](../connectors/MicrosoftAzureDataManagerForEnergy.md): [MicrosoftAzureDataManagerForEnergy.pq line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftAzureDataManagerForEnergy/MicrosoftAzureDataManagerForEnergy.pq#L108)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L130)
* [qbconnector](../connectors/QuickBase.md): [qbconnector.m line 285](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/QuickBase/qbconnector.m#L285)
* [Siteimprove](../connectors/SiteImprove.md): [Siteimprove.pq line 770](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SiteImprove/Siteimprove.pq#L770)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 116](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L116)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 137](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L137)
* [SurveyMonkey](../connectors/SurveyMonkey.md): [FetchResource.pqm line 27](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SurveyMonkey/FetchResource.pqm#L27)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 185](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L185)
* [PQExtension1](../connectors/Witivio.md): [Witivio.pq line 204](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Witivio/Witivio.pq#L204)
* [Viva Insights](../connectors/WorkplaceAnalytics.md): [WorkplaceAnalytics.pq line 557](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/WorkplaceAnalytics/WorkplaceAnalytics.pq#L557)
* [Wrike](../connectors/Wrike.md): [wrike.m line 349](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L349)
* [ZendeskData](../connectors/ZendeskData.md): [zendesk.pq line 211](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L211)

<!-- seen-in:end -->
