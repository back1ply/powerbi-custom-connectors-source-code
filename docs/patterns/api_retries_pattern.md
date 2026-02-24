# Power Query Patterns: `Value.WaitFor` API Retries

When interacting with unstable APIs or systems prone to rate limiting (HTTP `429 Too Many Requests`), the standard `Web.Contents` function will immediately throw an `Expression.Error` and fail the entire dataset refresh.

While Power Query has some built-in retry logic, it is highly opaque, lacks robust diagnostic tracing, and often fails to handle edge-case HTTP status codes like `502 Bad Gateway` or `503 Service Unavailable` properly.

To take back control of API polling and retry thresholds, Microsoft engineers exclusively rely on a custom boilerplate wrapper called `Value.WaitFor`, typically paired with an `ExponentialBackoff` function.

## The `Value.WaitFor` Boilerplate

You can copy and paste these two functions directly into your `MyConnector.pq` file. They are used in over 60 certified connectors, including Azure Resource Graph, Smartsheet, Databricks, and Zendesk.

```powerquery
// Helper function to implement recursive retries.
// It uses List.Generate to poll the 'producer' function, delaying each attempt via 'interval', up to 'count' times.
Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} <= count),
            (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1}
        )
    in
        List.Last(list);

// Returns the duration of time to wait before retrying a request.
// It implements an exponential backoff formula: 2^iteration + Jitter
ExponentialBackoff = (iteration as number) as duration => 
    let 
        baseDelay = Number.Power(2, iteration),
        delay = 
            // No delay for the first iteration (0th attempt)
            if iteration = 0 then 0 
            else Number.RoundDown(baseDelay + 1 + Number.RandomBetween(-baseDelay/2, baseDelay/2))
    in
        #duration(0, 0, 0, delay);
```

## Implementation

To use this pattern, you must use the `ManualStatusHandling` feature of `Web.Contents`. 
By passing a list of HTTP Error codes to `ManualStatusHandling`, you instruct the Power Query engine **not** to throw a hard error. Instead, it will gracefully return the raw HTTP Response object, allowing your M code to inspect the `Response.Status` metadata and decide whether to retry.

In this example, we wrap our entire `Web.Contents` call inside `Value.WaitFor`.

```powerquery
shared MyConnector.SafeApiCall = (url as text) =>
    let
        // 1. Define the maximum number of attempts and the status codes we want to intercept
        maxAttempts = 5,
        manuallyHandledStatusCodes = {408, 429, 500, 502, 503, 504, 509},
        
        // 2. Wrap the API logic inside Value.WaitFor
        result = 
            Value.WaitFor(
                (iteration) =>
                    let
                        // Execute the request. ManualStatusHandling prevents hard crashes on HTTP 500s.
                        response = Web.Contents(url, [ ManualStatusHandling = manuallyHandledStatusCodes ]),
                        
                        // Extract the HTTP status code from the response metadata
                        status = Value.Metadata(response)[Response.Status],
                        
                        // Evaluate the result
                        actualResult = 
                            if List.Contains(manuallyHandledStatusCodes, status) then
                                // If we hit a handled error, check if we have attempts remaining
                                if (iteration + 1) < maxAttempts then
                                    // Log a warning and RETURN NULL. 
                                    // Returning null tells Value.WaitFor to trigger the ExponentialBackoff and loop again.
                                    Diagnostics.Trace(TraceLevel.Warning, "Attempt " & Text.From(iteration + 1) & " failed with " & Text.From(status) & ". Retrying...", null)
                                else 
                                    // We are out of attempts. Return completely null (or throw a hard error).
                                    Diagnostics.Trace(TraceLevel.Error, "All " & Text.From(maxAttempts) & " attempts failed for URL: " & url, null)
                            else 
                                // Success! Return the JSON payload. Returning a non-null value breaks the Value.WaitFor loop immediately.
                                Json.Document(response)
                    in
                        actualResult, 
                
                // 3. Pass the interval logic and maximum count to the Value.WaitFor wrapper
                ExponentialBackoff, 
                maxAttempts
            )
    in
        if result = null then
            error Error.Record("DataSource.Error", "API Failed after multiple retry attempts.", url)
        else
            result;
```

### Why Use `Value.WaitFor`?

1. **Robust 429 Handling**: Many API providers explicitly ignore standard `Retry-After` HTTP headers, meaning Power BI's automatic retries fail. `Value.WaitFor` guarantees a hardcoded exponential backoff (e.g., wait 2s, wait 4s, wait 8s).
2. **Jitter Protection**: The `ExponentialBackoff` function adds randomization (`Number.RandomBetween`). If a massive dashboard refresh triggers 100 simultaneous requests that all receive HTTP 429s, adding jitter ensures they don't all magically retry at the exact same millisecond and immediately break the rate limit again.
3. **Async Polling**: This exact same `Value.WaitFor` pattern can be used to poll APIs that return `HTTP 202 Accepted` and require you to repeatedly check a `JobStatus` endpoint until it returns `HTTP 200 OK`. You simply modify the `if status = 202 then null else response` logic.
