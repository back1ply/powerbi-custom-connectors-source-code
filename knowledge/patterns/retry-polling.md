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
- id: arg
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AzureResourceGraph/AzureResourceGraph.pq#L52
  title: AzureResourceGraph/AzureResourceGraph.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L774
  title: CogniteDataSource/CogniteDataSource.pq
- id: statusList
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L1009
  title: CogniteDataSource/CogniteDataSource.pq
- id: defaults
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L5
  title: CogniteDataSource/CogniteDataSource.pq
- id: polling
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L618
  title: Anaplan/Anaplan.pq
- id: anaWaitFor
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L777
  title: Anaplan/Anaplan.pq
review:
  content_sha256: d1724968fd7de0fe92f0281bbc60ebe6e8df28fe4a49b9c3efe75ee6c8c53b48
  sources_sha256:
    example: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    arg: a725cec6c35b49a84c0381dec02ff666451c3f1b4dda29c66e54da7882b733ce
    variant: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    statusList: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    defaults: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    polling: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    anaWaitFor: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Retries, delays, and polling

## Mechanism

AzureResourceGraph has two separate delays. `ARGImpl` waits a random one to three seconds before each page request (lines 58–59).[^arg] Inside one page, `WaitForResult` calls a connector-defined `Value.WaitFor` with a delay of `2^iteration` seconds (line 106). It passes `IsRetry = iteration > 0` (line 95) and handles 500 and 400 manually (line 94).[^example] The interval runs before every producer call, so the first attempt also waits one second.

`Value.WaitFor` is a `List.Generate` over `{iteration, result}` states and returns `List.Last` of the emitted results. The initial state is `{0, null}`. The next states have counters 1 and 2 and carry the results of producers 0 and 1. A counter-3 state would carry producer 2, but fails `state{0} < 3` before its lazy result is demanded. This source-level reading yields at most two explicit producer attempts; verify actual transport calls separately.[^example]

A 500 at iteration 0 returns null and permits the next producer attempt. A second null is the final emitted result. The producer’s iteration-3 error branch is unreachable under the helper’s `< 3` condition, so persistent 500s yield null. `GetPage` then attempts `response[IsError]` on that null.[^example]

Cognite’s `RetryWithExponentialBackoff` retries 429, 502, 503, 504, and a 409 carrying `cdf-is-auto-retryable: true`. It retries 408 unless the URL path ends in `/models/instances/query`. Budgets are `MaxRetries = 10` or `MaxRetries408 = 2`; randomized delays use bases of 1000 or 2000 ms and a 60000-ms cap. Non-retryable responses return to the caller, while exhaustion raises `CogniteAPIError` with status and request ID.[^variant][^defaults]

Anaplan’s export poll configures 200 numbered attempts and a ten-second delay after the first. It accepts the first state differing from the resource-defined in-progress value. Exhaustion calls `ErrorTable(2, Number.From(taskId))`: a table result for a numeric ID, but the conversion can raise for a non-numeric ID. The resource’s actual state string is not retained here; see [asynchronous exports](async-exports.md) for the caller and download boundaries.[^polling]

Anaplan also defines an unused `Value.WaitFor` with a `<=` count test. If called with count 3, that condition would allow the counter-3 state carrying producer 2 to be emitted. ARG’s `<` excludes that state. This is a comparison of helper definitions, not evidence of actual Anaplan calls.[^anaWaitFor]

## Selection and dependencies

Use a retry helper for transient failures and polling for server-side task state. Identify the request builder, budget, interval function, and exhaustion result separately. Unhandled HTTP error statuses follow `Web.Contents` default handling before the custom helper can inspect them. Cognite’s GraphQL request passes a manual-status list covering the helper’s retryable codes.[^variant][^statusList]

Keep throttling between successful pages in the callback, as ARG does at lines 58–59. See [pagination](pagination.md). For the metadata that marks the last page, see [response metadata](response-metadata.md). For GraphQL execution retries, see [GraphQL](graphql.md). For structured error messages, see [errors](errors.md).

## Adaptation and failure paths

Derive the attempt budget from the helper's count and the producer's own test together. This source passes `count = 3` and tests `iteration < 3` in its producer. Reading the lazy `List.Generate`, the effective budget is two attempts, so the producer's iteration-3 branch never runs. Confirm the call count with a test server before you document a budget.

