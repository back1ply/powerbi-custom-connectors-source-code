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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L80
  title: Attio/Attio.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L96
  title: Attio/Attio.pq
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L186
  title: Attio/Attio.pq
- id: selector
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L67
  title: Attio/Attio.pq
- id: dispatch
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L108
  title: Attio/Attio.pq
- id: collection
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L10
  title: Attio/Attio.pq
- id: tabled
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Attio/Attio.pq#L48
  title: Attio/Attio.pq
- id: contrast
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L739
  title: CogniteDataSource/CogniteDataSource.pq
- id: arg
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L52
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: generator
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L5
  title: CogniteDataSource/Table.GenerateByPage.pqm
review:
  content_sha256: 9fa9d436cbe3de7703dd0100297e00be3d53f1f3931c20ed895e07ca5e61082c
  sources_sha256:
    example: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    variant: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    helper: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    selector: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    dispatch: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    collection: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    tabled: 57a398b8b0d14e01888b0484e169d12a946dd076ea8d5166d56b62939a434428
    contrast: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    arg: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    generator: 12d4a8d36904f9684d52a2d82fc67fdf565ebe7be8aa01bf14b5750f78f05637
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Page generation and cursor traversal

## Mechanism

Attio picks its paging style from the request URL. `__pickPaging` tests each `__pagingByPath` entry with `Text.EndsWith`, sorts the matches by suffix length, and keeps the longest one.[^selector] A URL with no match gets `Style = "none"` and one request. The suffixes are literal text, so an entry such as `/v2/lists/{list}/views` can only match a URL that contains literal braces. The navigation requests reach the paged branches through concrete entries: notes, tasks, threads, and webhooks use offsets, and meetings uses a cursor.[^dispatch]

The cursor branch, `getPageCursor`, adds the cursor query parameter only after the first request. It reads the continuation value at `CursorField`, and it returns the table with `NextCursor` metadata.[^example] It reads `hasMore` only when a `HasMoreField` is configured. No entry in this table sets one, so that branch is inactive here.

The offset branch, `getPageOffset`, sends `offset` and `limit` only when `__sendsLimit(url)` allows it. Otherwise it sends an empty query.[^variant] It returns `null` for an empty page. Otherwise it sets `NextOffset` to `null` when fewer than 50 records arrive, and to `offset + 50` when a full page arrives.

The `result` binding dispatches on `__style` to `Table.GenerateByPage` with the matching callback, or makes one request for `none`.[^dispatch] The connector's own `Table.GenerateByPage` calls the callback with `null`, keeps requesting while pages are non-null, and takes its output columns from the first page.[^helper]

## Selection and dependencies

Use this shape when the response gives a continuation token or a page offset. The inputs are the request URL, the per-endpoint table, and the page-size constant `__pageSize` (line 9). The output is one table of concatenated records. The dependencies are `pickCollection`, which chooses the item list,[^collection] `toTable`,[^tabled] and `__sendsLimit`, which gates the limit parameter.

Attio's suffix table configures known cursor or offset parameters. Next-page URLs and SkipTokens need their own request construction, covered in [response metadata](response-metadata.md), while sharing the callback shape. Cognite converts an empty continuation page to null. Its loaded generator separately returns an empty first page unchanged, without demanding later pages, even if that page carries a cursor. AzureResourceGraph uses the same callback shape for a SkipToken.[^contrast][^generator][^arg]

## Adaptation and failure paths

An empty first page loses its schema. When no items come back, `toTable` returns `#table({}, {})` and skips `ApplySchema`.[^tabled] The helper takes its column list from that first page, so the result has no columns.[^helper] Test an empty response separately from a response with rows.

Missing and null cursors both end paging. `__readPath` returns null for a missing segment, and a blank cursor becomes null.[^example] This is a simple stop rule, but an API that renames the cursor field stops after one page with no error.

Offset without a limit can repeat a page. When `__sendsLimit(url)` is false, `getPageOffset` sends no offset at all.[^variant] Every offset entry in this table is also in `__sizeKnobPaths`, so the current configuration avoids that path. A new offset entry missing from that list would request the same first page each time, and keep going while that page has 50 or more rows.

Suffix matching does not substitute placeholders. An entry containing literal `{list}` text will not match an ordinary URL containing an actual list identifier. Test the configured suffix against the exact URL produced by navigation.[^selector]

## Validation checklist

- Confirm `CursorParam`, `CursorLimitParam`, `OffsetParam`, and `LimitParam` against the API's documentation.
- Check `pickCollection` for each endpoint: the explicit `collectionName`, then the first list-valued field outside the reserved names, then a single record.[^collection]
- Test a final page with exactly 50 rows. The offset branch requests another page, and a short page ends paging.
- Test an empty first page and check the output columns.
- Give each paged endpoint a concrete test URL and confirm `__pickPaging` returns the intended style.

