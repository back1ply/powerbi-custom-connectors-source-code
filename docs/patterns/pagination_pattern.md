# Power Query Patterns: Handling API Pagination

REST APIs rarely return all of their data in a single request. They enforce pagination, requiring you to make multiple calls (e.g., passing a `page=2` parameter or following a `next_url` link).

Because Power Query (`M`) is a functional language, it does not have traditional `while` loops. Instead, you must use the `List.Generate` function to lazily evaluate and iterate through pages until the API tells you to stop.

## The `Table.GenerateByPage` Helper

Across the Microsoft-Certified connectors, the standard practice is to use a helper function called `Table.GenerateByPage`. This function wraps the complex `List.Generate` logic into a reusable block.

### 1. Define the Helper (Usually kept in a separate `.pqm` file or at the bottom of your code)

```powerquery
// Table.GenerateByPage Helper Function
Table.GenerateByPage = (getNextPage as function) as table =>
    let
        listOfPages = List.Generate(
            // 1. Get the first page of data (pass null as the previous state)
            () => getNextPage(null),
            
            // 2. Condition to keep looping (stop when the function returns null)
            (lastPage) => lastPage <> null,
            
            // 3. Get the next page (pass the previous page's metadata to the next call)
            (lastPage) => getNextPage(lastPage)
        ),
        
        // Concatenate the list of tables into a single table
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"}),
        firstRow = tableOfPages{0}?
    in
        if (firstRow = null) then
            Table.FromRows({})
        else if (Table.IsEmpty(firstRow[Column1])) then
            firstRow[Column1]
        else
            Value.ReplaceType(
                Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(firstRow[Column1])),
                Value.Type(firstRow[Column1])
            );
```

### 2. Implement the Paging Logic for your API

To use the helper, you need to write a function that takes the `previous` page's result, inspects its metadata (like a `NextLink` URL), and fetches the new data.

Here is the standard boilerplate extracted from the Zendesk and SiteImprove connectors:

```powerquery
// A single API call that returns one table of data AND attaches the NextLink as metadata
GetPage = (url as text) as table =>
    let
        response = Web.Contents(url),
        body = Json.Document(response),
        
        // 1. Extract the data array
        dataArray = body[data],
        dataTable = Table.FromRecords(dataArray),
        
        // 2. Extract the pagination cursors (Modify this based on your API's JSON structure)
        nextLink = try body[links][next] otherwise null,
        hasMore = if nextLink <> null then true else false
    in
        // Attach the cursor variables as metadata to the returned table so the next loop can read them
        dataTable meta [NextLink = nextLink, HasMore = hasMore];

// The recursive wrapper that calls GetPage until HasMore is false
GetAllPages = (initialUrl as text) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                // If previous is null, this is the very first request
                nextLink = if (previous = null) then initialUrl else Value.Metadata(previous)[NextLink]?,
                
                // If previous is null, we definitely have more data (first run). 
                hasMore = if (previous = null) then true else Value.Metadata(previous)[HasMore]?,
                
                // If we have more data, fetch the NextLink. Otherwise, return null to break the List.Generate loop.
                page = if (hasMore = true and nextLink <> null) then 
                           GetPage(nextLink) 
                       else 
                           null
            in
                page
    );
```

**How to use it:**
Instead of calling `Web.Contents` directly in your navigation table, you simply call `GetAllPages("https://api.yourservice.com/v1/users")`. The engine will automatically evaluate the pages and stitch them together into one massive table for the user.
