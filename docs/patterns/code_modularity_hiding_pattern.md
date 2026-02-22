# Power Query Patterns: Code Modularity & Hiding Proprietary Logic

In a standard custom connector, all M code is placed within a single file (usually `Connector.pq`). 

When a user installs your connector (`.mez` or `.pqx` file) and connects to it in Power BI Desktop, they could right-click the queries, open the **Advanced Editor**, and see the M code that generated the query.

For enterprise developers building complex connectors, a 10,000-line `Connector.pq` file is unmaintainable. Furthermore, they may wish to hide proprietary data transformation logic or complex pagination engines from end-users.

## The `Extension.Contents` Pattern

You can split your M code into multiple files (typically using the `.pqm` extension — Power Query Module), bundle them inside your connector's zip archive, and evaluate them dynamically at runtime.

Because these helper files are evaluated entirely within the engine's background execution context, their contents will **never appear in the Power Query Advanced Editor UI**.

### 1. Creating Helper Modules

Instead of writing `Table.GenerateByPage` directly into `MyConnector.pq`, create a new file named `Table.GenerateByPage.pqm` in your project folder:

**`Table.GenerateByPage.pqm`**:
```powerquery
// Notice we don't need a "shared" or "section" declaration here.
// This file just evaluates to a single function expression.
(getNextPage as function) as table =>
    let
        listOfPages = List.Generate(
            () => getNextPage(null),
            (lastPage) => lastPage <> null,
            (lastPage) => getNextPage(lastPage)
        ),
        tableOfPages = Table.FromList(listOfPages, Splitter.SplitByNothing(), {"Column1"})
    in
        if Table.IsEmpty(tableOfPages) then 
            #table({"Column1"}, {}) 
        else 
            Table.ExpandTableColumn(tableOfPages, "Column1", Table.ColumnNames(tableOfPages{0}[Column1]))
```

### 2. Dynamically Evaluating Modules

In your main `MyConnector.pq` file, use `Extension.Contents` to read the raw bytes of the module file from the zip archive, convert it to text, and execute it using `Expression.Evaluate`.

**`MyConnector.pq`**:
```powerquery
section MyConnector;

// 1. Define a helper function to load and execute any file bundled in the extension
LoadHelper = (fileName as text) as any =>
    let
        // Read the binary file from the .mez/.pqx zip archive
        fileBinary = Extension.Contents(fileName),
        
        // Convert the binary to an M-readable text string
        fileText = Text.FromBinary(fileBinary),
        
        // Dynamically compile and execute the string using the global #shared context
        evaluatedExpression = Expression.Evaluate(fileText, #shared)
    in
        evaluatedExpression;

// 2. Load your proprietary logic into a local scope variable
Table.GenerateByPage = LoadHelper("Table.GenerateByPage.pqm");
Diagnostics.Trace = LoadHelper("Diagnostics.pqm");
OAuth.GetToken = LoadHelper("OAuth2.pqm");

// 3. Your connector logic is now clean, modular, and safely obfuscated
[DataSource.Kind="MyConnector", Publish="MyConnector.Publish"]
shared MyConnector.Contents = () =>
    let
        source = Table.GenerateByPage( (previous) => Web.Contents("https://api.mycompany.com") )
    in
        source;
```

### Benefits of this Pattern:

1. **Reusability**: You can drop the exact same `Diagnostics.pqm` and `Table.GenerateByPage.pqm` files into 50 different connector projects without altering the main codebase.
2. **Obfuscation**: Users clicking through the Power Query graphic interface will see `MyConnector.Contents()` in the formula bar, but the complex logic inside the `.pqm` modules is hidden from the Advanced Editor.
3. **Manageability**: Massive enterprise REST APIs can have hundreds of endpoints. By breaking the connector down into `/modules/Projects.pqm`, `/modules/Users.pqm`, etc., version control and team collaboration become significantly easier.