For throttling between pages, see [retries and polling](retry-polling.md).

## Examples

Cursor helper, Attio lines 80–95:

<!-- source: example -->
```powerquery
            getPageCursor = (cursor as nullable text) as nullable table =>
                let
                    __lim    = __paging[CursorLimitParam]?,
                    base     = if __lim <> null and __sendsLimit(url) then Record.AddField([], __lim, Text.From(__pageSize)) else [],
                    query    = if cursor = null then base else Record.AddField(base, __paging[CursorParam], cursor),
                    response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    rawCursor = __readPath(response, __paging[CursorField]),
                    __hm     = __paging[HasMoreField]?,
                    hasMore  = if __hm = null then null else __readPath(response, __hm),
                    nextCursor = if hasMore = false or rawCursor = null or (rawCursor is text and Text.Trim(rawCursor) = "") then null else rawCursor,
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items)
                in
                    asTable meta [NextCursor = nextCursor],
```

Offset helper, Attio lines 96–107:

<!-- source: variant -->
```powerquery
            getPageOffset = (offset as number) as nullable table =>
                let
                    query    = if __sendsLimit(url) then Record.AddField(Record.AddField([], __paging[OffsetParam], Text.From(offset)), __paging[LimitParam], Text.From(__pageSize)) else [],
                    response = Json.Document(Web.Contents(url, [Query = query, Headers = [Authorization = "Bearer " & Extension.CurrentCredential()[Key]]])),
                    items    = if response is record then pickCollection(response)
                               else if response is list then response
                               else {},
                    asTable  = toTable(items),
                    rowCount = Table.RowCount(asTable),
                    nextOffset = if rowCount < __pageSize then null else offset + __pageSize
                in
                    if rowCount = 0 then null else asTable meta [NextOffset = nextOffset],
```

Local `Table.GenerateByPage`, Attio lines 186–195:

<!-- source: helper -->
```powerquery
Table.GenerateByPage = (getNextPage as function) as table =>
    let
        listOfPages = List.Generate(() => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then Table.FromRows({})
        else Value.ReplaceType(
            Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
            Value.Type(firstRow[Column1]));
```

Shared callback shape, CogniteDataSource lines 739–768:

<!-- source: contrast -->
```powerquery
GetAllGraphQLPagesByCursor = (url as text, payload as text, variables as record) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                // if previous is null, then this is our first page of data
                nextCursor = if (previous = null) then null else Value.Metadata(previous)[Cursor]?,
                // if nextCursor was set to null by the previous call, we know we have no more data
                // if previous = null it's the first page
                page =
                    if previous = null then
                        // first page
                        GetGraphQLPage(url, payload, variables, null)
                    else if (nextCursor <> null) then
                        // pages
                        let
                            items = GetGraphQLPage(url, payload, variables, nextCursor),
                            pageitems = if Table.RowCount(items) = 0
                            // return null instead of empty table
                            then
                                null
                            else
                                items
                        in
                            pageitems
                    else
                        // last page
                        null
            in
                page
    );
```

[^selector]: Attio/Attio.pq lines 67–73 (`__pickPaging`): longest-suffix lookup over `__pagingByPath`; returns `Style = "none"` when nothing matches.
[^example]: Attio/Attio.pq lines 80–95 (`getPageCursor`): cursor query, `nextCursor` and `hasMore` handling, and `NextCursor` metadata on the returned table.
[^variant]: Attio/Attio.pq lines 96–107 (`getPageOffset`): offset query gated by `__sendsLimit`, empty-page handling, and the `NextOffset` calculation.
[^dispatch]: Attio/Attio.pq lines 108–119 (`result`) dispatch by style; the navigation requests and their paths are in `Attio.ContentsImpl`, lines 135–143.
[^helper]: Attio/Attio.pq lines 186–195: the connector's local `Table.GenerateByPage`, its stop condition, and its column source.
[^collection]: Attio/Attio.pq lines 10–26 (`pickCollection`): explicit field, then the first list field outside the reserved names, then a single record.
[^tabled]: Attio/Attio.pq lines 48–50 (`toTable`): an empty item list returns `#table({}, {})` without `ApplySchema`.
[^contrast]: CogniteDataSource/CogniteDataSource.pq lines 739–768 (`GetAllGraphQLPagesByCursor`): callback reads `Cursor` metadata and returns null for an empty page.
[^arg]: AzureResourceGraph/AzureResourceGraph.pq lines 52–62 (`ARGImpl`): callback reads `SkipToken` metadata with the same `Table.GenerateByPage` shape.

[^generator]: Cognite’s loaded page generator returns an empty first table unchanged; its nonempty branch expands later pages.
