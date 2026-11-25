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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L574
  title: Attio/Attio.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L559
  title: Attio/Attio.pq
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L727
  title: Attio/Attio.pq
- id: endpoints
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L314
  title: Attio/Attio.pq
- id: config
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L519
  title: Attio/Attio.pq
- id: dispatch
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L599
  title: Attio/Attio.pq
- id: collection
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L530
  title: Attio/Attio.pq
- id: tabled
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L551
  title: Attio/Attio.pq
- id: request
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/Attio/Attio.pq#L474
  title: Attio/Attio.pq
- id: contrast
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/CogniteDataSource.pq#L739
  title: CogniteDataSource/CogniteDataSource.pq
- id: arg
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/AzureResourceGraph/AzureResourceGraph.pq#L52
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: generator
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/main/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L5
  title: CogniteDataSource/Table.GenerateByPage.pqm
review:
  content_sha256: 2607efd7a437c06a44099dc3647766fcad4007e3f82e3da1f1ff2536e5e9421e
  sources_sha256:
    example: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    variant: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    helper: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    endpoints: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    config: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    dispatch: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    collection: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    tabled: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    request: 9237133d2cb709127824ca5896d32cdade6740fcb7be0e88ccd18268b5f30758
    contrast: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    arg: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    generator: 12d4a8d36904f9684d52a2d82fc67fdf565ebe7be8aa01bf14b5750f78f05637
verified:
  by: claude-code/claude-opus-5-5
  at: '2026-11-25T20:06:22Z'
---

# Page generation and cursor traversal

## Mechanism

Attio declares the paging style per collection. Each `Attio.Collections` entry passes a `Paging` record to `Attio.FetchCollection`. Notes, tasks, threads, and webhooks use `Style = "offsetLimit"`; meetings uses `Style = "cursor"` with `CursorField = "nextCursor"` and `CursorLimitParam = "limit"`; objects, lists, workspace members, and self make one request.[^endpoints] `Attio.FetchCollection` reads `Paging`, its `Style` (default `"none"`), and `PageSize` (default 50) from the options record.[^config]

The cursor branch, `getPageCursor`, sends the limit parameter when `CursorLimitParam` is set and adds the cursor parameter only after the first request. It reads the next cursor from the dotted `CursorField` path (default `next_cursor`), or from the last item's `LastRowIdField` when that option is set, and returns the page with `NextCursor` metadata.[^example] It reads a has-more flag only when `HasMoreField` is configured. No collection sets `HasMoreField` or `LastRowIdField`, so those branches are inactive here.

The offset branch, `getPageOffset`, always sends both the offset and the limit, using `OffsetParam` and `LimitParam` (defaults `offset` and `limit`).[^variant] It returns `null` when the response holds no items. Otherwise it sets `NextOffset` to `null` when fewer than `PageSize` items arrive, and to `offset + PageSize` when a full page arrives. The count is taken from the raw item list, before `toTable` drops non-record items.

The `result` binding dispatches on the style. `offsetLimit` and `cursor` (or `cursorId`) call `Table.GenerateByPage` with the matching callback and an empty schema table; any other style makes one request.[^dispatch] The connector's own `Table.GenerateByPage` calls the callback with `null`, keeps requesting while pages are non-null, and takes its output columns and type from the first page. When the first call already returns `null`, it returns the supplied empty table.[^helper]

## Selection and dependencies

Use this shape when the response gives a continuation token or a page offset. The inputs are the request URL and the collection's `Paging` record and page size. The output is one table of concatenated records. The dependencies are `pickCollection`, which chooses the item list,[^collection] `toTable`, which applies the declared schema,[^tabled] and `Attio.Request`, which every page request goes through. It retries HTTP 500 and 502 twice, after 1 and 2 seconds, then raises `HttpRequestFailed`.[^request]

Attio's per-collection `Paging` records configure known cursor or offset parameters. Next-page URLs and SkipTokens need their own request construction, covered in [response metadata](response-metadata.md), while sharing the callback shape. Cognite converts an empty continuation page to null. Its loaded generator separately returns an empty first page unchanged, without demanding later pages, even if that page carries a cursor. AzureResourceGraph uses the same callback shape for a SkipToken.[^contrast][^generator][^arg]

## Adaptation and failure paths

An empty first page keeps the declared columns. When no record items come back, `toTable` builds an empty table from the collection's column names and still applies the schema.[^tabled] The offset branch returns `null` for that page, and `Table.GenerateByPage` then returns the empty schema table passed by `result`.[^dispatch][^helper] The cursor branch returns the empty page itself. Test an empty response separately from a response with rows.

Missing and null cursors both end paging. `__readPath` returns null for a missing segment, and a blank cursor becomes null.[^example] This is a simple stop rule, but an API that renames the cursor field stops after one page with no error. The cursor branch never returns `null` itself, so an empty page that still carries a cursor leads to another request.

A non-retried failure stops the whole table. Only 500 and 502 are retried; other error statuses use the default `Web.Contents` handling, and a third 500 or 502 raises an error.[^request] One failing page fails every page of that collection.

## Validation checklist

