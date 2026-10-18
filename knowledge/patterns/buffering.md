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
  at: '2026-10-18T10:34:38Z'
review:
  content_sha256: ceda381dfba2141c0fbefb94c033f0da15524f6e13fe41d8209e100b1955c164
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
---

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
