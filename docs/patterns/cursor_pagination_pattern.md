# Power Query Patterns: Cursor & Offset Pagination

In the previous [Pagination Pattern](pagination_pattern.md), we used `Table.GenerateByPage` to handle APIs that return a clean `NextLink` (e.g., `"next": "https://api.com/users?page=2"`).

But what if the API doesn't provide a next link? What if it just expects you to manually increment an `offset` or `page` counter in your URL parameters? (e.g., `?limit=100&offset=0`, then `offset=100`, etc.)

We still use `Table.GenerateByPage`, but instead of storing a URL in the previous page's metadata, we manually calculate and store our counters to pass state between iterations.

## The Offset Pagination Pattern

### 1. Requirements
You still need the `Table.GenerateByPage.pqm` helper file (provided in the basic Pagination pattern).

### 2. Implementation

Notice how the `nextOffset` is calculated based on the *previous* offset plus the fixed limit.

```powerquery
// Define your standard page size
Limit = 100;

GetAllPagesWithOffset = (baseUrl as text) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                // 1. Calculate the new offset based on the previous page's metadata
                currentOffset = if (previous = null) then 0 else Value.Metadata(previous)[NextOffset]?,
                
                // 2. Fetch the data using RelativePath and Query (to avoid Dynamic Data Source errors)
                source = Web.Contents(baseUrl, [
                    RelativePath = "api/v1/records",
                    Query = [
                        limit = Number.ToText(Limit),
                        offset = Number.ToText(currentOffset)
                    ]
                ]),
                json = Json.Document(source),
                data = json[data]?, // Assuming the array is inside a "data" property
                
                // 3. Convert the list of records to a table
                table = if (data = null or List.IsEmpty(data)) 
                        then Table.FromRows({}) 
                        else Table.FromRecords(data),

                // 4. Determine if we need to fetch another page
                // If we got fewer records than our Limit, we've hit the end.
                hasMore = not (table = null) and Table.RowCount(table) = Limit,
                nextOffset = currentOffset + Limit
            in
                // 5. ATTACH THE STATE to the returned table as metadata so the next iteration can read it
                if (hasMore = true) then
                    table meta [NextOffset = nextOffset]
                else
                    table
    );
```

### 3. Usage

You simply call the function with your base URL. The `Table.GenerateByPage` helper will loop invisibly, incrementing the `offset` parameter by 100 each time until the API returns fewer than 100 records.

```powerquery
shared MyConnector.Contents = () =>
    let
        allData = GetAllPagesWithOffset("https://api.mycompany.com")
    in
        allData;
```

### Cursor Pagination Alternative
If the API uses a "Cursor" instead of an offset number (e.g., `?cursor=abc123xyz`), the logic is identical.

Instead of math (`currentOffset + Limit`), you just extract the cursor from the JSON response and attach it to the metadata `table meta [ NextCursor = json[paging][cursor]? ]`. The next iteration reads it `Value.Metadata(previous)[NextCursor]` and passes it to `Web.Contents`.