- Confirm `CursorParam`, `CursorField`, `CursorLimitParam`, `OffsetParam`, and `LimitParam` in each collection's `Paging` record against the API's documentation.[^endpoints]
- Check `pickCollection` for each endpoint: the `CollectionPath` (or `collectionName`) path first, then the first list-valued field outside the reserved names; a record result becomes one row.[^collection]
- Test a final page with exactly `PageSize` items. The offset branch requests another page, and an empty or short page ends paging.
- Test an empty first page and check the output columns.
- Test a cursor endpoint whose last page still returns a cursor.

For throttling between pages, see [retries and polling](retry-polling.md).

## Examples

Cursor helper, Attio lines 574–598:

<!-- source: example -->
```powerquery
            getPageCursor = (cursor as nullable text) as nullable table =>
                let
                    cursorParam = Record.FieldOrDefault(__paging, "CursorParam", "cursor"),
                    limitParam = Record.FieldOrDefault(__paging, "CursorLimitParam", null),
                    baseQuery = if limitParam = null then []
                        else Record.AddField([], limitParam, Text.From(__pageSize)),
                    query = if cursor = null then baseQuery
                        else Record.AddField(baseQuery, cursorParam, cursor),
                    response = Attio.RequestJson(url, query),
                    items = pickCollection(response),
                    page = toTable(items),
                    cursorField = Record.FieldOrDefault(__paging, "CursorField", "next_cursor"),
                    hasMoreField = Record.FieldOrDefault(__paging, "HasMoreField", null),
                    lastRowIdField = Record.FieldOrDefault(__paging, "LastRowIdField", null),
                    hasMore = if hasMoreField = null then null
                        else __readPath(response, Text.Split(hasMoreField, ".")),
                    responseCursor = if lastRowIdField <> null
                        then if List.IsEmpty(items) then null
                            else Record.FieldOrDefault(List.Last(items), lastRowIdField, null)
                        else __readPath(response, Text.Split(cursorField, ".")),
                    nextCursor = if hasMore = false or responseCursor = null
                        or (responseCursor is text and Text.Trim(responseCursor) = "")
                        then null else Text.From(responseCursor)
                in
                    page meta [NextCursor = nextCursor],
```

Offset helper, Attio lines 559–573:

<!-- source: variant -->
```powerquery
            getPageOffset = (offset as number) as nullable table =>
                let
                    offsetParam = Record.FieldOrDefault(__paging, "OffsetParam", "offset"),
                    limitParam = Record.FieldOrDefault(__paging, "LimitParam", "limit"),
                    query = Record.AddField(
                        Record.AddField([], offsetParam, Text.From(offset)),
                        limitParam,
                        Text.From(__pageSize)),
                    response = Attio.RequestJson(url, query),
                    items = pickCollection(response),
                    page = toTable(items),
                    itemCount = List.Count(items),
                    nextOffset = if itemCount < __pageSize then null else offset + __pageSize
                in
                    if itemCount = 0 then null else page meta [NextOffset = nextOffset],
```

Local `Table.GenerateByPage`, Attio lines 727–736:

<!-- source: helper -->
```powerquery
Table.GenerateByPage = (getNextPage as function, optional emptyTable as nullable table) as table =>
    let
        listOfPages = List.Generate(() => getNextPage(null), (lastPage) => lastPage <> null, (lastPage) => getNextPage(lastPage)),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then (emptyTable ?? Table.FromRows({}))
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

[^endpoints]: Attio/Attio.pq lines 314–468 (`Attio.Collections`): each entry's `Fetch` passes `CollectionPath`, `Columns`, `Expansions`, and `Paging`; for example notes (line 379, offset) and meetings (line 430, cursor).
[^config]: Attio/Attio.pq lines 519–521 (`Attio.FetchCollection`): `Paging`, `Style`, and `PageSize` read with defaults `[Style = "none"]`, `"none"`, and 50.
[^example]: Attio/Attio.pq lines 574–598 (`getPageCursor`): cursor and limit query, `CursorField`, `HasMoreField`, and `LastRowIdField` handling, and `NextCursor` metadata on the returned page.
[^variant]: Attio/Attio.pq lines 559–573 (`getPageOffset`): offset and limit query, empty-response handling, and the `NextOffset` calculation from the raw item count.
[^dispatch]: Attio/Attio.pq lines 599–621 (`result`): dispatch by style, `toTable({})` as the empty table, and the single-request branch.
[^helper]: Attio/Attio.pq lines 727–736: the connector's local `Table.GenerateByPage`, its stop condition, its column source, and the `emptyTable` fallback.
[^collection]: Attio/Attio.pq lines 530–550 (`pickCollection`): explicit path, then the first list field outside the reserved names, then the record itself.
[^tabled]: Attio/Attio.pq lines 551–558 (`toTable`): keeps record items; an empty list becomes a table with the declared column names; `ApplySchema` runs in both cases.
[^request]: Attio/Attio.pq lines 474–498 (`Attio.Request`): manual handling of 500 and 502, retries with `Function.InvokeAfter`, and `HttpRequestFailed` after the third attempt.
[^contrast]: CogniteDataSource/CogniteDataSource.pq lines 739–768 (`GetAllGraphQLPagesByCursor`): callback reads `Cursor` metadata and returns null for an empty page.
[^arg]: AzureResourceGraph/AzureResourceGraph.pq lines 52–62 (`ARGImpl`): callback reads `SkipToken` metadata with the same `Table.GenerateByPage` shape.

[^generator]: Cognite’s loaded page generator returns an empty first table unchanged; its nonempty branch expands later pages.
