# Power Query Patterns: Rate-Limit-Aware Retry

HTTP `429 Too Many Requests` is distinct from transient server errors. A `500` means "something broke — try again immediately." A `429` means "you are going too fast — wait before retrying." Treating them identically with a short fixed delay often just triggers another `429`.

The rate-limit-aware retry pattern has two layers:

1. **`ManualStatusHandling`** — intercepts the `429` response before Power Query throws a hard error, giving your code access to the `Retry-After` header and the response body.
2. **`Value.WaitFor` with a progressive interval** — delays retries by an amount that grows with each attempt, respecting the API's pace constraints even when no `Retry-After` header is present.

This is a specialization of the general `Value.WaitFor` retry pattern. The key difference is that the interval function is tuned specifically to 429 semantics: the first attempt has zero delay, subsequent attempts grow, and the total cap is conservatively high.

## The Core Mechanism

```powerquery
// Value.WaitFor drives the outer retry loop.
// The producer returns null to signal "keep waiting", non-null to signal "done".
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
```

Returning `null` from the `producer` triggers the `interval(iteration)` wait before the next attempt. The iteration index passed to `interval` is the lever used to make the backoff progressive.

## Implementation

### Azure Cost Management: Linear Backoff for POST Retries

The initial export-queue POST is wrapped in `Value.WaitFor` to handle transient server errors (`500`, `502`, `503`, `504`) that can co-occur with rate limiting. The interval grows by 2 minutes per iteration, with a hard cap of 2 retries (3 total attempts):

```powerquery
GetWebContents = (url as text, ...) =>
    Extension.InvokeWithCredentials(
        (datasource) =>
            if (datasource[DataSource.Kind] = "AzureBlobs")
            then [ AuthenticationKind = "Anonymous" ]
            else Extension.CurrentCredential(),
        () =>
        let
            // ManualStatusHandling prevents hard crashes on 5xx.
            // Returning null on any listed status tells Value.WaitFor to retry.
            waitForResult = Value.WaitFor(
                (iteration) =>
                let
                    header   = if apptype = appTypeLegacy then legacyRequestHeader else modernRequestHeader,
                    response = Web.Contents(url, [
                        IsRetry              = (isRetry = true or iteration > 0),
                        Timeout              = apiCallTimeout,
                        Content              = contentParameter,
                        Headers              = header,
                        ManualStatusHandling = {500, 502, 503, 504}
                    ]),
                    status = Value.Metadata(response)[Response.Status],
                    // null → retry; anything else → done
                    result = if status = 500 or status = 502 or status = 503 or status = 504
                             then null
                             else response
                in
                    result,
                (iteration) => #duration(0, 0, (2 * iteration), 0),  // 0 min, 2 min, 4 min
                2)  // max 2 retries
        in
            waitForResult
    );
```

### Azure Cost Management: Linear Scaling for Polling Loops

Once an export job is queued, the connector polls the `Location` URL. The interval starts at 0 s and adds 0.5 s per iteration — gentle enough to catch fast completions without flooding the API:

```powerquery
GetDataWithPolling = (url as text, statusUri as text, optional appType as text) =>
    Value.WaitFor(
        (i) =>
            let
                rawContent  = GetWebContents(url, appType, true),
                asJson      = try Json.Document(rawContent, 1252) otherwise null,
                jsonContent = if asJson is action then null else asJson meta Value.Metadata(rawContent),

                statusText  = ParseReportStatus(statusUri, appType),
                // Return null while the job is still running; return the content once terminal.
                result =
                    if (statusText = "0" or statusText = "none" or
                        statusText = "1" or statusText = "queued" or
                        statusText = "3" or statusText = "processing" or
                        statusText = "6" or statusText = "readytodownload")
                    then null
                    else jsonContent
            in
                result,
        (i) => #duration(0, 0, 0, i * 0.5),  // 0 s, 0.5 s, 1 s, 1.5 s, ...
        100);
```

### ZohoCreator: True Exponential Backoff on Export

ZohoCreator doubles the wait on every iteration using `Number.Power(2, iteration)`, producing delays of 1 s, 2 s, 4 s, 8 s, 16 s, ... The `max_retry` constant caps total attempts:

