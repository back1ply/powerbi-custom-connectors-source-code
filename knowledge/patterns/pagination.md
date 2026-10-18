---
type: Power Query Pattern
title: Page generation and cursor traversal
description: Cursor and offset pagination through table metadata.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bTable\.GenerateByPage\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L107
  title: Attio/Attio.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 8a8895dc81539d7fedfd7ae25e170234a1c0275d7713d480e1223385afaab5de
  sources_sha256:
    example: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
---

# Mechanism

Attio selects paging settings by matching an endpoint suffix. Its cursor page function adds a cursor parameter only after an initial page, reads the next cursor from the response, and attaches it to the returned table as `NextCursor` metadata. A false `hasMore` value, a null cursor, or a blank text cursor becomes a null continuation marker.[^example]

When `__sendsLimit(url)` permits it, the offset variant sends the configured offset and limit. It converts the response items to a table and calculates `NextOffset`. An empty page returns `null`; a shorter-than-page-size response marks the continuation as finished. The `Table.GenerateByPage` callbacks read those metadata fields to decide whether to request another page.[^example]

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
