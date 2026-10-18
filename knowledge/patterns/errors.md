---
type: Power Query Pattern
title: Structured errors and HTTP status handling
description: Explicit API errors and the limits of handled-status branches.
category: Schema and errors
tags: [schema-and-errors]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Error\.Record\s*\(|ManualStatusHandling\s*=)']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L134
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:38Z'
review:
  content_sha256: 7d991899de07df1694a1dd3a67fd98204790e24a5cd4cd3790e1e0b7e43b2260
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana's login callback parses the callback query and checks for both `error` and `error_description` fields. When the check succeeds it raises `Error.Record` with the provider's fields and the parsed record; otherwise it accesses `parts[code]` and calls `TokenMethod`. The token response is checked using a similar two-field condition.[^example]

`TokenMethod` manually handles HTTP 400 and parses its JSON body before making that decision. `GetTasks` handles 403 separately and raises an error when its parsed response is a record containing the expected error fields. Those status lists and response-shape checks belong to different calls in the same connector.[^example]

# Adaptation and failure paths

Read the condition as written: a response containing only one of the expected fields does not satisfy the two-field check. In the callback that can lead to the subsequent code-field access instead of the intended provider error. Include incomplete error payloads in a new connector's response-contract tests rather than treating the presence of `Error.Record` as complete coverage.[^example]

Do not turn all unexpected payloads into an empty result. Decide whether an error should request fresh credentials, explain a service failure, or stop parsing a malformed response. Keep any diagnostic details useful while excluding tokens and credential values from surfaced messages.

See [web-request failure handling](web-requests.md), [GraphQL errors](graphql.md), and [diagnostics](diagnostics.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 134–145.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code], context)
    in
        result;

TokenMethod = (grantType, tokenField, code, context) =>
    let
        queryString = [
            grant_type = grantType,
```

[^example]: Asana/Asana.m; see the matching `sources` entry.