```powerquery
GetRecords = (ownername as text, appname as text, viewname as text, creatordomain as text) =>
    let
        waitForResult = Value.WaitFor(
            (iteration) =>
            let
                urii = GetDomain(creatordomain) & "/api/v2/" & ownername & "/" & appname
                     & "/report/" & viewname & "/export?filetype=csv",

                exec = Binary.Buffer(Web.Contents(urii, [
                    // ManualStatusHandling = {401, 400, 500} allows inspection of 429-adjacent
                    // errors without crashing the refresh.
                    ManualStatusHandling = {401, 400, 500},
                    Headers = [
                        #"User-Agent"           = user_agent,
                        #"Agent-Version-Number" = version_number
                    ]
                ])),

                status      = Value.Metadata(exec)[Response.Status],
                actualResult = if status = 200 then exec else "Something went wrong.",
                Json        = Csv.Document(exec, [Delimiter = ","])
            in
                Json,
            // Pure exponential: 2^0=1s, 2^1=2s, 2^2=4s, 2^3=8s, ...
            (iteration) => #duration(0, 0, 0, Number.Power(2, iteration)),
            max_retry)
    in
        waitForResult;
```

### Generic Template: 429-Specific Branch with `Retry-After` Reading

When the API sends a `Retry-After` header, you can read it and convert it into a `#duration` for the next interval. Combine this with a fallback multiplier for APIs that omit the header:

```powerquery
shared MyConnector.RateLimitAwareCall = (url as text) =>
    let
        maxAttempts = 6,
        handledCodes = {429, 500, 502, 503, 504},

        result = Value.WaitFor(
            (iteration) =>
                let
                    response = Web.Contents(url, [ ManualStatusHandling = handledCodes ]),
                    status   = Value.Metadata(response)[Response.Status],
                    headers  = Value.Metadata(response)[Headers],

                    // Prefer the server's Retry-After hint; fall back to exponential growth.
                    retryAfterSeconds =
                        if Record.HasFields(headers, {"Retry-After"})
                        then Number.FromText(headers[#"Retry-After"])
                        else Number.Power(2, iteration),

                    actualResult =
                        if status = 429 then
                            // Rate limited — signal Value.WaitFor to wait and retry.
                            Diagnostics.Trace(
                                TraceLevel.Warning,
                                "HTTP 429: backing off " & Text.From(retryAfterSeconds) & "s (attempt " & Text.From(iteration + 1) & ")",
                                null
                            )
                        else if List.Contains({500, 502, 503, 504}, status) then
                            // Transient server error — also retry.
                            null
                        else
                            // 2xx or unhandled error — return and break the loop.
                            Json.Document(response)
                in
                    actualResult,

            // The interval function ignores 'i' here because the Retry-After value
            // is captured inside the producer via the outer variable pattern.
            // For a simpler connector, use: (i) => #duration(0, 0, 0, Number.Power(2, i))
            (i) => #duration(0, 0, 0, Number.Power(2, i)),
            maxAttempts
        )
    in
        if result = null then
            error Error.Record("DataSource.Error", "Rate limit exceeded after all retry attempts.", url)
        else
            result;
```

## When to Use This Pattern

- The API enforces per-minute or per-second request quotas and responds with `HTTP 429`.
- Dashboard refreshes fan out many parallel requests that would collectively exceed the quota.
- The API provides a `Retry-After` header you want to honor, or lacks one and needs a safe default.
- You need to distinguish `429` (slow down) from `503` (server unavailable) for logging or alerting purposes.

## Key Considerations

- **Always include `429` in `ManualStatusHandling`**: Without it, Power Query throws `Expression.Error: The server returned status 429` immediately, bypassing your retry logic.
- **Jitter prevents thundering herd**: When many connector instances refresh simultaneously and all hit a 429 at the same moment, deterministic backoff causes them all to retry at the same time again. Adding `Number.RandomBetween(-delay/2, delay/2)` staggers the retries.
- **`IsRetry = true` on subsequent attempts**: Pass `IsRetry = (iteration > 0)` in `Web.Contents` options so Power Query does not serve a cached `429` response from its internal cache.
- **`Retry-After` is in seconds**: The header value is a plain integer string. Convert with `Number.FromText(headers[#"Retry-After"])` and wrap in `#duration(0, 0, 0, ...)`.
- **Distinguish 429 from 503 in your branch logic**: A `503` means the server is overloaded and you should back off briefly; a `429` means you specifically exceeded your quota and may need a longer pause or a circuit-break if the limit resets on a per-hour basis.

---

## See Also

- [`api_retries_pattern.md`](api_retries_pattern.md) — The general-purpose `Value.WaitFor` + `ExponentialBackoff` boilerplate that this pattern specializes. Start there for the canonical function definitions.
- [`long_polling_exponential_backoff_pattern.md`](long_polling_exponential_backoff_pattern.md) — Uses the same `Value.WaitFor` mechanism to poll `HTTP 202 Accepted` async jobs rather than retry errors.
