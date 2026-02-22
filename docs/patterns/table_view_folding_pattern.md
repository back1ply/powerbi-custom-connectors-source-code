# Power Query Patterns: Custom Query Folding (`Table.View`)

The holy grail of Power Query connector development is **Query Folding**.

Query Folding is the engine's ability to take the M operations a user performs in the Power BI interface (e.g., removing a column, filtering rows by `Date > 2024`, keeping the top 50 rows) and translate them into a native query executed by the database server (like SQL `SELECT name, date FROM table WHERE date > 2024 LIMIT 50`).

Without Query Folding, if the user filters a 10,000,000 row table down to 50 rows, Power Query downloads all 10,000,000 rows to the user's laptop RAM, and *then* locally filters it down to 50. 

Connectors that map to SQL drivers (`Odbc.DataSource`, `Sql.Database`, `Value.NativeQuery`) get Query Folding automatically. **REST API connectors (`Web.Contents`), however, do not.**

To implement Query Folding for a REST API that supports dynamic `$filter`, `$select`, or `$top` URL parameters, you must build a custom `Table.View`.

## The `Table.View` Implementation

`Table.View` allows you to intercept Power Query's internal M operations *before* any data is loaded, and dynamically rewrite your REST API URL parameters based on what the user clicked in the UI.

In this pattern, we will intercept a `Table.FirstN` (Keep Top Rows) operation and translate it into an API `?limit=` parameter.

### 1. Define the View Handlers

```powerquery
shared MyConnector.GetUsers = () =>
    let
        // 1. Define the base API URL
        sourceUrl = "https://api.mycompany.com/v1/users",
        
        // 2. We use Table.View to intercept M operations that are applied to this query downstream.
        // It takes a base table (usually null for custom sources) and a record of Handlers.
        View = (state as record) => Table.View(null, [
            
            // ----------------------------------------------------------------
            // MANDATORY HANDLERS
            // ----------------------------------------------------------------
            
            // GetType: Tells the UI what columns exist before the data is downloaded
            GetType = () => type table [
                Id = Int64.Type,
                Name = type text,
                Department = type text
            ],
            
            // GetRows: This is the function that ACTUALLY executes the HTTP request
            // It reads the `state` record to see if any operations were intercepted
            GetRows = () =>
                let
                    // Check our custom state record to see if a Top or Limit was intercepted
                    topRowsLimit = state[Top]? ,
                    
                    // Build the query string dynamically
                    queryRecord = if topRowsLimit <> null then [ limit = Text.From(topRowsLimit) ] else [],
                    
                    // Fetch the data
                    response = Web.Contents(sourceUrl, [ Query = queryRecord ]),
                    json = Json.Document(response),
                    
                    // Convert to table and enforce the Type
                    table = Table.FromRecords(json),
                    typedTable = Value.ReplaceType(table, type table [
                        Id = Int64.Type,
                        Name = type text,
                        Department = type text
                    ])
                in
                    typedTable,
                    
            // ----------------------------------------------------------------
            // INTERCEPTION HANDLERS (Query Folding)
            // ----------------------------------------------------------------
            
            // OnTake: Intercepts `Table.FirstN(table, count)`
            OnTake = (count as number) =>
                let
                    // 1. Update our internal state record with the count of rows the user requested
                    newState = state & [ Top = count ],
                    
                    // 2. Return a brand NEW Table.View with the updated state
                    // This creates an iterative loop where the engine collects all interceptions
                    // before finally calling GetRows()
                    newView = View(newState)
                in
                    newView
        ])
    in
        // 3. Initiate the View loop with an empty state record
        View([]);
```

### How it Works in Practice

1. The user clicks **Get Data -> MyConnector**. The engine calls `View([])`. It invokes `GetType()` to render the column headers instantly without downloading anything.
2. The user clicks **Keep Top Rows -> 50**.
3. Instead of downloading all rows, the engine notices our connector has an `OnTake` handler.
4. The engine invokes `OnTake(50)`.
5. Our code updates the internal tracker: `state = [Top = 50]`.
6. The engine finishes its M steps and says "Give me the data". It invokes `GetRows()`.
7. `GetRows()` reads `state[Top]`, realizes it equals 50, and generates an optimized HTTP request: `GET https://api.mycompany.com/v1/users?limit=50`.

### Extending the View
Advanced Microsoft connectors (like **OData**, **Databricks**, **Salesforce**) deploy massive `Table.View` implementations that intercept dozens of operations:
- `OnTake` (limit/top)
- `OnSkip` (offset)
- `OnSelectColumns` (select)
- `OnSort` (order_by)
- `OnSelectRows` (where/filter) -> *This is the most complex, as you must recursively parse the Abstract Syntax Tree (AST) of the M filter function to translate `each [Date] > #date(2024,1,1)` into `?date_gt=2024-01-01`.*
