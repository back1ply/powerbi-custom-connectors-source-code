# Power Query Patterns: Response Header Extraction

Most Power Query connectors only ever read the body of an HTTP response. But many REST APIs embed critical control information in response *headers* — a `Location` URL pointing to a status endpoint, an `Azure-AsyncOperation` URL for the final result, or a `Retry-After` delay hint.

Power Query exposes all response headers through `Value.Metadata(response)[Headers]`. To access them, the `Web.Contents` call must use `ManualStatusHandling`; without it, any non-2xx status causes an immediate hard error before your code can inspect the headers.

## The Core Mechanism

```powerquery
// 1. Issue the request, suppressing automatic error-throwing for the listed status codes.
response = Web.Contents(url, [
    ManualStatusHandling = {202, 400, 401, 500, 502, 503}
]),

// 2. Pull the full metadata record from the response binary.
metadata = Value.Metadata(response),

// 3. Index into [Headers] to read individual header values.
headers     = metadata[Headers],
statusCode  = metadata[Response.Status],
locationUri = headers[Location],
asyncOpUri  = headers[#"Azure-AsyncOperation"],
retryAfter  = headers[#"Retry-After"]?   // use ? to avoid error when header is absent
```

The result is a plain record — field access works exactly like any other M record. Header names are case-sensitive and must match the wire value exactly, which is why `"Azure-AsyncOperation"` requires the `#"..."` quoting syntax.

## Implementation

### Azure Cost Management: Extracting `Location` and `Azure-AsyncOperation`

After POSTing a usage-detail export request, the API returns `HTTP 202` with two headers that drive the entire subsequent polling flow:

```powerquery
GetUsageDetailsData = (...) =>
    let
        // POST the export job request
        rawContent = QueueDataEx(postUsageDetailUrl, appType, true),

        metadata    = Value.Metadata(rawContent),
        headers     = metadata[Headers],

        // Location   → URL to poll until the download link is ready
        // Azure-AsyncOperation → URL to check intermediate job status
        locationUri = metadata[Headers][Location],
        statusUri   = metadata[Headers][#"Azure-AsyncOperation"],

        result = try DownLoadUsageDetailsData(locationUri, statusUri, appType)
                 otherwise handleError(body)
    in
        result;
```

The same pattern appears in the Price Sheet endpoint:

```powerquery
GetPriceSheetData = (...) =>
    let
        rawContent  = QueueData(billingAccountId, apiVersion, postPriceSheetUrl, billingProfileId, appType, disableArchive),

        metadata    = Value.Metadata(rawContent),
        headers     = metadata[Headers],
        locationUri = headers[Location],
        statusUri   = headers[#"Azure-AsyncOperation"],

        result = try DownloadPSData(locationUri, statusUri, appType)
                 otherwise CreateEmptyPriceSheetData()
    in
        result;
```

### Azure Cost Management: Safe `Location` Check with `Record.HasFields`

When a header may or may not be present depending on API version, use `Record.HasFields` before indexing to avoid a runtime error:

```powerquery
locationUri =
    if Record.HasFields(metaData[Headers], {"Location"})
    then metaData[Headers][Location]
    else null,

data =
    if locationUri <> null then
        Value.WaitFor(
            (i) =>
                let
                    data     = GetDataWithPollingExRIUsage(locationUri, appType),
                    response = if data <> null then data else null
                in
                    response,
            (i) => #duration(0, 0, 0, i * 0.5),
            3)
    else
        [status = "failed"]
```

### Anaplan: Reading `Response.Status` to Branch on Success vs. Error

Anaplan's generic `GetWebContents` wrapper uses `ManualStatusHandling` across a wide set of codes, then reads `Response.Status` from metadata to decide whether to return the parsed body or a structured error record:

```powerquery
GetWebContents = (url as text, configParams as list, optional returnRaw as logical, optional useCache as logical) =>
    let
        apiTokenValue = configParams{ConfigParamsIndex[apiToken]},
        source = Web.Contents(url, [
            Headers = [
                #"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue,
                #"x-aconnect-client" = Extension.LoadString("AConnectHeaderValue"),
                #"User-Agent" = Extension.LoadString("AConnectHeaderValue")
            ],
            ManualStatusHandling = {401, 404, 500, 501, 502, 503},
            Timeout = #duration(0, 0, Number.FromText(Extension.LoadString("RequestTimeoutMinutes")), 0)
        ]),

        buffered = Binary.Buffer(source),

        // Value.Metadata on the *original* (unbuffered) response carries the headers.
        // After Binary.Buffer the metadata is preserved on 'source'.
        actualResult =
            if Value.Metadata(source)[Response.Status] = 200 then
                (if returnRaw <> null and returnRaw then buffered else Json.Document(buffered))
            else
                [ err = [ status = Value.Metadata(source)[Response.Status] ] ]
    in
        actualResult;
```

### Anaplan: Token Endpoint — Acting on a Non-200 Status

The authentication flow uses `Response.Status` from the headers block to raise a specific credential error rather than a generic data-source error:

```powerquery
contents = Web.Contents(tokenEndpoint, [
    Headers = headers,
    Content = Text.ToBinary(body),
    ManualStatusHandling = {401},
    RelativePath = Extension.LoadString("AuthTokenPath")
]),
status = Value.Metadata(contents)[Response.Status],
tokenResponseJson =
    if status <> null and status = 201 then Json.Document(contents)[tokenInfo]
    else if status = 401 then error Extension.CredentialError("reason", "Invalid credentials")
    else null
```

## When to Use This Pattern

- The API signals async job creation via `HTTP 202` and returns the polling URL in `Location` or a custom header.
- You need to branch on the HTTP status code (e.g., treat `401` differently from `500`) without crashing the entire refresh.
- The API uses headers like `Retry-After`, `ETag`, or `X-RateLimit-Reset` to communicate metadata that should influence connector behavior.
- You are building a generic request wrapper that downstream functions rely on for uniform error records.

## Key Considerations

- **`ManualStatusHandling` is mandatory**: Without it, any non-2xx response raises a hard `Expression.Error` before your code can call `Value.Metadata`. Always include the status codes you need to inspect.
- **Quote header names with special characters**: `headers[#"Azure-AsyncOperation"]` and `headers[#"Retry-After"]` require the `#"..."` syntax because of the hyphen.
- **Use `?` for optional headers**: `headers[#"Retry-After"]?` returns `null` if the header is absent; `headers[#"Retry-After"]` throws a field-not-found error.
- **`Value.Metadata` reads the live response, not the buffered binary**: Call `Value.Metadata(response)` before or alongside `Binary.Buffer(response)`. The metadata is preserved on the original `response` reference even after buffering.
- **`Record.HasFields` for version-dependent headers**: APIs that add headers in newer versions can break older connector paths. Guard with `Record.HasFields(headers, {"Location"})` before indexing.
