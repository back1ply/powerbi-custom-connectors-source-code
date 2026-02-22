# Power Query Patterns: Global Custom Headers & User-Agent

When building a REST API connector, it is highly recommended (and sometimes required by the API provider) to send a custom `User-Agent` header so they can identify your integration's traffic. You may also need to send standard `Accept: application/json` or custom `X-Api-Version: 2.0` headers on every single request.

Instead of typing these headers manually into every `Web.Contents` call scattered throughout your codebase, certified connectors define a global `DefaultRequestHeaders` record.

## The Global Headers Pattern

### 1. Define the Global Header Record

At the top of your `MyConnector.pq` file (outside of any specific function), define your headers as a global record.

```powerquery
// Define the connector version (often pulled from a build script, but hardcoded here)
ConnectorVersion = "1.0.0";

// Define the global headers
DefaultRequestHeaders = [
    #"User-Agent" = "PowerBI-MyConnector/" & ConnectorVersion,
    #"Accept"     = "application/json",
    #"X-Api-Version" = "2024-01-01"
];
```

### 2. Merge Headers Dynamically

When you eventually call `Web.Contents()`, you usually need to pass dynamic headers as well (like an `Authorization` Bearer token).

You cannot just pass two header records into `Web.Contents`. You must merge them using `Record.Combine`.

```powerquery
shared MyConnector.Contents = () =>
    let
        // Get the dynamic token
        token = Extension.CurrentCredential()[Key],
        
        // Combine our Global Headers with our Request-Specific Headers
        mergedHeaders = Record.Combine({
            DefaultRequestHeaders,
            [ #"Authorization" = "Bearer " & token ]
        }),

        // Pass the merged record to Web.Contents
        source = Web.Contents("https://api.mycompany.com", [
            RelativePath = "v1/users",
            Headers = mergedHeaders
        ]),
        json = Json.Document(source)
    in
        json;
```

### 3. Overriding Global Headers

What if one specific API endpoint requires `Accept: text/csv` instead of `application/json`? `Record.Combine` processes items from left to right. If there are duplicate field names, the *right-most* one wins.

```powerquery
let
    // Global:    Accept = application/json
    // Specific:  Accept = text/csv
    
    mergedHeaders = Record.Combine({
        DefaultRequestHeaders,
        [ 
            #"Authorization" = "Bearer " & token,
            #"Accept" = "text/csv" // This overrides the JSON default!
        ]
    })
in
    // ...
```
