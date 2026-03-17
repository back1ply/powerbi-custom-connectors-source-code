# Power Query Patterns: API Pagination with `Table.GenerateByPage`

REST APIs rarely return all data in a single request. They enforce pagination, requiring multiple calls (e.g., `page=2` parameters or `next_url` links).

Because Power Query M is a functional language without traditional `while` loops, iteration is done with `List.Generate`. However, `List.Generate` yields a list of `Record` objects — the developer must then manually convert it to a table (`Table.FromList`) and expand columns (`Table.ExpandTableColumn`).

To abstract away this boilerplate, Microsoft engineers use an undocumented, standardized helper called `Table.GenerateByPage`. It wraps `List.Generate` and automatically produces a perfectly typed, merged `Table`.

## The `Table.GenerateByPage` Boilerplate

You can find this exact script natively embedded in over 500 places across the Microsoft Certified Connectors repository (including Zendesk, SurveyMonkey, Wrike, and SiteImprove).

### 1. The Helper Function

Copy and paste this exact function into your connector.

```powerquery
// Boilerplate Helper Function: Do Not Modify
Table.GenerateByPage = (getNextPage as function) as table =>
    let
        listOfPages = List.Generate(
            // 1. Get the first page of data (pass null as the 'previous' page state)
            () => getNextPage(null),

            // 2. Stop when the function returns null
            (lastPage) => lastPage <> null,

            // 3. Pass the previous page into the function to fetch the next page
            (lastPage) => getNextPage(lastPage)
        ),

        // Concatenate the pages together into a single column of lists
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        // If we didn't get back any pages of data, return an empty table
        if (firstRow = null) then
            Table.FromRows({})

        // Check for an empty first table
        else if (Table.IsEmpty(firstRow[Column1])) then
            firstRow[Column1]

        // Otherwise, automatically expand the list into a flat table and
        // enforce the schema of the very first page onto all subsequent pages.
        else
            Value.ReplaceType(
                Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                Value.Type(firstRow[Column1])
            );
```

### 2. Implementation

To use this helper, you simply write a standard function that takes in a `previous` record and returns a `Table`. You pass that function directly into `Table.GenerateByPage`.

The helper handles all the `List.Generate` loop logic, the null-checking, the table concatenations, and the schema enforcement (`Value.ReplaceType`).

```powerquery
shared MyConnector.GetUsers = () =>
    let
        // Define the function that fetches exactly one page.
        // The 'previous' variable represents the table returned by the PREVIOUS execution of this function.
        // On the very first execution, 'previous' is null.
        GetNextPage = (previous as nullable table) as nullable table =>
            let
                // 1. Determine the pagination tokens
                // If previous is null, this is the first request. Otherwise, grab the "next" token from the previous metadata.
                nextLink = if previous = null then
                    "https://api.mycompany.com/users"
                else
                    Value.Metadata(previous)[NextLink]?,

                // 2. If there is no next link (we've hit the end), return null to break the loop
                result = if nextLink = null then
                    null
                else
                    let
                        // 3. Execute the request
                        response = Web.Contents(nextLink),
                        json = Json.Document(response),

                        // 4. Convert the JSON array into a Table
                        dataTable = Table.FromRecords(json[data]),

                        // 5. Stamp the NextLink onto the Table's metadata so we can access it on the next loop iteration
                        dataTableWithMeta = dataTable meta [ NextLink = json[paging][next] ]
                    in
                        dataTableWithMeta
            in
                result,

        // Simply pass the function to the helper. It will loop indefinitely and return one massive, flattened table.
        AllData = Table.GenerateByPage(GetNextPage)
    in
        AllData;
```

### Why Use the Helper?

The true genius of this helper is the `Value.ReplaceType` operation at the end. Power Query's `Table.Combine()` is notoriously slow when joining thousands of distinct API tables. By stamping the exact type definition of the _first_ page onto the master concatenated table, `Table.GenerateByPage` avoids an expensive M Engine type-inference recalculation, drastically improving performance on large API downloads.

## Cursor & Offset Pagination

The `NextLink` pattern above works when an API returns a ready-made next URL. Many APIs instead require you to manually increment an `offset` or `page` counter (e.g., `?limit=100&offset=0`, then `offset=100`). `Table.GenerateByPage` handles this too — store the counter in metadata instead of a URL.

### Offset Pagination

```powerquery
Limit = 100;

GetAllPagesWithOffset = (baseUrl as text) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                currentOffset = if (previous = null) then 0 else Value.Metadata(previous)[NextOffset]?,

                source = Web.Contents(baseUrl, [
                    RelativePath = "api/v1/records",
                    Query = [
                        limit = Number.ToText(Limit),
                        offset = Number.ToText(currentOffset)
                    ]
                ]),
                json = Json.Document(source),
                data = json[data]?,

                table = if (data = null or List.IsEmpty(data))
                        then Table.FromRows({})
                        else Table.FromRecords(data),

                hasMore = not (table = null) and Table.RowCount(table) = Limit,
                nextOffset = currentOffset + Limit
            in
                if (hasMore = true) then
                    table meta [NextOffset = nextOffset]
                else
                    table
    );
```

Usage: `GetAllPagesWithOffset("https://api.mycompany.com")` — the helper loops invisibly, incrementing `offset` by 100 each time until the API returns fewer than 100 records.

### Cursor Pagination

If the API uses a cursor string instead of a numeric offset (e.g., `?cursor=abc123xyz`), the logic is identical. Instead of arithmetic (`currentOffset + Limit`), extract the cursor from the JSON response and attach it to metadata:

```powerquery
dataTableWithMeta = dataTable meta [ NextCursor = json[paging][cursor]? ]
// Next iteration reads: Value.Metadata(previous)[NextCursor]
```

---

## See Also

- [`cursor_pagination_pattern.md`](cursor_pagination_pattern.md) — Extended offset/cursor examples with full `Web.Contents` `RelativePath`/`Query` construction.
- [`caching_table_buffer_pattern.md`](caching_table_buffer_pattern.md) — Buffer the paginated result list to prevent re-evaluation during navigation table construction.
