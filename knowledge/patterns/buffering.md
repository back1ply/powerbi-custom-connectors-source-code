---
type: Power Query Pattern
title: Buffering tables, lists, and binaries
description: Binary response snapshots and buffered configuration lists.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Table|List|Binary)\.Buffer\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L590
  title: Anaplan/Anaplan.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L316
  title: Anaplan/Anaplan.pq
- id: traceRead
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L592
  title: Anaplan/Anaplan.pq
- id: serviceBuffer
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L153
  title: Anaplan/Anaplan.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/EQuIS/EQuIS.m#L93
  title: EQuIS/EQuIS.m
- id: deltaRead
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/DeltaSharing/DeltaSharing.pq#L462
  title: DeltaSharing/DeltaSharing.pq
review:
  content_sha256: 9681ec0b751e0db94f7f37af2388918bd747c272db9983fcf40614ca53e5081c
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    caller: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    traceRead: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    serviceBuffer: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    variant: 4222a9a4f2c6bdc3e5b80ec12420f7e0915afe1a7950f55b385ce927e71b7796
    deltaRead: aae79f0dc3f8db7e72f897197af3fac23cadb4ed969505e303138ca13e82654d
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Buffering tables, lists, and binaries

## Mechanism

`GetWebContents` (lines 590–611) makes one request, buffers the response, and reads the status from the unbuffered binding. `Binary.Buffer(source)` produces `buffered` (line 606), while `Value.Metadata(source)[Response.Status]` reads the status from `source` (line 607). A 200 response is parsed from `buffered`, or returned as binary when `returnRaw` is true (line 608). Any other status returns `[err = [status = ...]]` (line 609).[^example]

Unhandled HTTP error statuses follow the default `Web.Contents` behavior before the body branch. Other returned statuses can still reach the non-200 record result. The source retains `source` for metadata and `buffered` for parsing; buffering does not replace error handling.[^example]

`Anaplan.Connect` (lines 316–335) uses `List.Buffer` on a four-element list: the token, the API URL, the auth URL, and the trace context. The username/password branch resolves and validates the auth host (lines 325–329) before it builds the list (line 331). The OAuth branch uses the access token, an API URL, and an empty auth URL (line 332).[^caller]

The list stores `authUrl` from line 326, not `authUrlValidated` from line 328. The token comes from `authUrlValidated` (line 329), so when the fallback host is used, the stored value and the token's host differ. A search of Anaplan.pq finds no read of index 2 (`authUrl`), so the stored element is not used in this file.[^traceRead][^caller]

`serviceClientId`, inside `PickClientId`, likewise reads status from the original response and parses the buffered body. It maps manually handled 401 and 500–503 responses before parsing. Request errors caught by its `try`, including unhandled HTTP errors, become `Config API Unreachable`; the later `Config API Error` branch handles other returned non-200 statuses.[^serviceBuffer]

## Selection and dependencies

Consider buffering when repeated consumption or evaluation timing creates a concrete problem. The examples buffer a response binary or configuration list; they provide no measured speedup. HTTP error handling remains separate. Compare the original metadata and buffered body, then measure the target workload before copying the choice.[^example][^caller]

DeltaSharing's `SendRequest` shows the status-first order. It captures `Value.Metadata(resp)` before buffering (lines 471–473), so `HandleError` can branch on the status and still receive a buffered body.[^deltaRead]

EQuIS shows the parse-only form. `GetAuthorizationUrl` buffers and parses in one expression, `Json.Document(Binary.Buffer(Web.Contents(...)))` (line 97), and never reads the status.[^variant]

## Adaptation and failure paths

Do not read `Value.Metadata` from a buffered value unless you have checked it. This source reads it from the original binding: `source` at line 607, and `response` at line 173. Keep that order in any copy.

A list buffer holds the values it was built from. In `Anaplan.Connect`, the stored auth URL (line 331) is the pre-validation value. A later reader of index 2 could see a different host than the one that issued the token after the fallback at line 328. No such reader exists in this file, so verify before you reuse the list.[^caller][^traceRead]

EQuIS shows one explicit parse and no status check; that alone does not establish a benefit from buffering. Its field test sees responses returned without a transport error. A returned JSON record without the expected field reaches `Error.Unexpected`. Measure the workload before retaining or removing the buffer.[^variant]

Buffering a large body holds it in memory. The source does not measure this, so do not claim a speed gain without a test on the target workload.

## Validation checklist

- Confirm that each status read uses the original binding, not the buffered value.
- Keep status branches after buffering, and list each code you must map in `ManualStatusHandling`.
- Check each list-buffer element against its consumer, including the element that holds `authUrl`.
- Identify the evaluation or reuse problem a buffer addresses, and measure its effect.
- Test a 2xx response without the expected field, and a 4xx response, against each buffered read.

## Examples

Binary snapshot and status read, Anaplan lines 590–611:

