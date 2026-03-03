# Power Query Patterns: Mutable Actions and Writeback (Power Platform)

Power Query is traditionally recognized as a strictly read-only Extraction and Transformation engine. In Power BI Desktop and the Power BI Service, it is impossible for an end user to interact via M code to execute HTTP POST, PUT, or DELETE commands that mutate the underlying data source.

However, Custom Connectors written in the M Language aren't just for Power BI. They are the underlying integration fabric for the entire Microsoft Power Platform—including **Power Apps** and **Power Automate (Flow)**.

In Power Apps and Power Automate, data sources **can be mutated**. By implementing an undocumented subset of `Table.View` handlers, your custom connector can expose standard Insert, Update, and Delete operations to flow builders.

## The Action Framework

To enable writeback, M provides the `Action` and `TableAction` namespaces. These functions do not evaluate to data; they evaluate to deferred side effects that the Power Platform engine executes natively.

*   `Action.Return(value)`: Returns a scalar value after an action.
*   `Action.Sequence({ actions })`: Executes multiple actions in order.
*   `Action.DoNothing`: A no-op action, required for conditional logic.
*   `TableAction.InsertRows(table, rows)`: Instructs the engine to perform an insertion payload.
*   `TableAction.UpdateRows(table, updates)`: Instructs the engine to perform an update payload.
*   `TableAction.DeleteRows(table)`: Instructs the engine to delete a filtered table set.
*   `ValueAction.Replace(target, new_value)`: Instructs the engine to replace a resource entirely.

## Implementing Mutability in `Table.View`

To expose this capability to Power Automate, you must intercept the row manipulation lifecycle within your `Table.View` proxy. 

When a Power Automate flow executes a "Create Row" step connected to your custom connector, the M Engine natively routes that payload into the `OnInsertRows` handler of your `Table.View`.

```powerquery
// Example: Exposing a mutable SQL/API Endpoint to Power Apps
GetMutableUsersTable = () =>
    let
        Source = Json.Document(Web.Contents("https://api.mycompany.com/v1/users")),
        BaseTable = Table.FromRecords(Source),
        
        MutableView = Table.View(BaseTable, [
        
            // -----------------------------------------------------------------
            // Handler for Power Automate "Insert Row"
            // -----------------------------------------------------------------
            OnInsertRows = (rowsToInsert as table) =>
                let
                    // 1. You receive a table containing the new records to insert
                    singleRow = Table.SingleRow(rowsToInsert),
                    
                    // 2. You build the API payload
                    payload = Json.FromValue(singleRow),
                    
                    // 3. You can execute side-effects via Web.Contents (POST)
                    apiResponse = Web.Contents("https://api.mycompany.com/v1/users", [
                        Content = payload,
                        Headers = [#"Content-Type" = "application/json"]
                    ])
                in
                    // 4. You MUST return an Action type instructing the UI that the table was modified
                    Action.Sequence({
                        // Fake a successful sync to the local engine representation
                        TableAction.InsertRows(BaseTable, rowsToInsert),
                        // Return the new ID so Power Automate can parse the output
                        () => Action.Return(Json.Document(apiResponse)[id]) 
                    }),

            // -----------------------------------------------------------------
            // Handler for Power Automate "Update Row"
            // -----------------------------------------------------------------
            OnUpdateRows = (updates as list, selector as function) =>
                let
                    // 'selector' identifies which rows to update based on the UI context
                    updatedTableSubset = Table.SelectRows(BaseTable, selector),
                    
                    // We extract the Target ID from the selected row
                    targetId = updatedTableSubset{0}[id],
                    
                    // 'updates' contains the list of { [Name="Column", Function=each newValue] }
                    // You must translate these into a PATCH body for your API
                    apiResponse = Web.Contents("https://api.mycompany.com/v1/users/" & Text.From(targetId), [
                        Content = BuildPatchBody(updates),
                        Headers = [#"Content-Type" = "application/json"],
                        // Use PATCH or PUT depending on your API
                        // Since Web.Contents defaults to POST when Content is provided, you might need ManualStatusHandling
                        ManualStatusHandling = {200}
                    ])
                in
                    Action.Sequence({
                        TableAction.UpdateRows(updatedTableSubset, updates)
                    }),

            // -----------------------------------------------------------------
            // Handler for Power Automate "Delete Row"
            // -----------------------------------------------------------------
            OnDeleteRows = (selector as function) =>
                let
                    deletedTableSubset = Table.SelectRows(BaseTable, selector),
                    targetId = deletedTableSubset{0}[id],
                    
                    // M allows DELETE methods easily if Content is omitted 
                    // However, standard API calls may require undocumented HTTPMethod overwrites 
                    // which is restricted in Custom Connectors without Special permissions
                    apiResponse = Web.Contents("https://api.mycompany.com/v1/users/" & Text.From(targetId) & "/delete", [
                        Content = Text.ToBinary("")
                    ])
                in
                    Action.Sequence({
                        TableAction.DeleteRows(deletedTableSubset)
                    })
        ])
    in
        MutableView;
```

## Security and Compliance

> [!WARNING]  
> If you implement `Action.*` handlers, evaluating this table in Power BI Desktop **will throw an error if the user attempts to trigger an action**, because Power BI is a strictly read-only analytical tool.
>
> Your connector will only execute these Side-Effects correctly when running inside the **Power Platform Dataflows** execution context, or natively in **Power Automate**.

### Real-World Example: Microsoft LakeHouse Connector

Microsoft's `LakeHouse.pq` custom connector heavily relies on `Action.Sequence` and `TableAction.*` to allow Power Platform Dataflows and Fabric environments to write Parquet payloads natively into Azure Data Lake (OneLake) storage bypassing the standard Power BI dataset layer.

```powerquery
OnDeleteRows = (selector) => 
    Action.Sequence({ 
        cacheTableInsertAction, 
        TableAction.DeleteRows(Table.SelectRows(content, selector)) 
    })
```
