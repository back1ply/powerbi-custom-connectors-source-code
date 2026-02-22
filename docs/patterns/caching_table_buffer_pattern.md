# Power Query Patterns: Caching Data with `Table.Buffer`

Because Power Query's M engine evaluates code *lazily*, it will often re-evaluate a variable if it is referenced multiple times in a script.

When building dynamic Navigation Tables (see [Navigation Table Pattern](navigation_table_pattern.md)), a common scenario involves asking an API for a list of items (e.g., Projects), and then looping over that list to generate a child folder for each project.

If you don't explicitly cache that list of projects, Power Query might re-fire the `GET /projects` API call for *every single project in the list* as it builds the UI!

## The `Table.Buffer` Pattern

To force Power Query to evaluate an expression once, load it entirely into RAM, and never execute the source logic again for the duration of the query, you use a `Buffer` function.
- `Table.Buffer(table)`
- `List.Buffer(list)`
- `Binary.Buffer(binary)`

### Example: Navigation Table Optimization

```powerquery
shared MyConnector.Contents = () =>
    let
        // 1. Fetch the raw list of workspaces from the API
        // If we don't Buffer this, generating 50 workspace folders will cause 50 API calls to /workspaces
        rawWorkspaces = GetAllPages("https://api.mycompany.com/v1/workspaces"),
        
        // 2. Load the entire table into memory
        workspaces = Table.Buffer(rawWorkspaces),
        
        // 3. Build the root Navigation Table
        navTable = {
            [
                Name = "All Workspaces",
                Key = "All Workspaces",
                Data = CreateWorkspaceFolders(workspaces), // Pass the buffered table
                ItemKind = "Folder",
                ItemName = "Folder",
                IsLeaf = false
            ]
        }
    in
        Table.ToNavigationTable(Table.FromRecords(navTable), {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf");


CreateWorkspaceFolders = (workspaces as table) as table =>
    let
        // Because "workspaces" is Buffered, this iteration is instant and causes 0 network traffic
        GenerateRow = (row) => [
            Name = row[WorkspaceName],
            Key = row[WorkspaceId],
            Data = GetWorkspaceData(row[WorkspaceId]), // Only fires when the user clicks the specific folder
            ItemKind = "Table",
            ItemName = "Table",
            IsLeaf = true
        ],
        rows = Table.TransformRows(workspaces, GenerateRow),
        asTable = Table.FromRecords(rows)
    in
        Table.ToNavigationTable(asTable, {"Key"}, "Name", "Data", "ItemKind", "ItemName", "IsLeaf");
```

### When to use `Binary.Buffer`

When dealing with large file downloads or OAuth2 token requests, you should wrap the `Web.Contents` call in `Binary.Buffer`. 

```powerquery
let
    // 1. Send the POST Request to get the token, but force it into RAM immediately.
    // If you don't Buffer this, parsing the JSON might cause Power Query to fire the POST request twice!
    tokenResponse = Binary.Buffer(Web.Contents("https://api.oauth.com/token", [
        Content = Text.ToBinary("grant_type=client_credentials")
    ])),
    
    // 2. Safely parse the buffered byte array
    json = Json.Document(tokenResponse)
in
    json[access_token]
```

### Warning

Never use `Table.Buffer` on the *final* actual data table being loaded into the Power BI Data Model. Buffering millions of rows of data inside Power Query will crash the Power BI Desktop application due to Out Of Memory (OOM) errors. 

Only use `Table.Buffer` for small configuration tables, metadata lists, or Navigation Table hierarchies.
