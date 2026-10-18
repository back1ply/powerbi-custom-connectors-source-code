---
type: Power Query Pattern
title: PKCE and URL-safe encoding
description: PKCE verifier transport, SHA-256, and URL-safe encoding.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [code_challenge\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L225
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: 5ec43407e8c16de1502663f3aa0d2f785cc70450739eb1411c55ed058fcd1175
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

Asana creates a verifier in `StartLogin`, sends `GenerateCodeChallenge(code_verifier)` with `code_challenge_method = "S256"`, and returns the original verifier in the login result's `Context` record. `FinishLogin` passes that context into `TokenMethod`, which adds the verifier to the token form when the field exists. The context is therefore the link between authorization and token exchange in this implementation.[^example]

The challenge helper hashes the verifier's ASCII bytes with SHA-256, converts the hash to Base64 text, replaces `+` and `/` with URL-safe characters, and removes `=` padding. The encoding steps are visible below; the surrounding file contains the authorization request and token form.[^example]

# Adaptation and failure paths

Preserve the original verifier across the callback. Sending the challenge again in place of the verifier would change the data this implementation puts in its token request. Review verifier generation separately from hashing: this connector's generator uses `Number.RandomBetween`, and the presence of SHA-256 does not itself assess that generator.[^example]

Follow the missing-context branch in `TokenMethod` as well. It omits the verifier field instead of generating a new verifier. When debugging a rejected exchange, compare the retained context, algorithm label, and exact bytes used to compute the challenge before changing unrelated credential code.[^example]

See [OAuth2 callbacks](oauth2.md) and [HMAC signing](hmac.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 225–241.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
GenerateCodeChallenge = (code_verifier) =>
    let
        hash = Replace(HashString(code_verifier))
    in
        hash;

HashString = (str as text) =>
    let
        result = Binary.ToText(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(str, TextEncoding.Ascii)), BinaryEncoding.Base64)
    in
        result;

Replace = (str) =>
    let
        result = Text.Replace(Text.Replace(Text.Replace(str, "+", "-"), "/", "_"), "=", "")
    in
        result;
```

[^example]: Asana/Asana.m; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **26** connectors in this archive.

* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 68](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L68)
* [Asana](../connectors/Asana.md): [Asana.m line 117](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L117)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 65](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L65)
* [Bloomberg](../connectors/Bloomberg.md): [Auth.pqm line 91](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L91)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 39](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L39)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [OAuth.pqm line 37](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm#L37)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 104](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L104)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 1162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L1162)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 195](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L195)
* [Dynatrace_Grail_DQL](../connectors/DynatraceGrail.md): [DynatraceGrail.m line 385](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L385)
* [eWay-CRM](../connectors/eWayCRM.md): [eWay_CRM.m line 378](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L378)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [OAuth.pqm line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L38)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [util-oauth.pqm line 69](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L69)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 270](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L270)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 1169](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L1169)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L138)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [AuthHelpers.pqm line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L75)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 175](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L175)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 176](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L176)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L192)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 862](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L862)
* [Planview OKR](../connectors/PlanviewOKR.md): [PlanviewOKR.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L85)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 518](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L518)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 184](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L184)
* [Vessel Insight](../connectors/VesselInsight.md): [VIAuth.pqm line 31](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L31)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L83)

<!-- seen-in:end -->
