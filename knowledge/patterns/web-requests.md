---
type: Power Query Pattern
title: Web requests and relative paths
description: Web request options and explicit HTTP response branches.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:42Z'
detect: [\bRelativePath\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L665
  title: Anaplan/Anaplan.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: dc5ff436582078d15db334872866231ff77e38d7a861d9eb1b84d3c94037f7b2
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
---

# Mechanism

Anaplan's `GetApiToken` creates a request to `authUrl` with a relative authentication path loaded from a resource string. It supplies a binary body, headers, a query record, and `ManualStatusHandling = {401}` in the same `Web.Contents` options record. The source chooses a different header record when `isRefresh` is true.[^example]

The function reads `Response.Status` from the response metadata. Inside `getToken`, status 201 extracts `tokenInfo` from the parsed JSON, status 401 raises `Extension.CredentialError`, and other statuses produce null. The `tokenResponse` binding uses `try getToken() otherwise null`. The outer function declares an `as record` return type, so the inner null fallback alone does not establish what callers receive.[^example]

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
