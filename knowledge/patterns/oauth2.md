---
type: Power Query Pattern
title: OAuth2 login and token refresh
description: OAuth2 callbacks and refresh-token exchange.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:StartLogin|FinishLogin|Refresh)\s*=']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L48
  title: GoogleSheets/GoogleSheets.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:00:47Z'
review:
  content_sha256: b87f53c94f8697ed186133148a8330faeea5413e181f648c68651f1d5109ca0e
  sources_sha256:
    example: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
---

**Review scope:** static source review; vendor connector runtime behavior is not tested.

# Mechanism

GoogleSheets registers `StartLogin`, `FinishLogin`, and `Refresh` in its OAuth authentication record. `StartLogin` builds an authorization URL containing `state`, the callback URL, and a read-only spreadsheet scope, and requests offline access and consent. `FinishLogin` extracts the callback query and exchanges its authorization code for a JSON token response.[^example]

`Refresh` is a separate token-endpoint request. It sends `grant_type = "refresh_token"`, the supplied refresh token, the client identifier, and the client secret, then returns the parsed response. The secret in this archive is redacted, so the excerpt is a source-reading example rather than a working registration for a new application.[^example]

# Adaptation and failure paths

Keep the registered callbacks, authorization parameters, token form, and expected token fields consistent when adapting a flow. Check the provider's response contract before adding expiry calculations or replacing refresh-token fields. This implementation returns the parsed token response; it does not demonstrate a general policy for token expiry formats.[^example]

The callback's explicit error branch raises `DataSource.Error` when its `error` query field is present. Read that branch together with the token request; a successful browser redirect is not by itself evidence of a successful token exchange. Review callback-state handling and provider requirements separately before adopting the flow.[^example]

See [PKCE](pkce.md) for verifier transport and [credential access](credentials.md) for consumption of saved credentials.

# Examples