Give exhaustion an explicit outcome before you read its fields. A null from the helper breaks `response[IsError]`. Return a record with `IsError` and `Content`, or raise an error that the caller expects, and make that choice in one place. `WaitForResult` returns a plain record, not an `Error.Record`, and `GetPage` re-raises it with `error response[Content]` (line 77).

The 400 branch returns a record whose `Content` expression reads `body[error][details]` through `Record.Field`. That field is lazy: missing details can fail when `GetPage` demands `response[Content]`, after the producer has already returned its handled record. Test both construction and consumption of error results.[^example]

Neither helper honors a server-specified wait. `WaitForResult` does not read `Retry-After`, and Cognite's helper reads only `cdf-is-auto-retryable` and `x-request-id` from its headers.[^example][^variant] Do not infer header-aware behavior from the presence of a delay.

Anaplan's poll treats a failed task like a finished one. The filter removes only the in-progress constant (line 638), so a failed or cancelled state proceeds to the download (line 640). Any HTTP error from `getTaskStatus` propagates, because its `Web.Contents` call has no `ManualStatusHandling` (lines 631–632).[^polling]

## Validation checklist

- Keep one attempt budget, and make the producer's condition and the count agree.
- Decide what exhaustion returns, and handle it before reading fields.
- List every retryable status in `ManualStatusHandling`. Cognite's `statusToRaise` (line 1009) is the longer example.[^statusList]
- Read `Retry-After` if the API sends it. Neither helper here does.
- For polling, treat each non-in-progress state as success, failure, or unknown, and handle each one.

## Examples

Page delay and attempt helper, AzureResourceGraph lines 85–118:

<!-- source: example -->
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

Request-level retry helper, CogniteDataSource lines 774–831:

<!-- source: variant -->
```powerquery
RetryWithExponentialBackoff = (url as text, request as record, retryCount as number) as any =>
    let
        // On retries, set IsRetry = true so Power Query bypasses its HTTP response cache
        // and actually makes a fresh request instead of returning the cached error response.
        requestWithRetry = if retryCount > 0 then request & [IsRetry = true] else request,
        response = Web.Contents(url, requestWithRetry),
        responseMetadata = Value.Metadata(response),
        responseHeaders = Record.FieldOrDefault(responseMetadata, "Headers", []),
        code = responseMetadata[Response.Status],

        isAutoretryable409 = code = 409 and Record.FieldOrDefault(responseHeaders, "cdf-is-auto-retryable", "false") = "true",

        // For query endpoints, don't retry 408 - let external PowerQuery handle page size reduction
        isQueryEndpoint = Text.EndsWith(Uri.Parts(url)[Path], "/models/instances/query"),
        retryableErrors = {429, 502, 503, 504},
        isRetryable = List.Contains(retryableErrors, code) or isAutoretryable409 or (code = 408 and not isQueryEndpoint),

        maxRetries = if code = 408 then CogniteDefaults[MaxRetries408] else CogniteDefaults[MaxRetries],
        baseDelay = if code = 408 then CogniteDefaults[BaseRetryDelayMs408] else CogniteDefaults[BaseRetryDelayMs],

        result =
            if isRetryable and retryCount < maxRetries then
                let
                    delayFactor = Number.Power(2, retryCount),
                    baseDelayMs = List.Min({baseDelay * delayFactor, CogniteDefaults[MaxRetryDelayMs]}),
                    delayMs = Number.Random() * baseDelayMs,
                    delayDuration = #duration(0, 0, 0, delayMs / 1000),

                    retryResult = Function.InvokeAfter(
                        () => @RetryWithExponentialBackoff(url, request, retryCount + 1),
                        delayDuration
                    )
                in
                    retryResult
            else if isRetryable then
                let
                    responseJson = try Json.Document(response) otherwise null,
                    errorDetails = if responseJson <> null then Record.FieldOrDefault(responseJson, "error") else null,
                    requestId = Record.FieldOrDefault(responseHeaders, "x-request-id", "unknown"),
                    cluster = try Text.BeforeDelimiter(Uri.Parts(url)[Host], ".") otherwise "unknown",
                    originalMessage = if Value.Is(errorDetails, type record) then Record.FieldOrDefault(errorDetails, "message", "Request failed") else if Value.Is(errorDetails, type text) then errorDetails else "Request failed",
                    errorType = if code = 429 then "Rate limit" 
                                else if code = 408 then "Request timeout"
                                else if code = 409 then "Conflict (autoretryable)"
                                else "Gateway error",
                    errorMessage = errorType & " exceeded after " & Text.From(maxRetries) & " retries. Please try again later.",
                    errorDetail = [
                        code = code,
                        requestId = requestId,
                        cluster = cluster,
                        originalError = originalMessage
                    ]
                in
                    error Error.Record("CogniteAPIError", errorMessage, errorDetail)
            else
                response
    in
        result;
```

