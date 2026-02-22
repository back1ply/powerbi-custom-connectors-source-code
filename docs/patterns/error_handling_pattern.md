# Power Query Patterns: Graceful Error Handling

When using `Web.Contents`, Power Query expects the server to return an HTTP status code between 200 and 299. If the server returns *anything* else (e.g., 400 Bad Request, 401 Unauthorized, 500 Internal Server Error), Power Query terminates execution immediately and throws a fatal `DataSource.Error`.

The problem? Most modern APIs return a helpful JSON payload explaining *why* the error happened (e.g., `{"error": "Invalid date format for parameter 'start_date'"}`). If Power Query crashes instantly, the user never sees this helpful message.

## The `ManualStatusHandling` Pattern

To gracefully handle errors, we tell `Web.Contents` *not* to crash on specific HTTP codes. We then inspect the status code ourselves, parse the JSON error body, and throw a custom M exception so the user sees the real reason for the failure.

### 1. Basic Implementation

Pass a list of HTTP status codes you want to handle manually into the `ManualStatusHandling` option of `Web.Contents`.

```powerquery
shared MyConnector.Contents = () =>
    let
        // 1. Tell Web.Contents to return the body even if it's a 400, 404, or 500 error
        source = Web.Contents("https://api.mycompany.com/v1/data", [
            ManualStatusHandling = {400, 404, 500}
        ]),
        
        // 2. Extract the HTTP Response Status from the metadata
        metadata = Value.Metadata(source),
        responseCode = metadata[Response.Status],
        
        // 3. Inspect the code. If it's an error, parse the JSON and throw a custom exception
        result = if (responseCode = 400 or responseCode = 404 or responseCode = 500) then
            let
                // Parse the error payload returned by the API
                errorJson = Json.Document(source),
                // Extract the specific message (depends on your API's schema)
                errorMessage = errorJson[error][message]? ?? "Unknown API Error",
                
                // Throw a custom Power Query error that the user will actually read
                customError = error Error.Record("DataSource.Error", "API returned " & Number.ToText(responseCode) & ": " & errorMessage)
            in
                customError
        else
            // If it's a 200 OK, just parse the JSON normally
            Json.Document(source)
    in
        result;
```

### 2. Creating an Error Handling Wrapper

If your connector has dozens of `Web.Contents` calls, you shouldn't repeat this logic. Certified connectors often wrap `Web.Contents` inside a custom helper function.

```powerquery
// A helper function to replace all Web.Contents calls in your codebase
Web.ContentsCustom = (url as text, optional options as nullable record) =>
    let
        // Ensure options exists and append our manual error handling
        baseOptions = if options = null then [] else options,
        finalOptions = Record.Combine({ 
            baseOptions, 
            [ ManualStatusHandling = {400, 401, 403, 404, 429, 500, 503} ] 
        }),
        
        // Make the network call
        response = Web.Contents(url, finalOptions),
        
        // Check for errors
        status = Value.Metadata(response)[Response.Status],
        result = if (status >= 400) then
            let
                // Attempt to parse the JSON error (wrap in try/otherwise in case the API returns HTML instead)
                jsonError = try Json.Document(response) otherwise null,
                msg = if jsonError <> null and jsonError[message]? <> null then jsonError[message] else "HTTP Error " & Number.ToText(status)
            in
                error Error.Record("DataSource.Error", msg)
        else
            response
    in
        result;
```

Now, anywhere in your code, you just call `Web.ContentsCustom("https://...")` and it automatically handles HTTP errors and bubbling up clean JSON error messages!
