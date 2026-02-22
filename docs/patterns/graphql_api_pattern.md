# Power Query Patterns: Connecting to GraphQL APIs

While most Power BI custom connectors wrap REST APIs, an increasing number of modern SaaS platforms exclusively offer GraphQL endpoints. 

Unlike REST, where you `GET` from different URLs (`/users`, `/projects`), GraphQL requires you to send an HTTP `POST` request to a single endpoint (e.g., `/graphql`), with the query defining the shape of the data you want returned.

## The GraphQL POST Pattern

To send a GraphQL query in Power Query, you must format the query as a JSON string, encode it into a binary payload using `Text.ToBinary(Json.FromValue())`, and pass it to the `Content` property of `Web.Contents`.

### 1. Basic Implementation

This pattern demonstrates how to execute a GraphQL query and parse the nested `data` response.

```powerquery
shared MyConnector.GetGraphQLData = () =>
    let
        // 1. Define your GraphQL Query string
        // Note: You must escape internal quotes, or use single quotes if the API allows it
        graphqlQuery = "{
            users(first: 100) {
                edges {
                    node {
                        id
                        name
                        email
                    }
                }
            }
        }",
        
        // 2. Wrap the query in a JSON record matching the GraphQL spec
        payload = [
            query = graphqlQuery,
            variables = [] // Optional: Include if your query uses $variables
        ],
        
        // 3. Send the POST request to the single /graphql endpoint
        response = Web.Contents("https://api.mycompany.com/graphql", [
            Headers = [
                #"Content-Type" = "application/json",
                #"Authorization" = "Bearer " & Extension.CurrentCredential()[Key]
            ],
            // Serializing a record to JSON and then to Binary forces Web.Contents into POST mode
            Content = Text.ToBinary(Json.FromValue(payload)),
            // Don't crash on 400s (allows us to read GraphQL syntax errors)
            ManualStatusHandling = {400, 500} 
        ]),
        
        // 4. Parse the response
        json = Json.Document(response),
        
        // 5. Check for GraphQL-specific errors (GraphQL often returns 200 OK even if the query failed!)
        result = if Record.HasFields(json, "errors") then
            error Error.Record("DataSource.Error", "GraphQL Error: " & json[errors]{0}[message])
        else
            // Extract the actual data from the deeply nested GraphQL structure
            json[data][users][edges]
    in
        result;
```

### 2. Handling GraphQL Pagination (Cursors)

GraphQL almost always uses cursor-based pagination. You must extract the `endCursor` from `pageInfo` and pass it into the `variables` record of the next request.

You integrate this with the standard `Table.GenerateByPage` pattern:

```powerquery
let
    // ... inside Table.GenerateByPage loop ...
    
    currentCursor = if (previous = null) then null else Value.Metadata(previous)[NextCursor]?,
    
    graphqlQuery = "
        query GetUsers($afterCursor: String) {
            users(first: 100, after: $afterCursor) {
                pageInfo {
                    hasNextPage
                    endCursor
                }
                edges {
                    node { id name }
                }
            }
        }",
        
    payload = [
        query = graphqlQuery,
        variables = [
            afterCursor = currentCursor // Inject the cursor here
        ]
    ]
    
    // ... perform Web.Contents ...
```

### Advanced: Modular GraphQL Queries
If your connector queries many different GraphQL nodes, do not copy/paste the `Web.Contents` logic. Create a helper function `MakeGraphQLRequest(query as text, optional variables as record)` that handles the JSON serialization, authentication, and error checking, so your main code only focuses on the query strings.
