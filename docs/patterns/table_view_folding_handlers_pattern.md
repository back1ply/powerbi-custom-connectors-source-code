# Power Query Patterns: REST API Query Folding (`Table.View` Handlers)

In our previous `Table.View` pattern, we covered the *structure* of creating a custom query folding engine. We established that `Table.View` acts as a proxy, intercepting M functions like `Table.FirstN()` or `Table.Skip()` and passing them to our custom handlers (`OnTake` and `OnSkip`).

But how do you actually translate those intercepted actions into a working REST API call?

This pattern demonstrates how to map `Table.View` state variables directly into a `Web.Contents` URL query string, achieving true server-side delegation for OData-like REST APIs.

## The State Accumulator Pattern

The core concept relies on maintaining a `state` record. Every time `Table.View` intercepts an M function, it returns a *new* instance of `Table.View` with an updated `state` record. 

When the Power Query Engine finally requests the actual data (via `GetRows`), we read the *final accumulated state* and build the HTTP request.

```powerquery
// 1. Define the initial state when the table is first loaded
InitialState = [
    Url = "https://api.mycompany.com/v1/records",
    Limit = null,
    Offset = null,
    SelectColumns = null
];

// 2. The recursive View builder
View = (state as record) as table => Table.View(null, [
    
    // Define the schema of the table
    GetType = () => type table [ ID = Int64.Type, Name = text, Department = text ],
    
    // -----------------------------------------------------
    // Handlers: Update the state record when M functions are called
    // -----------------------------------------------------

    // Intercepts Table.FirstN() or Table.Range()
    OnTake = (count as number) => 
        // Return a NEW View, preserving existing state but updating Limit
        @View(state & [ Limit = count ]),
        
    // Intercepts Table.Skip() or Table.Range()
    OnSkip = (count as number) => 
        // Return a NEW View, preserving existing state but updating Offset
        @View(state & [ Offset = count ]),
        
    // Intercepts Table.SelectColumns()
    OnSelectColumns = (columns as list) =>
        @View(state & [ SelectColumns = columns ]),

    // -----------------------------------------------------
    // Execution: The engine asks for the actual data
    // -----------------------------------------------------
    GetRows = () => 
        let
            // 3. Build the Query String dynamically based on the final accumulated state
            QueryRecord = [] 
                // Add ?limit=X if OnTake was called
                & (if state[Limit] <> null then [ limit = Text.From(state[Limit]) ] else [])
                // Add &offset=Y if OnSkip was called
                & (if state[Offset] <> null then [ offset = Text.From(state[Offset]) ] else [])
                // Add &fields=A,B,C if OnSelectColumns was called
                & (if state[SelectColumns] <> null then [ fields = Text.Combine(state[SelectColumns], ",") ] else []),
                
            // 4. Execute the HTTP Request
            Response = Web.Contents(state[Url], [
                Query = QueryRecord
            ]),
            
            // 5. Parse JSON and convert to Table
            Json = Json.Document(Response),
            Tabled = Table.FromRecords(Json[data])
        in
            // If SelectColumns was used, ensure the final table schema matches the request
            if state[SelectColumns] <> null then 
                Table.SelectColumns(Tabled, state[SelectColumns]) 
            else 
                Tabled
]);
```

### How Power Query Executes This

If a user writes the following M code in the Power Query Editor:
```powerquery
Source = MyConnector.Contents(),
KeepSpecificColumns = Table.SelectColumns(Source, {"ID", "Name"}),
KeepBottomRows = Table.Skip(KeepSpecificColumns, 500),
KeepTopRows = Table.FirstN(KeepBottomRows, 100)
```

Without `Table.View`, Power Query would download *every single record* from your API, load them into memory, drop the "Department" column, throw away the first 500 rows, and keep the next 100. This is disastrous for performance.

With the `Table.View` proxy above:
1. `Table.SelectColumns` triggers `OnSelectColumns({"ID", "Name"})`. State is updated.
2. `Table.Skip` triggers `OnSkip(500)`. State is updated.
3. `Table.FirstN` triggers `OnTake(100)`. State is updated.
4. Finally, when the UI needs to render the preview, Power Query calls `GetRows()`.

`GetRows` reads the accumulated state and generates exactly one HTTP request:
`GET https://api.mycompany.com/v1/records?limit=100&offset=500&fields=ID,Name`

The remote server does all the heavy lifting, only returning the exact 100 rows requested. This is the definition of **Query Folding**.

### Advanced Implementations

In massive Enterprise connectors (like Databricks or Kusto), these handlers get exceptionally complex. For example, `OnSort` receives a list of sorting instructions that must be translated into `ORDER BY col ASC`, and `OnSelectRows` receives an Abstract Syntax Tree (AST) representing the `Table.SelectRows` filter criteria, which must be compiled recursively into an OData `$filter` or SQL `WHERE` clause strings.
