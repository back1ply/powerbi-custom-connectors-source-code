# Power Query Patterns: The `Table.GenerateByPage` Helper

In the [Pagination Pattern](pagination_pattern.md), we documented how to use `List.Generate` to recursively iterate over an API that returns multiple pages of data. 

While `List.Generate` is incredibly powerful, it yields a single list of complex `Record` objects. The developer is then forced to manually convert that list into a table (`Table.FromList`) and manually expand the underlying columns (`Table.ExpandTableColumn`). 

To abstract away all of that manual table manipulation, Microsoft engineers use an undocumented, standardized boilerplate script called `Table.GenerateByPage`. It wraps `List.Generate` and automatically spits out a perfectly typed, merged `Table`.

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
The true genius of this helper is the `Value.ReplaceType` operation located at the very end of the script. Power Query's `Table.Combine()` operation is notoriously slow when joining thousands of distinct API tables. By stamping the exact Type Definition of the *first* page onto the master concatenated table, `Table.GenerateByPage` avoids an expensive M Engine type-inference recalculation, drastically improving the performance of massive API downloads.
