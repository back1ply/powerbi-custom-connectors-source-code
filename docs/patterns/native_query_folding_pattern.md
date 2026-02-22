# Power Query Patterns: Custom SQL & Native Query Folding

When building a custom connector that wraps an SQL Database (using ODBC, ADO.NET, or OLE DB), users often want the ability to paste raw SQL queries into the "Get Data" dialog instead of using the graphical Navigation Table.

For example, a user might want to write:
`SELECT id, name FROM employees WHERE department = 'Sales'`

Power Query supports this natively via the `Value.NativeQuery` function.

## The `Value.NativeQuery` Pattern

If you simply execute `Odbc.Query(connectionString, query)`, Power Query will download the data, but **Query Folding will be broken**. If the user subsequently clicks "Keep Top 10 Rows" in the Power Query UI, M will download all 1,000,000 rows from the database to their laptop, and *then* take the top 10.

To securely pass custom SQL while allowing Power Query to append its own SQL operators (like `LIMIT 10`) onto the end of the user's query, you must use `Value.NativeQuery` with `EnableFolding = true`.

### Implementation

This pattern demonstrates how to intercept a user's custom SQL string and pass it to the underlying ODBC driver.

```powerquery
shared MyDatabaseConnector.Contents = (server as text, optional customSql as text) =>
    let
        // 1. Establish the base ODBC connection
        connectionString = [
            Driver = "MyCustomDriver",
            Server = server
        ],
        // Odbc.DataSource returns the full Database Navigation Table
        baseNavTable = Odbc.DataSource(connectionString, [HideNativeQuery = false]),
        
        // 2. Check if the user provided custom SQL
        result = if customSql = null or customSql = "" then
            // No custom SQL? Just return the visual navigation table
            baseNavTable
        else
            // 3. User provided SQL. Apply Value.NativeQuery onto the Nav Table.
            let
                // M requires parameters to be formatted as a list or record depending on the driver.
                // For basic usage without parameters, pass null.
                parameters = null,
                
                // CRITICAL: You must explicitly enable folding, or the NativeQuery will break subsequent M steps.
                options = [
                    EnableFolding = true
                ],
                
                // 4. Execute the query
                nativeData = Value.NativeQuery(baseNavTable, customSql, parameters, options)
            in
                nativeData
    in
        result;
```

### Important Considerations

1. **`HideNativeQuery = false`**: When you call `Odbc.DataSource`, you must explicitly tell the driver *not* to hide native query capabilities.
2. **Semicolons**: Users often paste SQL queries that end with a semicolon (`;`). `Value.NativeQuery` essentially takes the user's SQL and wraps it in a subquery: `SELECT TOP 10 * FROM (user_query) as x`. If the user's query has a semicolon at the end, the generated SQL will be `SELECT TOP 10 * FROM (SELECT * FROM table;) as x`, which is invalid SQL syntax and will crash.
   - *Best Practice*: Always write a small text manipulation step to strip trailing semicolons from `customSql` before passing it to `Value.NativeQuery`.