<!-- source: example -->
```powerquery
GetWebContents = (url as text, configParams as list, optional returnRaw as logical, optional useCache as logical) => 
    let
        apiTokenValue = configParams{ConfigParamsIndex[apiToken]},
        
        // Get trace context from session (created once at connection start)
        traceContext = configParams{ConfigParamsIndex[traceContext]},

        // Build headers with traceparent for Grafana (use traceContext directly without updating)
        headers = TraceContext[InjectHeaders](
            [#"Authorization" = Extension.LoadString("AnaplanAuthTokenPrefix") & apiTokenValue, 
             #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"),  #"User-Agent"=Extension.LoadString("AConnectHeaderValue")],
            traceContext),
        cacheControl = if useCache <> null and not useCache then Number.ToText(Number.Random()) else "",
        source = Web.Contents(url, [Headers = headers, 
                ManualStatusHandling = {401, 404, 500, 501, 502, 503},
                Timeout = #duration(0, 0, Number.FromText(Extension.LoadString("RequestTimeoutMinutes")), 0)]), 
        buffered = Binary.Buffer(source),
        actualResult = if Value.Metadata(source)[Response.Status] = 200 then 
            (if returnRaw <> null and returnRaw then buffered else Json.Document(buffered))
            else [ err = [status =  Value.Metadata(source)[Response.Status]]]
    in
        actualResult;
```

List buffers in a connect function, Anaplan lines 316–335:

<!-- source: caller -->
```powerquery
Anaplan.Connect = (apiUrl as text, authUrl as text) as table =>
    let 
        // Create trace context ONCE for entire session
        traceContext = TraceContext[CreateContext]("PowerBi"),
        trimmedApiUrl = Text.Trim(apiUrl),
        trimmedAuthUrl = Text.Trim(authUrl),
        credential = Extension.CurrentCredential() as record,
        configParams = if Record.HasFields(credential, "Username") then
          let
              apiUrl = if trimmedApiUrl <> null and IsValidUrl(trimmedApiUrl) then (trimmedApiUrl & Extension.LoadString("APIVersionPath")) else prodApiHost & Extension.LoadString("APIVersionPath"),
              authUrl = if trimmedAuthUrl <> null and IsValidUrl(trimmedAuthUrl) then trimmedAuthUrl else prodAuthHost,
              apiTokenTry = GetApiToken(authUrl, false),
              authUrlValidated = if apiTokenTry <> null then authUrl else if GetApiToken(prodAuthHost, false) <> null then prodAuthHost else Extension.CurrentCredential(true),
              apiToken = GetApiToken(authUrlValidated, false)
          in
              List.Buffer({apiToken[tokenValue], apiUrl, authUrl, traceContext})
        else List.Buffer({Extension.CurrentCredential()[access_token], trimmedApiUrl & Extension.LoadString("APIVersionPath"), "", traceContext}),
        source = GetWorkspacesTable(configParams)
    in 
        source as table;
```

Parse-only buffer, EQuIS lines 93–103:

<!-- source: variant -->
```powerquery
GetAuthorizationUrl = (
  baseUri as text
) as text =>
  let
    apiResponse = Json.Document(Binary.Buffer(Web.Contents(baseUri & "/api/config/anon")))
  in
    // get the authority
    if (Record.HasFields(apiResponse, "azureActiveDirectory")) = true then
      apiResponse[azureActiveDirectory][authority] & "/oauth2/authorize"
    else
      error Error.Unexpected(Extension.LoadString("Authentication.Error"));
```

[^example]: Anaplan/Anaplan.pq lines 590–611 (`GetWebContents`): `ManualStatusHandling` (line 604), the buffered body (line 606), the status read from `source` (line 607), and the parse or error branch (lines 608–609).
[^caller]: Anaplan/Anaplan.pq lines 316–335 (`Anaplan.Connect`): the username/password branch (lines 323–331), the OAuth branch (line 332), and the two `List.Buffer` calls (lines 331–332).
[^traceRead]: Anaplan/Anaplan.pq lines 592–595 (`GetWebContents`): reads the token element (line 592) and the trace-context element (line 595) from the configuration list. A search of the file finds no read of index 2 (`ConfigParamsIndex[authUrl]`).
[^serviceBuffer]: Anaplan/Anaplan.pq lines 153–194 (`serviceClientId` inside `PickClientId`): `Binary.Buffer(response)` (line 172), the status read from `response` (line 173), and `Json.Document(buffered)` (line 194).
[^deltaRead]: DeltaSharing/DeltaSharing.pq lines 462–473 (`SendRequest`): `Value.Metadata(resp)` (line 471) before `Binary.Buffer(resp)` (line 473).
[^variant]: EQuIS/EQuIS.m lines 93–103 (`GetAuthorizationUrl`): `Json.Document(Binary.Buffer(Web.Contents(...)))` (line 97), the field check (line 100), and the generic error (line 103).
