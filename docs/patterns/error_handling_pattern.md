# Power Query Patterns: Graceful Error Handling

When using `Web.Contents`, Power Query expects the server to return an HTTP status code between 200 and 299. If the server returns _anything_ else (e.g., 400 Bad Request, 401 Unauthorized, 500 Internal Server Error), Power Query terminates execution immediately and throws a fatal `DataSource.Error`.

The problem? Most modern APIs return a helpful JSON payload explaining _why_ the error happened (e.g., `{"error": "Invalid date format for parameter 'start_date'"}`). If Power Query crashes instantly, the user never sees this helpful message.

## 1. The `ManualStatusHandling` Pattern

To gracefully handle errors, we tell `Web.Contents` _not_ to crash on specific HTTP codes. We then inspect the status code ourselves, parse the JSON error body, and throw a custom M exception so the user sees the real reason for the failure.

Pass a list of HTTP status codes you want to handle manually into the `ManualStatusHandling` option of `Web.Contents`.

```powerquery
shared MyConnector.Contents = () =>
    let
        // 1. Tell Web.Contents to return the body even if it's a 400 or 500
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
                // Extract the specific message
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

## 2. Bulletproofing: HTML Error Responses

There is a fatal flaw in the basic `ManualStatusHandling` pattern above: **It assumes the payload is always JSON.**

What happens if the API's backend server crashes, and the load balancer (like Cloudflare, Nginx, or AWS API Gateway) intercepts the request and returns a `502 Bad Gateway` error? Load balancers don't return JSON. They return an HTML web page.

If you tell `Web.Contents` to swallow `500` errors, your script will immediately crash on the very next line when `Json.Document` tries to parse an HTML string. The user will see a completely useless error: _"We couldn't parse the input provided as a JSON value."_

### The Safe JSON Parsing Patter

To build a truly bulletproof connector, you must _never_ assume the payload is JSON until you successfully parse it. Wrap the parsing step in a `try ... otherwise` block. If parsing fails, fall back to reading the payload as raw text.

```powerquery
shared MyConnector.SafeGet = (url as text) =>
    let
        // 1. Get the raw binary response, telling Web.Contents not to crash
        response = Web.Contents(url, [ ManualStatusHandling = {400, 401, 403, 404, 500, 502, 503, 504} ]),

        // 2. Safely attempt to parse the JSON
        jsonResult = try Json.Document(response),

        // 3. Did the parsing succeed?
        parsedPayload = if jsonResult[HasError] then
            // FALSE: The API returned HTML, XML, or plain text!
            let
                // Convert the binary to a text string so we can see what the load balancer said
                rawText = Text.FromBinary(response),

                // Show the raw HTML/Text to the user in the error message
                errorMessage = "The server returned a non-JSON response. Raw output: " & Text.Start(rawText, 500)
            in
                error Error.Record("DataSource.Error", errorMessage)
        else
            // TRUE: It was valid JSON.
            jsonResult[Value]
    in
        parsedPayload;
```

If you use the Safe JSON Parsing pattern on a load balancer outage, the user gets an explicit confirmation that the server crashed:
✅ _"The server returned a non-JSON response. Raw output: `<html><head><title>502 Bad Gateway</title>...`"_
