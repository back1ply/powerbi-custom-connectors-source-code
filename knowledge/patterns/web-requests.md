---
type: Power Query Pattern
title: Web requests and relative paths
description: Web request options and explicit HTTP response branches.
category: Data retrieval
tags: [data-retrieval]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: [\bRelativePath\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L665
  title: Anaplan/Anaplan.pq
---

**Draft: awaiting human review.**

# Mechanism

Anaplan's `GetApiToken` creates a request to `authUrl` with a relative authentication path loaded from a resource string. It supplies a binary body, headers, a query record, and `ManualStatusHandling = {401}` in the same `Web.Contents` options record. The source chooses a different header record when `isRefresh` is true.[^example]

The function reads `Response.Status` from the response metadata. Status 201 extracts `tokenInfo` from the parsed JSON, status 401 raises `Extension.CredentialError`, and other statuses return null. The outer `try getToken() otherwise null` also converts errors from the inner function into null.[^example]

# Adaptation and failure paths

Review the complete request before reusing individual options. The source contains a literal `Query` authorization string; that string is not a recipe for transporting arbitrary application credentials. Confirm the target API's required headers, body, and authentication mechanism before substituting values.[^example]

Follow the caller's treatment of null as carefully as the successful token extraction. Here an inner credential error can be hidden by the outer `otherwise` expression. When designing a new connector, decide which failures should reach the credential prompt, which should be reported as service errors, and which genuinely warrant a fallback endpoint.

See [credential access](credentials.md), [HTTP errors](errors.md), and [response metadata](response-metadata.md).

# Examples

The following excerpt is copied from `Anaplan/Anaplan.pq`, lines 665–676.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
                    [ Headers = headers, Content=Text.ToBinary(body), 
                    ManualStatusHandling = {401},
                    RelativePath = Extension.LoadString("AuthTokenPath"),
                    Query=[Authorization="Basic encoded_username:password"]]),
                status = Value.Metadata(contents)[Response.Status], 
                tokenResponseJson = if status <> null and status = 201 then Json.Document(contents)[tokenInfo] 
                    else if status = 401 then error Extension.CredentialError("reason", "Invalid credentials") 
                    else null
            in
                tokenResponseJson
    in
        tokenResponse;
```

[^example]: Anaplan/Anaplan.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **17** connectors in this archive.

* [AnaplanConnector](../connectors/Anaplan.md): [Anaplan.pq line 667](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L667)
* [Asana](../connectors/Asana.md): [Asana.m line 182](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L182)
* [Wolters Kluwer CCH Tagetik](../connectors/CCHTagetik.md): [CCHTagetik.pq line 328](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CCHTagetik/CCHTagetik.pq#L328)
* [Exact Online Premium](../connectors/ExactOnlinePremium.md): [ExactOnlinePremium.m line 26](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ExactOnlinePremium/ExactOnlinePremium.m#L26)
* [FactSetAnalytics](../connectors/FactSetAnalytics.md): [FactSetAnalytics.pq line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/FactSetAnalytics.pq#L364), [request-long-running.pqm line 54](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/FactSetAnalytics/request-long-running.pqm#L54)
* [HexagonSmartApi](../connectors/HexagonSmartApi.md): [HexagonSmartApi.m line 192](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/HexagonSmartApi.m#L192), [UoM.pqm line 124](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/HexagonSmartApi/UoM.pqm#L124)
* [Jamf Pro](../connectors/JamfPro.md): [JamfPro.pq line 164](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/JamfPro/JamfPro.pq#L164)
* [kxkdbinsightsenterprise](../connectors/kxkdbinsightsenterprise.md): [kxkdbinsightsenterprise.pq line 350](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/kxkdbinsightsenterprise/kxkdbinsightsenterprise.pq#L350)
* [LinkedInLearning](../connectors/LinkedInLearning.md): [LinkedInLearning.pq line 30](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LinkedInLearning/LinkedInLearning.pq#L30)
* [OneStream](../connectors/OneStream.md): [OneStream.pq line 792](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/OneStream/OneStream.pq#L792)
* [Shortcuts Business Insights](../connectors/ShortcutsBI.md): [Function.GetData.pqm line 34](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ShortcutsBI/Function.GetData.pqm#L34)
* [SoftOne BI](../connectors/SoftOneBI.md): [SoftOneBI.m line 121](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SoftOneBI/SoftOneBI.m#L121)
* [SolarwindsServiceDesk](../connectors/SolarwindsServiceDesk.md): [SolarWindsServiceDesk.pq line 147](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SolarwindsServiceDesk/SolarWindsServiceDesk.pq#L147)
* [Usercube](../connectors/Usercube.md): [Usercube.m line 199](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Usercube/Usercube.m#L199)
* [Vena](../connectors/Vena.md): [Vena.pq line 122](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Vena/Vena.pq#L122)
* [Wrike](../connectors/Wrike.md): [wrike.m line 388](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Wrike/wrike.m#L388)
* [Zucchetti](../connectors/Zucchetti.md): [Zucchetti.m line 13](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Zucchetti/Zucchetti.m#L13)

<!-- seen-in:end -->
