---
type: Power Query Pattern
title: Response and pagination metadata
description: Pagination state versus HTTP response metadata.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bValue\.Metadata\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L54
  title: AzureResourceGraph/AzureResourceGraph.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 42f77eda0b02bd8c606688344cb829a6be60cae64f0e4a6dab0569a39bc0a31e
  sources_sha256:
    example: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
---

# Mechanism

AzureResourceGraph stores a continuation token on its returned table with `meta [SkipToken = nextSkipToken]`. The next page callback reads that field using `Value.Metadata(previous)[SkipToken]?`. For the first page it uses an empty string as the initial token; a null continuation token stops further page requests.[^example]

The same source uses `Value.Metadata(result)[Response.Status]` on a `Web.Contents` response inside `WaitForResult`. These are different metadata contracts: one is page state attached by the connector, while the other is status information read from a response. The presence of `Value.Metadata` alone does not identify HTTP-header handling.[^example]

# Adaptation and failure paths

Keep metadata attachment and retrieval together when studying a paging helper. If an intermediate transformation loses the table metadata, a later continuation read no longer has the state shown here. Inspect the final returned expression, including its `meta` suffix, instead of looking only at the table-building steps.[^example]

Distinguish a deliberately absent continuation token from a malformed response or failed page conversion. The optional `SkipToken` lookup returns null when the field is missing, which the callback treats as completion. Check the producer's invariants before using the same convention for another API.[^example]

See [pagination](pagination.md), [web requests](web-requests.md), and [retries](retry-polling.md).

# Examples

The following excerpt is copied from `AzureResourceGraph/AzureResourceGraph.pq`, lines 54–65.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
        let
            // if previous is null, then this is our first page of data
            nextToken = if (previous = null) then "" else Value.Metadata(previous)[SkipToken]?,
            // if NextToken was set to null by the previous call, we know we have no more 
            delay = Number.RandomBetween(1, 3),
            page = if (nextToken <> null) then Function.InvokeAfter(() => GetPage(query, nextToken, scope, subscription, managementGroup, options), #duration(0,0,0,delay)) else null
        in
            page
    );

GetPage = (query as text, skipToken as text, optional scope as nullable text, optional subscription as text, optional managementGroup as text, optional options as record) as table =>
    let
```

[^example]: AzureResourceGraph/AzureResourceGraph.pq; see the matching `sources` entry.
