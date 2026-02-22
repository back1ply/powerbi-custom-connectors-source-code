# Power Query Patterns: The `Formula.Firewall` & Dynamic Data Sources

This is arguably the single most important pattern in custom connector development.

If you have ever built a custom function in Power Query that takes a parameter and inserts it into a URL, you have likely encountered the **Dynamic Data Source** error:

`Formula.Firewall: Query 'MyQuery' (step 'Source') references other queries or steps, so it may not directly access a data source. Please rebuild this data combination.`

Alternatively, the connector might work perfectly in Power BI Desktop, but when you publish it to the Power BI Service, it throws:

`This dataset includes a dynamic data source. Since dynamic data sources aren't refreshed in the Power BI service, this dataset won't be refreshed.`

## Why Does This Happen?

To ensure data privacy and prevent a malicious query from sending your confidential HR database records to an external URL, the Power Query engine performs a **Static Code Analysis** before executing any M code. 

It attempts to discover the Base URL of every `Web.Contents` call.

If you write this:
```powerquery
// ANTI-PATTERN: String Concatenation 
let
    userId = "12345",
    response = Web.Contents("https://api.mycompany.com/v1/users/" & userId)
in ...
```
The static analyzer looks at `"https://api.mycompany.com/v1/users/" & userId` and determines that the URL is *dynamic*. Because it cannot guarantee what the URL is going to be without actually running the code, it completely blocks the execution in the Cloud to prevent data leakage.

## The `RelativePath` and `Query` Pattern

To fix this, you must **never** concatenate URL strings in a custom connector.

Instead, you must provide a hardcoded Base URL as the first argument to `Web.Contents`. Power Query will authorize this safe Base URL during the static analysis phase. 

Then, you pass the dynamic portions of the URL to the `RelativePath` and `Query` arguments inside the options record. 

### Implementation

```powerquery
shared MyConnector.GetUser = (userId as text, optional includeInactive as logical) =>
    let
        // 1. Establish the STATIC Base URL. 
        // This is safe and will pass the Formula.Firewall check.
        baseUrl = "https://api.mycompany.com",
        
        // 2. Define the dynamic URL path parameters
        // Example: /v1/users/12345
        dynamicPath = "v1/users/" & userId,
        
        // 3. Define the dynamic URL query parameters
        // Example: ?includeInactive=true
        dynamicQuery = [
            includeInactive = if includeInactive = true then "true" else "false"
        ],
        
        // 4. Pass the dynamic chunks into the Web.Contents options record
        response = Web.Contents(baseUrl, [
            RelativePath = dynamicPath,
            Query = dynamicQuery,
            Headers = [
                #"Authorization" = "Bearer " & Extension.CurrentCredential()[Key]
            ]
        ])
    in
        Json.Document(response);
```

### How the Engine Handles It

When the static analyzer runs over this code, it sees `Web.Contents("https://api.mycompany.com")`. It approves the connection. 

At execution time, the engine automatically handles the URL encoding and seamlessly combines the Base URL, `RelativePath`, and `Query` record into the final outbound request:
`GET https://api.mycompany.com/v1/users/12345?includeInactive=true`

If you implement this correctly, your custom connector will successfully bypass the `Formula.Firewall` and seamlessly refresh in the Power BI Service!
