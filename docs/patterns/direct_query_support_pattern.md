# Power Query Patterns: Enabling DirectQuery

When you connect to an API using `Web.Contents` or a database using `Odbc.DataSource`, Power Query defaults to **Import Mode**. 
This means that when a user builds a dashboard, the M engine downloads the entire dataset into the Power BI `.pbix` file's memory. When the user clicks a slicer, Power BI filters the memory model.

For massive datasets (Terabytes of SQL data) or data that must be real-time, importing is impossible. You must use **DirectQuery**.

DirectQuery prevents data from being downloaded. Instead, every time a user clicks a visual, Power BI translates the DAX visual query into an M query, folds it, and pushes it directly to the source database as an active query.

## The `SupportsDirectQuery` Pattern

DirectQuery is typically only supported for connectors that wrap native SQL drivers (e.g., `Odbc.DataSource`, `Sql.Database`).

To enable it, you must add `SupportsDirectQuery = true` to the connector's Publish record.

### Implementation

```powerquery
// 1. The Main Connector Entry Point
[DataSource.Kind="MyDatabase", Publish="MyDatabase.Publish"]
shared MyDatabase.Contents = (server as text, database as text) =>
    let
        // Use an ODBC driver. ODBC natively supports query folding,
        // which is a hard requirement for DirectQuery to work.
        source = Odbc.DataSource("Driver={My SQL Driver};Server=" & server & ";Database=" & database, [
            HierarchicalNavigation = true
        ])
    in
        source;

// 2. The Publish Record
MyDatabase.Publish = [
    Beta = true,
    Category = "Database",
    ButtonText = { "My Database", "Connect to My Database" },
    LearnMoreUrl = "https://docs.mycompany.com",
    SourceImage = MyDatabase.Icons,
    SourceTypeImage = MyDatabase.Icons,
    
    // ** CRITICAL PATTERN **
    // Enabling this toggle allows users to select the "DirectQuery" radio button in the Get Data UI
    SupportsDirectQuery = true
];
```

### Gateway Real-Time Networking (`TestConnection`)

If a connector is published to the Power BI Service in DirectQuery mode, it requires an Enterprise Gateway to physically proxy the live SQL queries from the Cloud to your on-premises database.

To ensure the Gateway can keep a live, persistent heartbeat with your server, you *must* provide a `TestConnection` handler in your `DataSource.Kind` record.

```powerquery
MyDatabase = [
    // Provide a TestConnection function so the Gateway knows how to ping the database
    TestConnection = (dataSourcePath) => 
        let
            // The dataSourcePath is a JSON string containing the parameters passed to your entry point.
            // Parse it to extract the server and database.
            json = Json.Document(dataSourcePath),
            server = json[server],
            database = json[database]
        in
            // Return the name of your entry point and its parameters.
            // Power BI will periodically execute this to verify the database is online.
            { "MyDatabase.Contents", server, database },
            
    Authentication = [
        UsernamePassword = []
    ],
    Label = "My Custom Database Connector"
];
```

### Note on REST APIs
You generally **cannot** enable DirectQuery for REST APIs (`Web.Contents`). REST APIs do not support dynamic SQL aggregation (e.g., `SELECT SUM(sales) GROUP BY region`). If you attempt to force `SupportsDirectQuery = true` on a REST API connector, it will fail certification, as the engine will attempt to natively fold queries the API cannot handle.
