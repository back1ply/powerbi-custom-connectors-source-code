# Power Query Patterns: Handling HTML Error Responses

When connecting to a REST API, Power Query developers assume that all responses will be formatted as JSON. They write their network calls like this:

```powerquery
let
    source = Web.Contents("https://api.mycompany.com/v1/data"),
    json = Json.Document(source)
in
    json
```

This works perfectly 99% of the time. But what happens if the API's backend server crashes, and the load balancer (like Cloudflare, Nginx, or AWS API Gateway) intercepts the request and returns a `502 Bad Gateway` error?

Load balancers don't return JSON. They return an HTML web page.

If you followed the [Graceful Error Handling Pattern](error_handling_pattern.md) and told `Web.Contents` to swallow `500` errors, your script will immediately crash on the very next line when `Json.Document` tries to parse an HTML string. The user will see a completely useless error: **"DataFormat.Error: We couldn't parse the input provided as a JSON value."**

## The Safe JSON Parsing Pattern

To build a truly bulletproof connector, you must *never* assume the payload is JSON until you successfully parse it.

### Implementation

Instead of blindly calling `Json.Document`, wrap the parsing step in a `try ... otherwise` block. If parsing fails, fall back to reading the payload as raw text so you can inspect it or show it to the user.

```powerquery
shared MyConnector.SafeGet = (url as text) =>
    let
        // 1. Get the raw binary response, telling Web.Contents not to crash on 500s
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

### Why this is critical

If you use the basic parsing method on a 502 error, the user gets:
❌ *"We couldn't parse the input provided as a JSON value."* (The user assumes your connector is broken).

If you use the Safe JSON Parsing pattern, the user gets:
✅ *"The server returned a non-JSON response. Raw output: `<html><head><title>502 Bad Gateway</title>...`"* (The user immediately understands the API server is down, and your connector is working correctly by reporting the outage).
