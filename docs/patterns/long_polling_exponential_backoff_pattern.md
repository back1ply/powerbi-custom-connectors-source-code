# Power Query Patterns: Long Polling with Exponential Backoff

When an API responds with `HTTP 202 Accepted` instead of immediate data, it signals that a job has been queued for asynchronous processing. The connector must repeatedly poll a status endpoint until the job completes. Using a naive loop with a fixed delay wastes time on fast jobs and hammers the server on slow ones.

The canonical solution is `Value.WaitFor` paired with a duration-based interval function that scales the wait time with each iteration. This pattern appears verbatim in the Azure Cost Management certified connector, where export jobs can take anywhere from a few seconds to several minutes.

## The Core Mechanism

`Value.WaitFor` drives the polling loop. The `producer` function is called repeatedly with the current iteration index. Returning `null` tells the engine to wait for the `interval` duration and try again. Returning any non-null value immediately terminates the loop and propagates the result.

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
```

## Interval Strategies

The `interval` parameter is a function `(iteration as number) as duration`. Two strategies appear in production connectors:

**Linear scaling** — used in Azure Cost Management `GetDataWithPolling`. Starts at 0 s and grows by half a second per attempt, up to 100 polls:

```powerquery
(i) => #duration(0, 0, 0, i * 0.5)
```

**Fixed linear (minutes)** — used in Azure Cost Management `GetWebContents` for initial POST retries. Waits 0, 2, and 4 minutes across 3 attempts:

```powerquery
(i) => #duration(0, 0, (2 * iteration), 0)
```

**True exponential** — used in ZohoCreator `GetRecords`. Raises 2 to the power of the current iteration, producing delays of 1 s, 2 s, 4 s, 8 s, ...:

```powerquery
(iteration) => #duration(0, 0, 0, Number.Power(2, iteration))
```

## Implementation

### Azure Cost Management: Polling an Async Export Job

The connector POSTs a report-queue request, reads the `Location` and `Azure-AsyncOperation` headers from the `HTTP 202` response, then feeds `locationUri` into `GetDataWithPolling`:

```powerquery
GetDataWithPolling = (url as text, statusUri as text, optional appType as text) =>
    Value.WaitFor(
        (i) =>
            let
                rawContent = GetWebContents(url, appType, true),
                asJson = try Json.Document(rawContent, 1252) otherwise null,
                jsonContent = if asJson is action then null else asJson meta Value.Metadata(rawContent),

                statusText = ParseReportStatus(statusUri, appType),
                // Return null to keep polling while the job is still in-flight.
                // Any terminal status (completed / failed) returns the parsed content.
                result = if (statusText = "0" or statusText = "none" or   // None
                             statusText = "1" or statusText = "queued" or // Queued
                             statusText = "3" or statusText = "processing" or // Processing
                             statusText = "6" or statusText = "readytodownload") // ReadyToDownload
                         then null
                         else jsonContent
            in
                result,
        (i) => #duration(0, 0, 0, i * 0.5),
        100); // poll up to 100 times
```

### ZohoCreator: Exponential Backoff on Export Request

ZohoCreator uses the same `Value.WaitFor` skeleton but applies a pure power-of-two interval. The `max_retry` constant caps the total attempt count:

```powerquery
GetRecords = (ownername as text, appname as text, viewname as text, creatordomain as text) =>
    let
        waitForResult = Value.WaitFor(
            (iteration) =>
            let
                urii = GetDomain(creatordomain) & "/api/v2/" & ownername & "/" & appname & "/report/" & viewname & "/export?filetype=csv",
                exec = Binary.Buffer(Web.Contents(urii, [
                    ManualStatusHandling = {401, 400, 500},
                    Headers = [#"User-Agent" = user_agent, #"Agent-Version-Number" = version_number]
                ])),
                status = Value.Metadata(exec)[Response.Status],
                actualResult = if status = 200 then exec else "Something went wrong.",
                Json = Csv.Document(exec, [Delimiter = ","])
            in
                Json,
            (iteration) => #duration(0, 0, 0, Number.Power(2, iteration)),
            max_retry)
    in
        waitForResult;
```

### Anaplan: Task-State Polling with `Function.InvokeAfter`

Anaplan's export flow polls a `/tasks/{taskId}` endpoint by building a list of deferred calls with `Function.InvokeAfter`. The delay grows with each attempt (`retryInterval * attempt`), and the first successful (non-`IN_PROGRESS`) response wins:

```powerquery
// retryInterval and MaxAttempts come from connector config.
loop = (MaxAttempts, DelayBetweenAttempts) =>
    let
        Numbers = List.Numbers(1, MaxAttempts),
        WebServiceCalls = List.Transform(
            Numbers,
            each Function.InvokeAfter(
                () => getTaskStatus(_),
                if _ > 1 then DelayBetweenAttempts else #duration(0, 0, 0, 0)
            )
        ),
        OnlySuccessful = List.Select(
            WebServiceCalls,
            each _ <> null and Json.Document(_)[task][taskState] <> Extension.LoadString("TaskInProgress")
        ),
        Result = List.First(OnlySuccessful, null)
    in
        Result
```

## When to Use This Pattern

- The API returns `HTTP 202 Accepted` with a job ID or `Location` URL in the response headers.
- Job completion time is variable (seconds to minutes); a fixed sleep would either be too short or waste refresh time.
- You need a hard cap on total polling time (set via the `count` parameter of `Value.WaitFor`).
- The status endpoint returns a string field (`"pending"`, `"running"`, `"completed"`) that you map to continue/stop.

## Key Considerations

- **First-iteration delay**: Pass `if iteration = 0 then #duration(0,0,0,0) else ...` or start with `i * 0.5` to skip an unnecessary sleep on the first poll.
- **Max count is a safety net**: Azure Cost Management uses `100` as the cap. Without a cap, a stuck job would loop forever.
- **Separate status URL from result URL**: Azure Cost Management uses two distinct headers — `Location` for the final download and `Azure-AsyncOperation` for the intermediate status — and polls both independently.
- **`IsRetry = true`**: Set this on subsequent `Web.Contents` calls inside the loop to prevent Power Query's cache from returning the stale first response.

---

## See Also

- [`api_retries_pattern.md`](api_retries_pattern.md) — The canonical `Value.WaitFor` + `ExponentialBackoff` boilerplate. Use this for retrying transient errors (`429`, `5xx`) rather than polling for job completion.
- [`rate_limit_aware_retry_pattern.md`](rate_limit_aware_retry_pattern.md) — Extends the retry pattern with `Retry-After` header reading and 429-specific backoff semantics.
