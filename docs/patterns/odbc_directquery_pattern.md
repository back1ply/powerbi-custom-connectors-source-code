# Power Query Patterns: ODBC & DirectQuery Mapping

For enterprise databases and data warehouses (e.g., Snowflake, Databricks, BigQuery), pulling millions of rows into Power BI's memory (Import Mode) is often impossible or impractical. 

These connectors instead rely on **DirectQuery**, which pushes the data processing back to the source server. When a Power BI user drags a column into a visual, Power BI generates a SQL query and sends it to the source.

To achieve this in a custom connector, you do not use `Web.Contents()`. Instead, you use the underlying `Odbc.DataSource()` function.

## The `Odbc.DataSource` Pattern

Power BI's M engine has a built-in SQL translator. When you pass an ODBC connection string into `Odbc.DataSource`, the M engine automatically begins converting M functions (`Table.SelectRows`, `Table.AddColumn`) into backend SQL (`WHERE`, `SELECT`, `GROUP BY`). This process is called **Query Folding**.

### 1. Basic ODBC Implementation

The simplest ODBC connector just provides the DSN (Data Source Name) or Connection String to the native ODBC driver installed on the user's machine.

```powerquery
[DataSource.Kind="MyDatabase", Publish="MyDatabase.Publish"]
shared MyDatabase.Contents = (server as text, database as text) =>
    let
        // Build the connection string expected by the user's installed ODBC Driver
        ConnectionString = [
            Driver = "{My Custom ODBC Driver}",
            Server = server,
            Database = database
        ],
        
        // Pass it to the M Engine's native ODBC handler
        OdbcDatasource = Odbc.DataSource(ConnectionString)
    in
        OdbcDatasource;
```

### 2. SQL Capabilities (`SqlCapabilities`)

Not all databases support every SQL feature. What if your database doesn't support the `LIMIT` or `TOP` clause, or uses different syntax for string concatenation? 

You must define a `SqlCapabilities` record to tell the Power Query M Engine *how* to write SQL for your specific database flavor.

```powerquery
OdbcOptions = [
    // Define the exact limits of your backend SQL engine
    SqlCapabilities = [
        // Does your DB support "SELECT TOP 10"?
        SupportsTop = true,
        // Does your DB support filtering strings using LIKE?
        SupportsStringLiterals = true, 
        // Can your DB do math natively?
        SupportsNumericLiterals = true,
        // E.g. Databricks might not support certain outer joins
        FractionalSecondsScale = 3
    ]
];

OdbcDatasource = Odbc.DataSource(ConnectionString, OdbcOptions);
```

### 3. The `AstVisitor` (Advanced DirectQuery)

The most advanced feature of `Odbc.DataSource` is the Abstract Syntax Tree (AST) Visitor. If a user writes an M formula like `Text.Upper([Name])`, Power Query needs to know what SQL function matches that. 

Is it `UCASE(Name)` or `UPPER(Name)`?

The `AstVisitor` allows you to define exactly how M functions compile into SQL strings.

```powerquery
// Example from the Databricks/Snowflake connectors
AstVisitor = [
    // How do we compile Math operations?
    Constant =
        let
            Quote = each "'" & Text.Replace(_, "'", "''") & "'"
        in
            [
                // If M sees a text string, wrap it in single quotes for SQL
                type text = Quote
            ],

    // How do we map M Functions to SQL Functions?
    Record.Field = [
        // M Function -> SQL Function equivalent
        Text.Upper = (str) => "UPPER(" & str & ")",
        Text.Lower = (str) => "LOWER(" & str & ")",
        Text.Length = (str) => "LEN(" & str & ")",
        DateTime.LocalNow = () => "CURRENT_TIMESTAMP()"
    ]
];

OdbcOptions = [
    SqlCapabilities = [...],
    AstVisitor = [
        Constant = AstVisitor[Constant],
        Record.Field = AstVisitor[Record.Field]
    ]
];

OdbcDatasource = Odbc.DataSource(ConnectionString, OdbcOptions);
```

### Summary
If you are connecting to a REST API, you use `Web.Contents()` (Import Mode only). 
If you are connecting to a Database and want DirectQuery support, you must build an ODBC Driver (in C/C++) and then write a Power Query Connector that uses `Odbc.DataSource()` and the `AstVisitor` to map M code to your database's specific SQL dialect.