Export-task poll, Anaplan lines 618–649:

<!-- source: polling -->
```powerquery
GetWebContentsExportRunSuccess = (url as text, exportKey as text, configParams as list, exportMetadata as record) as table => 
    let
        apiTokenValue = configParams{ConfigParamsIndex[apiToken]},
        exportUrl = url & "exports/"  & exportKey & "/tasks",
        fileUrl = url & "files/" & exportKey,
        body = "{""localeName"":""en_US""}",
        
        exportRunResp = Json.Document(Binary.Buffer(Web.Contents(exportUrl, [Headers = [#"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue, #"Content-Type"="application/json", #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue")], 
            Content = Text.ToBinary(body), ManualStatusHandling = {500, 501, 502, 503}]))),
        
        fileDownload = (taskId as text) =>
            let
                // noCache = #"NoCache"= Number.ToText(count + Number.Random())
                getTaskStatus = (count as number) => Binary.Buffer(Web.Contents(exportUrl & "/" & taskId, 
                    [Headers = [#"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue, #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue"), #"NoCache"= Number.ToText(count + Number.Random()) ]])),
         
                getTaskStatusLoop = (MaxAttempts, DelayBetweenAttempts) =>
                    let
                        Numbers = List.Numbers(1, MaxAttempts),
                        WebServiceCalls = List.Transform(Numbers, each Function.InvokeAfter(() => getTaskStatus(_), if _ > 1 then DelayBetweenAttempts else #duration(0,0,0,0))),
                        OnlySuccessful = List.Select(WebServiceCalls, each _ <> null and Json.Document(_)[task][taskState] <> Extension.LoadString("TaskInProgress")),
                        Result = List.First(OnlySuccessful, null),
                        res = if Result <> null then DownloadFileListAccumulate(fileUrl, configParams, exportMetadata) else ErrorTable(2, Number.From(taskId))
                    in
                        res,

                // todo: evaluate proper duration & retries
                result = getTaskStatusLoop(200, #duration(0,0,0,10))            
            in 
                result
    in
        fileDownload(exportRunResp[task][taskId]);
```

[^arg]: AzureResourceGraph/AzureResourceGraph.pq lines 52–62 (`ARGImpl`): page delay `Number.RandomBetween(1, 3)` (line 58) and `Function.InvokeAfter` (line 59).
[^example]: AzureResourceGraph/AzureResourceGraph.pq lines 85–118 (`WaitForResult` and `Value.WaitFor`): manual 500 and 400 handling, `IsRetry`, the `2^iteration` interval, the `< count` test, and the `List.Last` result.
[^variant]: CogniteDataSource/CogniteDataSource.pq lines 774–831 (`RetryWithExponentialBackoff`): retry status set (lines 784–789), budgets and delays (lines 791–799), non-retryable return (lines 828–829), and the exhaustion error (lines 808–827).
[^defaults]: CogniteDataSource/CogniteDataSource.pq lines 5–26 (`CogniteDefaults`): `MaxRetries` 10, `BaseRetryDelayMs` 1000, `MaxRetryDelayMs` 60000, `MaxRetries408` 2, and `BaseRetryDelayMs408` 2000.
[^polling]: Anaplan/Anaplan.pq lines 618–649 (`GetWebContentsExportRunSuccess`): the 200-attempt task poll (lines 636–637), the in-progress filter (line 638), the `ErrorTable` fallback (line 640), and the unhandled `Web.Contents` status read (lines 631–632).
[^statusList]: CogniteDataSource/CogniteDataSource.pq lines 1009–1014: `statusToRaise` (line 1009), passed as `ManualStatusHandling` in the GraphQL request (line 1014). The helper's own retry set is at line 788.
[^anaWaitFor]: Anaplan/Anaplan.pq lines 777–791: a second `Value.WaitFor` whose count test uses `<=` (line 783). The file contains no call to it.
