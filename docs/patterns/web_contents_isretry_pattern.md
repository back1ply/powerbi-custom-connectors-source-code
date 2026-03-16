# Power Query Patterns: Bypassing the Web Cache (`IsRetry`)

Power Query contains an aggressive internal web caching layer. By default, if you invoke `Web.Contents` with the exact same URL, Headers, and Content body multiple times within the same evaluation session, the engine will only execute the HTTP request **once** and immediately return the cached byte-stream for all subsequent calls.

This behavior is incredibly fast and efficient for standard data fetching. However, it severely breaks advanced API polling patterns.

## The Problem: Infinite Polling Loops

When implementing the **API Retries (HTTP 429)** or **Long-Running Operations (HTTP 202 Polling)** architectures using `Value.WaitFor`, you are intentionally requesting the exact same URL repeatedly until the server changes its response.

```powerquery
// Example: Polling an Async job endpoint
CheckStatus = () =>
    let
        // The URL never changes during polling
        Response = Web.Contents("https://api.mycompany.com/job/123", [
            ManualStatusHandling = { 202 }
        ])
    in
        if Value.Metadata(Response)[Response.Status] = 202 then null else Response
```

If you pass this function into `Value.WaitFor`, the engine will execute the first HTTP GET and cache the `202 Accepted` response.

Ten seconds later, when `Value.WaitFor` evaluates `CheckStatus()` again, the M Engine will intercept the call, see that the URL hasn't changed, and instantly return the locally cached `202 Accepted` response _without actually contacting the server._

You will be stuck in an infinite loop forever, because Power Query refuses to ask the server for an updated status. Power query actively ignores `Cache-Control` response headers.

## The Solution: The Undocumented `IsRetry` Flag

To override the M Engine's caching layer, Microsoft quietly introduced an undocumented boolean flag to the `Web.Contents` option record: `IsRetry`.

When `IsRetry = true`, Power Query is forced to drop the cached payload and perfectly re-execute the HTTP network request against the remote server.

### Implementation inside `Value.WaitFor`

You should dynamically set `IsRetry` based on the iteration counter provided by `Value.WaitFor`.

```powerquery
FetchWithRetry = (url as text) =>
    let
        // The producer function accepts the current iteration count (0-indexed)
        Producer = (iteration as number) =>
            let
                // If Iteration > 0, this is a retry attempt, so force cache invalidation
                forceNetworkRefresh = (iteration > 0),

                Response = Web.Contents(url, [
                    ManualStatusHandling = {429, 500, 502, 503, 504},

                    // UNDOCUMENTED: Forces Power Query to ignore local Cache-Control
                    IsRetry = forceNetworkRefresh
                ]),
                Status = Value.Metadata(Response)[Response.Status]
            in
                if Status = 429 then null else Response
    in
        Value.WaitFor(Producer, ExponentialBackoff, 5);
```

### Usage across the Microsoft SDK

Scraping the Microsoft Custom Connectors repository reveals just how heavily the developers rely on this undocumented injection:

- **WorkplaceAnalytics.pq**: `// IsRetry is needed, otherwise PowerBI will be stuck waiting without actually retrying the call`
- **Usercube.m**: `// Specify IsRetry to ignore cache (PowerBI ignore the Cache-Control header returned by the server)`
- **Samsara.Client.Retry.pqm**: `IsRetry = SkipCache // (IsRetry = true) causes PowerBI to skip its cache`
- **MicroStrategyDataset.m**: Hardcodes `IsRetry = true` on every REST API Logout action to ensure the session actually invalidates.

Whenever you find your custom connector "hanging" or loading infinitely without throwing a formal error, it is almost certainly trapped in a cached polling loop that requires `IsRetry`.
