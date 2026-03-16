# Power Query Patterns: Writing Data (The `Action` Module)

Power Query is almost universally known as a **Read-Only** ETL tool. In Power BI and Excel, the M engine downloads data, transforms it, and loads it into a model.

However, Microsoft also uses the Power Query engine to power **Power Apps** and **Power Automate** connector integration. In these environments, connectors must be able to perform CRUD operations (Create, Read, Update, Delete) — they need to _write_ data back to the server.

To accomplish this, M uses the deeply undocumented `Action` and `TableAction` namespaces.

## 1. Direct Action Functions

If you are building a custom connector, you can expose explicit actions (like "Create User" or "Assign License") to Power Automate by defining your M functions with the `as action` return type.

Unlike standard lazy-evaluated M code, the `Action.Sequence` wrapper forces operations to execute in strict sequential order, which is mandatory for write operations.

### Implementation: Direct Actions

```powerquery
// 1. Define an Action function (note the distinct 'as action' syntax)
shared MyConnector.InsertData = (tableName as text, recordToInsert as record) as action =>
    let
        // 2. Define the payload
        payload = Json.FromValue(recordToInsert),

        // 3. Make the POST request
        response = Web.Contents("https://api.mycompany.com/v1/" & tableName, [
            Headers = [
                #"Content-Type" = "application/json",
                #"Authorization" = "Bearer " & Extension.CurrentCredential()[Key]
            ],
            Content = payload,
            ManualStatusHandling = {400, 403, 404, 500}
        ]),

        // 4. Check the metadata to ensure the POST fired correctly
        statusCode = Value.Metadata(response)[Response.Status]
    in
        if statusCode = 201 then
            // 5. Use Action.Return to explicitly return a success state to Power Apps
            Action.Return([
                Success = true,
                Message = "Record inserted successfully",
                InsertedId = Json.Document(response)[id]
            ])
        else
            Action.Return([
                Success = false,
                ErrorDetails = Text.FromBinary(response)
            ]);
```

### Advanced: `Action.Sequence` execution

If you need to perform multiple writeback operations in order (e.g., creating a user, then assigning them a license), Power Query might try to evaluate them in parallel due to lazy evaluation.

You must wrap the steps in `Action.Sequence` to enforce linearity:

```powerquery
shared MyConnector.ProvisionUser = (email as text) as action =>
    Action.Sequence({
        // Step 1: Create the User
        MyConnector.CreateUser(email),

        // Step 2: Extract the User ID from the result of Step 1 and assign a license
        (createUserResult) => MyConnector.AssignLicense(createUserResult[InsertedId]),

        // Step 3: Return the final status
        (assignLicenseResult) => Action.Return([
            UserId = assignLicenseResult[UserId],
            Provisioned = true
        ])
    });
```

---

## 2. Table.View Mutation Handlers

Instead of exposing explicit standalone functions, you can also natively intercept standard data table operations inside Power Automate (like the "Delete Row" or "Update Row" blocks) by overriding undocumented handlers inside your `Table.View` proxy.

When a Power Automate flow executes a "Create Row" step connected to your table connector, the M Engine routes that payload into the `OnInsertRows` handler.

### Implementation: `Table.View` Mutability

```powerquery
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
                    singleRow = Table.SingleRow(rowsToInsert),
                    payload = Json.FromValue(singleRow),

                    apiResponse = Web.Contents("https://api.mycompany.com/v1/users", [
                        Content = payload,
                        Headers = [#"Content-Type" = "application/json"]
                    ])
                in
                    // You MUST return an Action Sequence instructing the engine that the table was modified
                    Action.Sequence({
                        TableAction.InsertRows(BaseTable, rowsToInsert),
                        () => Action.Return(Json.Document(apiResponse)[id])
                    }),

            // -----------------------------------------------------------------
            // Handler for Power Automate "Delete Row"
            // -----------------------------------------------------------------
            OnDeleteRows = (selector as function) =>
                let
                    deletedTableSubset = Table.SelectRows(BaseTable, selector),
                    targetId = deletedTableSubset{0}[id],

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

## Security and Compliance constraints

> [!WARNING]  
> Actions (`Action.Return`, `Action.Sequence`, `TableAction.InsertRows`) are **strictly prohibited from executing during a standard dataset refresh in Power BI**.
>
> If a Power BI user tries to invoke `MyConnector.InsertData()` in the Power BI Desktop Query Editor, the engine will throw an `Expression.Error: The action can't be executed` compilation error. This pattern is exclusively intended for the Power Platform Integration stack (Power Apps/Automate).
