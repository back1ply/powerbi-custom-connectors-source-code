---
type: Power Query Pattern
title: Retries, delays, and polling
description: Retry producers, page delays, and exhaustion behavior.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Value\.WaitFor|Function\.InvokeAfter)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L85
  title: AzureResourceGraph/AzureResourceGraph.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 983219a6c98c30a55921d6c6a58c65b9d21398727b560476cca17770e599c8af
  sources_sha256:
    example: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
---

# Mechanism

AzureResourceGraph uses two distinct delays. Page traversal applies a random one-to-three-second delay before `GetPage`. Inside a request, `WaitForResult` uses `Value.WaitFor` with an exponential interval, manually handles HTTP 500 and 400, and sets `IsRetry` when the iteration is greater than zero. A retryable 500 produces `null`; a handled 400 produces an error record for its caller.[^example]

`Value.WaitFor` is defined in the connector itself with `List.Generate`. Its state contains an iteration and a result, and it stops when a non-null result has been produced or the configured count is reached. Read that definition rather than treating the helper name as a built-in guarantee.[^example]

# Adaptation and failure paths

Derive the attempt budget from both the producer and the helper's count condition. This source passes a count of three while its producer also tests `iteration < 3`; the branch threshold alone is not an attempt-count specification. Review what happens when repeated null results exhaust the helper: `List.Last` can return null, while the caller expects a record with `IsError` and `Content`.[^example]

When adapting the code, give exhaustion an explicit outcome before accessing result fields. Keep throttling between successful pages separate from retry handling for a failed request. The shown `WaitForResult` interval does not parse `Retry-After`; do not infer header-aware behavior from the presence of a delay.[^example]

See [response metadata](response-metadata.md) and [structured errors](errors.md).

# Examples

The following excerpt is copied from `AzureResourceGraph/AzureResourceGraph.pq`, lines 85–118.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
WaitForResult = (postData as binary) => 
    let
        apiUrl = Uri.Combine(GetEndpointConfig()[AzureResourceManager], "/providers/Microsoft.ResourceGraph/resources?api-version=2021-03-01"),
        waitForResult = Value.WaitFor(
            (iteration) =>
                let
                    result = Web.Contents(apiUrl, 
                        [Headers = [#"Content-Type" = "application/json", #"X-Ms-Command-Name" = "ARGPBI"],
                        Content = postData,
                        ManualStatusHandling = {500, 400},
                        IsRetry = iteration > 0]),
                    status = Value.Metadata(result)[Response.Status],
                    body = Json.Document(result),
                    statusCode = Value.Metadata(result)[Response.Status],
                    errorMessage = if statusCode <> 200 then body[error][message] else "",
                    details = if statusCode <> 200 then Record.Field(body[error], "details") else {},
                    detailedErrorMessage = if statusCode <> 200 and List.IsEmpty(details) then "" else if List.IsEmpty(details) <> true then List.Accumulate(details, "", (state, current) => state & " " & current[message]) else "",
                    errorCheck = if statusCode <> 200 then errorMessage & " Details:" & detailedErrorMessage else null,
                    actualResult = if status = 500 then if iteration < 3 then null else [IsError = true, Content = errorCheck] else if status = 400 then [IsError = true, Content = errorCheck] else [IsError = false, Content = body]
                in
                    actualResult,
            (iteration) => #duration(0, 0, 0, Number.Power(2, iteration)), 3)
    in
        waitForResult;

Value.WaitFor = (producer as function, interval as function, optional count as number) as any =>
    let
        list = List.Generate(
            () => {0, null},
            (state) => state{0} <> null and (count = null or state{0} < count),
            (state) => if state{1} <> null then {null, state{1}} else {1 + state{0}, Function.InvokeAfter(() => producer(state{0}), interval(state{0}))},
            (state) => state{1})
    in
        List.Last(list);
```

[^example]: AzureResourceGraph/AzureResourceGraph.pq; see the matching `sources` entry.
