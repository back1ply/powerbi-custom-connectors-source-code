# Power Query Patterns: Writing Data (The `Action` Module)

Power Query is almost universally known as a **Read-Only** ETL tool. In Power BI and Excel, the M engine downloads data, transforms it, and loads it into a model.

However, Microsoft also uses the Power Query engine to power **Power Apps** and **Power Automate** connectors. In these environments, connectors must be able to perform CRUD operations (Create, Read, Update, Delete) — they need to *write* data back to the server.

To accomplish this, M uses the deeply undocumented `Action` module. 

## The `Action.Return` and `TableAction.InsertRows` Pattern

If you inspect the Microsoft LakeHouse connector, you will find code that executes sequential actions, checks the API response, and explicitly returns success or failure.

Unlike standard lazy-evaluated M code, `Action.Sequence` forces operations to execute in strict sequential order.

### Implementation

If you are building a custom connector specifically for Power Apps or Power Automate that allows a user to POST a new row to an API, you must define an `Action` function.

```powerquery
// 1. Define an Action function (note the distinct syntax compared to standard data retrieval)
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
                Message = "Database rejected the insertion",
                ErrorDetails = Text.FromBinary(response)
            ]);
```

### Advanced: `Action.Sequence`

If you need to perform multiple writeback operations in order (e.g., creating a user, then assigning them a license), you cannot rely on M's normal lazy evaluation because Power Query might try to assign the license before the user is fully created.

You must wrap the steps in `Action.Sequence`:

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

### Warning

Actions (`Action.Return`, `Action.Sequence`, `TableAction.InsertRows`) are **strictly prohibited from executing during a standard dataset refresh in Power BI**. If a Power BI user tries to invoke `MyConnector.InsertData()` in the Power Query Editor, the engine will throw an `Expression.Error: The action can't be executed` error. This pattern is exclusively for the Power Platform (Power Apps/Automate).
