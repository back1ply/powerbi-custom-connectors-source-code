# Power Query Patterns: Enforced API Delays (Throttling)

Power Query is designed to evaluate exactly as fast as your CPU and network allow. When paginating through hundreds of pages of API data using `Table.GenerateByPage`, Power Query might fire off 20 HTTP requests per second.

If the API you are connecting to has a strict secondary rate limit (e.g., "Max 2 requests per second"), your connector will immediately receive `429 Too Many Requests` or risk getting the user's IP temporarily banned.

While the [API Retries Pattern](api_retries_pattern.md) handles *reacting* to 429 errors after they happen, sometimes you need to *proactively* throttle Power Query to prevent the errors from occurring in the first place.

## The `Function.InvokeAfter` Pattern

To deliberately pause execution in M, you use the `Function.InvokeAfter` function. It takes two arguments: a function to execute, and a `#duration` specifying how long to wait before executing it.

### 1. Basic Delay Implementation

If you want to unconditionally wait 1 second before calling an API endpoint:

```powerquery
shared MyConnector.GetSlowData = (id as text) =>
    let
        // The delay is Days, Hours, Minutes, Seconds
        delayDuration = #duration(0, 0, 0, 1),
        
        // Wrap your Web.Contents call inside a zero-argument function () =>
        invokeProcess = () => Web.Contents("https://api.mycompany.com/v1/data/" & id),
        
        // Tell Power Query to wait 1 second before evaluating that function
        response = Function.InvokeAfter(invokeProcess, delayDuration)
    in
        Json.Document(response);
```

### 2. Throttling Pagination

The most common place this is needed is inside `Table.GenerateByPage`. You can modify the `Table.GenerateByPage.pqm` helper script to enforce a strict delay between every page request.

```powerquery
// A modified excerpt from Table.GenerateByPage.pqm
// ...
    // Calculate the delay for the next page
    delayDuration = #duration(0, 0, 0, 2), // Wait 2 seconds between pages
    
    // Instead of calling the producer immediately, delay it
    nextRecord = Function.InvokeAfter(
        () => producer(state{0}), 
        delayDuration
    )
// ...
```

### 3. Dynamic Delays Based on Response Headers

Some advanced APIs return a header like `X-RateLimit-Reset: 5` on successful 200 OK responses, telling you how long you should wait before you are allowed to ask for the next page. 

You can extract this dynamically:

```powerquery
// Inside a pagination loop
let
    response = Web.Contents("https://api.mycompany.com/v1/records"),
    headers = Value.Metadata(response)[Headers],
    
    // Extract the header (returns null if it doesn't exist)
    waitText = Record.FieldOrDefault(headers, "X-RateLimit-Reset", "0"),
    waitSeconds = Number.FromText(waitText),
    
    delayDuration = #duration(0, 0, 0, waitSeconds),
    
    // Pass this duration into the next Function.InvokeAfter call...
    // ...
```

*Warning: Be careful using heavy throttling on large datasets. If an API requires a 5-second delay between pages, and the user tries to download 1,000 pages of data, the refresh will take over 1 hour and may time out in the Power BI Service.*
