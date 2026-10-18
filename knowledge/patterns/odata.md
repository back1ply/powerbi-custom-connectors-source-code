---
type: Power Query Pattern
title: OData feeds
description: Credential headers and explicit OData feed options.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bOData\.Feed\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L37
  title: AptixInsights/AptixInsights.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: a660004aec1d0af492c950c018762ee57450e1c964e619c38658f39a99a35b1b
  sources_sha256:
    example: 6a7c94fb9ba68a34571e7d750093b679be8070224209a7a323728194b1b3bb75
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

AptixInsights reads the current credential's `Key`, constructs an `Authorization = "Bearer " & token` header, and passes it to `OData.Feed`. The call also receives a service-options record containing `Implementation = "2.0"`, `MoreColumns = true`, `ODataVersion = 4`, and the supplied query value, with an empty record used when the query argument is null.[^example]

The implementation calls `ValidateUrlScheme` before invoking the feed. Its connector record declares key authentication and builds `TestConnection` arguments from the serialized data-source path. The feed invocation is therefore one part of a connector-specific URL and credential contract.[^example]

# Adaptation and failure paths

Trace the URL parameter, optional query, headers, and connection-test argument reconstruction together. Copying only `OData.Feed(url)` would omit the options and bearer-header construction shown here. Confirm each option against the service and SDK version being targeted; the values in this source are observed configuration, not recommendations for every OData endpoint.[^example]

Read `ValidateUrlScheme` and the engine's returned errors before adding a catch-all fallback. The visible feed function does not include a custom HTTP retry loop or a manual pagination callback. Do not infer either behavior from the generic retry and pagination patterns elsewhere in this bundle.[^example]

See [credential access](credentials.md) and [connection checks](navigation.md).

# Examples

The following excerpt is copied from `AptixInsights/AptixInsights.pq`, lines 37–52.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
AptixInsightsImpl = (url as text, optional query as any) =>
    let
        credential = Extension.CurrentCredential(),
        token = credential[Key],
        headers = [Authorization = "Bearer " & token],
        serviceOptions = [
            Implementation = "2.0",
            MoreColumns = true,
            ODataVersion = 4,
            Query = if query = null then [] else query
        ],
        //add the query string record option
        url = ValidateUrlScheme(url),
        source = OData.Feed(url, headers, serviceOptions)
    in
        source;
```

[^example]: AptixInsights/AptixInsights.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **13** connectors in this archive.

* [Topcon Aptix Insights](../connectors/AptixInsights.md): [AptixInsights.pq line 50](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AptixInsights/AptixInsights.pq#L50)
* [Cognite Data Fusion (OData)](../connectors/Cognite.md): [Cognite.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cognite/Cognite.pq#L147)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 544](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L544)
* [Digital Construction Works Insights](../connectors/DCWInsights.md): [DCWInsights.m line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DCWInsights/DCWInsights.m#L31)
* [Emigo Data Source](../connectors/Emigo.md): [Emigo.m line 234](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Emigo/Emigo.m#L234)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 108](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L108), [UoM.pqm line 33](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L33)
* [Intune Data Warehouse](../connectors/IntuneDataWarehouse.md): [Intune.m line 32](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneDataWarehouse/Intune.m#L32)
* [Intune Data Warehouse](../connectors/IntuneV2.md): [IntuneV2.pq line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IntuneV2/IntuneV2.pq#L56)
* [Microsoft Graph Security](../connectors/MicrosoftGraphSecurity.md): [MicrosoftGraphSecurity.m line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L112)
* [Planview OKR](../connectors/PlanviewOKR.md): [PlanviewOKR.m line 173](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L173)
* [Planview ProjectPlace](../connectors/PlanviewProjectplace.md): [PlanviewProjectplace.m line 133](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L133)
* [Planview IdeaPlace](../connectors/Spigit.md): [Spigit.m line 132](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L132)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L65)

<!-- seen-in:end -->