The following excerpt is copied from `GoogleSheets/GoogleSheets.pq`, lines 48–63.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
Refresh = (resourceUrl, refresh_token) =>
    let
        Response = Web.Contents("https://oauth2.googleapis.com/token", [
            Content = Text.ToBinary(Uri.BuildQueryString([
                grant_type = "refresh_token",
                client_id = ClientId,
                client_secret = ClientSecret,
                refresh_token = refresh_token
                ])),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"]]),
        Parts = Json.Document(Response)
    in
        Parts;

```

[^example]: GoogleSheets/GoogleSheets.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **47** connectors in this archive.

* [ADPAnalytics](../connectors/ADPAnalytics.md): [ADPAnalytics.m line 238](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ADPAnalytics/ADPAnalytics.m#L238)
* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L54)
* [Asana](../connectors/Asana.md): [Asana.m line 85](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L85)
* [Assemble Views](../connectors/AssembleViews.md): [AssembleViews.m line 793](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AssembleViews/AssembleViews.m#L793)
* [Autodesk Construction Cloud](../connectors/AutodeskConstructionCloud.md): [AutodeskConstructionCloud.pq line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AutodeskConstructionCloud/AutodeskConstructionCloud.pq#L47)
* [Bloomberg](../connectors/Bloomberg.md): [Auth.pqm line 83](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Auth.pqm#L83), [Bloomberg.m line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Bloomberg/Bloomberg.m#L38)
* [BQE CORE](../connectors/BQECore.md): [BQECore.pq line 2535](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BQECore/BQECore.pq#L2535)
* [BuildingConnected & TradeTapp](../connectors/BuildingConnected.md): [BuildingConnected.pq line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/BuildingConnected/BuildingConnected.pq#L18)
* [CData Connect Cloud](../connectors/CDataConnectCloud.md): [CDataConnectCloud.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloud.pq#L9), [CDataConnectCloudService.pqm line 411](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudService.pqm#L411), [CDataConnectCloudServiceV2.pqm line 499](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/CDataConnectCloudServiceV2.pqm#L499), [OAuth.pqm line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CDataConnectCloud/OAuth.pqm#L19)
* [Cherwell](../connectors/Cherwell.md): [Cherwell.m line 15](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Cherwell/Cherwell.m#L15)
* [Cognite Data Fusion (REST API)](../connectors/CogniteDataSource.md): [CogniteDataSource.pq line 84](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L84)
* [Azure Databricks](../connectors/Databricks.md): [Databricks.pq line 952](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Databricks/Databricks.pq#L952)
* [Delta Sharing](../connectors/DeltaSharing.md): [DeltaSharing.pq line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L25)
* [Dynatrace_Grail_DQL](../connectors/DynatraceGrail.md): [DynatraceGrail.m line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DynatraceGrail/DynatraceGrail.m#L350)
* [Eduframe](../connectors/Eduframe.md): [EduFrame.pq line 253](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Eduframe/EduFrame.pq#L253)
* [Entersoft Business Suite](../connectors/EntersoftBusinessSuite.md): [Entersoft_Business_Suite.m line 278](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EntersoftBusinessSuite/Entersoft_Business_Suite.m#L278)
* [eWay-CRM](../connectors/eWayCRM.md): [eWay_CRM.m line 370](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/eWayCRM/eWay_CRM.m#L370)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [ExactOnlinePremium.m line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L122), [OAuth.pqm line 29](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/OAuth.pqm#L29)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [util-oauth.pqm line 56](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/util-oauth.pqm#L56)
* [Palantir Foundry Datasets](../connectors/Foundry.md): [Foundry.m line 259](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Foundry/Foundry.m#L259)
* [Funnel](../connectors/Funnel.md): [Funnel.pq line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/Funnel.pq#L13), [OAuth.pqm line 16](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Funnel/OAuth.pqm#L16)
* [Google Sheets](../connectors/GoogleSheets.md): [GoogleSheets.pq line 9](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L9)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 146](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L146), [OAuth.pqm line 18](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/OAuth.pqm#L18)
* [IndustrialConnector](../connectors/IndustrialAppStore.md): [IndustrialAppStore.pq line 290](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/IndustrialAppStore/IndustrialAppStore.pq#L290)
* [inwink](../connectors/inwink.md): [auth.startlogin.pqm line 25](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/inwink/auth.startlogin.pqm#L25)
* [Kognitwin](../connectors/Kognitwin.md): [Kognitwin.pq line 114](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Kognitwin/Kognitwin.pq#L114)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [AuthHelpers.pqm line 47](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/AuthHelpers.pqm#L47), [kxkdbinsightsenterprise.pq line 568](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L568)
* [Kyvos ODBC](../connectors/KyvosODBC.md): [KyvosODBC.pq line 138](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/KyvosODBC/KyvosODBC.pq#L138)
* [LEAP](../connectors/LEAP.md): [LEAP.m line 75](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LEAP/LEAP.m#L75)
* [Microsoft Graph Security](../connectors/MicrosoftGraphSecurity.md): [MicrosoftGraphSecurity.m line 130](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrosoftGraphSecurity/MicrosoftGraphSecurity.m#L130)
* [MicrostrategyDataset](../connectors/MicrostrategyDataset.md): [MicroStrategyDataset.m line 36](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/MicrostrategyDataset/MicroStrategyDataset.m#L36)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 837](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L837)
* [Planview OKR](../connectors/PlanviewOKR.md): [PlanviewOKR.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewOKR/PlanviewOKR.m#L13)
* [Planview ProjectPlace](../connectors/PlanviewProjectplace.md): [PlanviewProjectplace.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PlanviewProjectplace/PlanviewProjectplace.m#L13)
* [ProductInsightsConnector](../connectors/ProductInsights.md): [ProductInsightsConnector.m line 506](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L506)
* [Profisee](../connectors/Profisee.md): [Profisee.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Profisee/Profisee.m#L182)
* [SmartsheetGlobal](../connectors/SmartsheetGlobal.md): [SmartsheetGlobal.pq line 19](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SmartsheetGlobal/SmartsheetGlobal.pq#L19)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 219](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L219)
* [Planview IdeaPlace](../connectors/Spigit.md): [Spigit.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Spigit/Spigit.m#L13)
* [StarburstPresto](../connectors/StarburstPresto.md): [StarburstEnterprise.pq line 38](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/StarburstPresto/StarburstEnterprise.pq#L38)
* [SumTotal](../connectors/SumTotal.md): [SumTotal.pq line 183](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SumTotal/SumTotal.pq#L183)
* [Supermetrics](../connectors/Supermetrics.md): [Supermetrics.m line 209](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Supermetrics/Supermetrics.m#L209)
* [Vessel Insight](../connectors/VesselInsight.md): [VIAuth.pqm line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VIAuth.pqm#L13), [VesselInsight.m line 432](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/VesselInsight/VesselInsight.m#L432)
* [Windsor](../connectors/Windsor.md): [Windsor.pq line 17](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Windsor/Windsor.pq#L17)
* [Wrike](../connectors/Wrike.md): [wrike.m line 328](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L328)
* [ZendeskData](../connectors/ZendeskData.md): [zendesk.pq line 249](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZendeskData/zendesk.pq#L249)
* [Zoho Creator](../connectors/ZohoCreator.md): [ZohoCreator.m line 134](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ZohoCreator/ZohoCreator.m#L134)

<!-- seen-in:end -->
