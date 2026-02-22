# Power Query Patterns: TestConnection (Scheduled Refresh)

When you deploy a custom connector to the Power BI Service via an On-Premises Data Gateway, users can configure Scheduled Refresh. However, before the Gateway stores the user's credentials, it must verify them.

If your connector does not implement the `TestConnection` property in the `[DataSource.Kind]` record, **Scheduled Refresh will be completely disabled in the Power BI Service.**

## The `TestConnection` Property

The `TestConnection` handler expects you to return a `list` containing:
1. The name of the function to execute (as a text string)
2. Any arguments to pass to that function

The Gateway takes this list, executes the function with the arguments using the provided credentials, and if it returns *anything* without blowing up with an error, the connection is marked as "Successful".

### Standard Implementation

In 90% of cases, the simplest implementation is just to call your main `Contents` function with the `dataSourcePath` (which is typically the base URL or Server Name the user entered).

```powerquery
// 1. Your main Data Access function
[DataSource.Kind="MyConnector", Publish="MyConnector.Publish"]
shared MyConnector.Contents = (url as text) =>
    let
        source = Web.Contents(url, [RelativePath="api/v1/ping"]),
        json = Json.Document(source)
    in
        json;

// 2. The Data Source Kind definition
MyConnector = [
    // This tells the Gateway: "Execute MyConnector.Contents(dataSourcePath) to test credentials"
    TestConnection = (dataSourcePath) => { "MyConnector.Contents", dataSourcePath },
    
    Authentication = [
        Key = []
    ],
    Label = "My Custom API"
];
```

### Advanced Implementation (Fast Ping)

If your main `MyConnector.Contents` function pulls down 10GB of data, you *do not* want the Gateway doing that just to test a password. In that case, you define a hidden "ping" function specifically for testing.

```powerquery
// A fast, lightweight function just to verify credentials (e.g. fetching user profile)
MyConnector.Ping = (url as text) =>
    let
        source = Web.Contents(url, [RelativePath="api/v1/me"]),
        json = Json.Document(source)
    in
        json[id]; // Returns true/false or an ID

MyConnector = [
    // The gateway now executes MyConnector.Ping instead of pulling down the whole database
    TestConnection = (dataSourcePath) => { "MyConnector.Ping", dataSourcePath },
    
    Authentication = [
        Key = []
    ]
];
```

### JSON Data Source Paths

If your connector takes multiple arguments (e.g., `Server` and `Database`), Power Query serializes them into a JSON string called the `dataSourcePath`. You must parse it in `TestConnection`.

```powerquery
shared Sql.Database = (server as text, database as text) => ...

Sql = [
    TestConnection = (dataSourcePath) => 
        let
            json = Json.Document(dataSourcePath),
            server = json[server],
            database = json[database]
        in
            { "Sql.Database", server, database }
];
```
