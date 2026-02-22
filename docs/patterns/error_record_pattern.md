# Power Query Patterns: Custom Error Handling (`Error.Record`)

When building a custom connector, exceptions will inevitably happen. An API might go down, a user might enter the wrong password, or a rate limit might be exceeded.

When this happens, you can easily crash the query using the `error` keyword:
```powerquery
if responseCode = 404 then error "The requested resource was not found"
```

However, if you do this, the Power Query Editor UI simply displays a generic `DataFormat.Error` or `Expression.Error` with your message appended to the end. It doesn't look professional, and it doesn't help users programmatically catch errors.

## The `Error.Record` Pattern

To throw a professional, structured error that correctly populates the yellow error bars in the Power Query UI (and can be intercepted by `try ... otherwise` logic), you must use `Error.Record`.

### Implementation

`Error.Record` accepts three arguments:
1. **Reason**: A short, programmatic string identifier for the error category.
2. **Message**: The human-readable explanation of what went wrong.
3. **Detail**: (Optional) A record or string containing debugging information.

```powerquery
shared MyConnector.FetchData = () =>
    let
        // 1. Fetch data and check the response code
        response = Web.Contents("https://api.mycompany.com/v1/data", [
            ManualStatusHandling = {400, 401, 403, 404, 429, 500}
        ]),
        
        // 2. Extract the response HTTP status code
        metadata = Value.Metadata(response),
        statusCode = metadata[Response.Status]?,
        
        // 3. Handle errors gracefully using Error.Record
        result = if statusCode = 200 then
            // Success
            Json.Document(response)
            
        else if statusCode = 401 or statusCode = 403 then
            // Authentication Failure
            error Error.Record(
                "DataSource.Error",
                "Access was denied. Please check your credentials and ensure your API key has the correct scopes.",
                [ HTTPStatus = statusCode ]
            )
            
        else if statusCode = 429 then
            // Rate Limit Exceeded
            error Error.Record(
                "DataSource.RateLimitExceeded",
                "The API rate limit was exceeded. Please wait a few minutes and try again.",
                [ 
                    HTTPStatus = 429,
                    RetryAfter = Web.ActionResponseHeaders(response)[#"Retry-After"]? 
                ]
            )
            
        else if statusCode = 500 then
            // Server Error
            error Error.Record(
                "DataSource.Error",
                "The remote server returned an internal error. Please contact support.",
                [ 
                    HTTPStatus = 500,
                    ServerMessage = Text.FromBinary(response)
                ]
            )
            
        else
            // Fallback for unknown errors
            error Error.Record(
                "Expression.Error",
                "An unexpected HTTP error occurred.",
                [ HTTPStatus = statusCode ]
            )
    in
        result;
```

### Why This Matters

When you throw an `Error.Record`:
1. The Power Query interface will read `Error.Record("DataSource.Error", ...)` and correctly display it as a **DataSource Error** in the UI, rather than a generic expression error.
2. If another query references your connector and uses a `try ... otherwise` block, they can inspect the error record using `[HasError]` and `[Error]`. 

```powerquery
let
    // 1. Attempt the call
    attempt = try MyConnector.FetchData(),
    
    // 2. Programmatically inspect the error if it failed
    finalResult = if attempt[HasError] and attempt[Error][Reason] = "DataSource.RateLimitExceeded" then
        // If it was a rate limit, automatically retry it
        MyConnector.FetchDataWithDelay()
    else if attempt[HasError] then
        // If it was any other error, crash
        error attempt[Error]
    else
        // Success
        attempt[Value]
in
    finalResult
```
