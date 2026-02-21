# Power Query Patterns: Handle API Rate Limits & Retries

A major issue when building Power Query connectors is that `Web.Contents` will instantly fail the entire semantic model refresh if it encounters an HTTP error like `429 Too Many Requests` or a transient `500 Internal Server Error`.

To prevent this, you must explicitly tell `Web.Contents` to ignore those errors using `ManualStatusHandling`, and then write a recursive looping function (using `List.Generate` or `Value.WaitFor`) to pause execution and try again.

## The `Value.WaitFor` Helper

Across connectors like *QuickBase*, *DeltaSharing*, and *AzureResourceGraph*, Microsoft uses a helper function called `Value.WaitFor` to implement exponential backoff. 

This relies on `Function.InvokeAfter`, which forces the single-threaded M engine to sleep for a specified duration before evaluating the next step.

### 1. Define the Helper function

```powerquery
// Place this at the bottom of your file
Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} < count),
            (state) => if state{1} <> null
                then {null, state{1}}
                else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1}
        )
    in
        List.Last(list);
```

### 2. Boilerplate: The Retry Wrapper

Instead of calling `Web.Contents` directly, you wrap it in your own retry logic.

```powerquery
// A reusable function to make HTTP calls that automatically retry on 429s
WebContentsWithRetry = (url as text, optional options as record) =>
    let
        waitForResult = Value.WaitFor(
            // 1. The Producer: What we are trying to do
            (retryCount) =>
                let
                    // If it's a retry, we can optionally add custom tracking headers
                    currentOptions = if options = null then [] else options,
                    
                    // Crucial: We must tell Power Query NOT to crash on 429 or 503 HTTP statuses
                    safeOptions = currentOptions & [ManualStatusHandling = {429, 503}],
                    
                    // Make the actual call
                    response = Web.Contents(url, safeOptions),
                    
                    // Buffer the binary data so we don't accidentally fetch it twice
                    buffered = Binary.Buffer(response),
                    
                    // Check the status code returned in the metadata
                    status = Value.Metadata(response)[Response.Status],
                    
                    // If the status is 429 or 503, we return null to tell Value.WaitFor to try again.
                    // Otherwise, we return the successful result.
                    result = if (status = 429 or status = 503) then null else buffered
                in
                    result,
                    
            // 2. The Interval (Exponential Backoff): How long to wait if the Producer returned null
            (retryCount) => 
                let
                    // Example: Wait 2 seconds, then 4 seconds, then 8 seconds...
                    secondsToWait = Number.Power(2, retryCount) 
                in 
                    #duration(0, 0, 0, secondsToWait),
                    
            // 3. Optional limit (Stop trying after 5 attempts)
            5
        )
    in
        if waitForResult = null then
            error "Web.Contents failed after 5 retry attempts due to Rate Limiting."
        else
            waitForResult;
```

### 3. Usage inside your connector

Simply replace your `Web.Contents` calls with `WebContentsWithRetry`.

```powerquery
// Before
GetApiData = (url as text) => Json.Document(Web.Contents(url));

// After
GetApiData = (url as text) => Json.Document(WebContentsWithRetry(url));
```
