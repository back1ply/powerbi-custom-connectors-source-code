---
type: Power Query Pattern
title: Structured errors and HTTP status handling
description: Explicit API errors and the limits of handled-status branches.
category: Schema and errors
tags: [schema-and-errors]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Error\.Record\s*\(|ManualStatusHandling\s*=)']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L129
  title: Asana/Asana.m
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L253
  title: GoogleSheets/GoogleSheets.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L173
  title: Asana/Asana.m
- id: errortable
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L735
  title: Anaplan/Anaplan.pq
review:
  content_sha256: 70a64577d602e7788d148aed16ea42acb1b9ac5bf5b950be08f0ed4ce1b54ff5
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    variant: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
    caller: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    errortable: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Structured errors and HTTP status handling

## Mechanism

Asana's login callback parses `Uri.Parts(callbackUri)[Query]` and checks whether the query has both `error` and `error_description`. If it does, the callback raises `Error.Record(parts[error], parts[error_description], parts)`. Otherwise it passes `parts[code]` to `TokenMethod` (lines 129–140).[^example]

`TokenMethod` sends `ManualStatusHandling = {400}` so that a 400 body reaches the parser, then applies the same two-field check to the parsed body (lines 157–169). When both fields are present it raises `Error.Record(body[error], body[error_description], body)`. Otherwise it returns the body as the token result.[^example]

`GetTasks` handles status 403 the same way, through its own options record and its own record check (lines 179–188).[^caller] Each call carries its own status list and body check. Nothing in the file centralizes them.

The GoogleSheets connector uses a different style. Its callback checks one field, `error`, and raises `DataSource.Error` (line 31). Its `Web.JsonContents` turns a listed error status into an `Error.Record` error through `Web.ErrorResponse` (lines 253–270).[^variant]

## Choosing an error strategy

Use a two-field check for provider errors that return both `error` and `error_description`, as Asana does. Use a one-field check and a status list when the provider's error body is simpler and the status codes are known in advance, as GoogleSheets does.

Anaplan's `ErrorTable` is a different kind of helper. It returns a one-row table keyed by an error category rather than raising an error (lines 735–749).[^errortable] Use it for display in a navigation table, not as a replacement for `error`.

## Adaptation and failure paths

Read each condition as written. A payload that contains only one of the two expected fields fails the check. In `FinishLogin` that sends control to `parts[code]`; when no `code` is present, the access fails with a missing-field error instead of the provider's message (lines 135–138). In `TokenMethod` the same payload is returned as a successful token (lines 166–169), and the failure appears later, when `RefreshToken` reads `body[access_token]` (line 196). Add incomplete error payloads to your response-contract tests. The presence of `Error.Record` in the code is not coverage.[^example]

The third argument to `Error.Record` is the whole parsed record. Here it is `parts` or `body`, so any field in that record can surface in the error detail. Pass only the fields you intend to show, and keep token values out of messages.[^example]

`ErrorTable` looks up its first argument in rows numbered 1 to 5. Its fallback key 0 is also absent, so evaluating that fallback lookup fails. The `errors.generic` record and `errorStatus` normalization are unused bindings; neither repairs the lookup. The call with key 0 at line 398 is in a branch whose preceding construction supplies a `models` list. Keep these latent paths distinct from errors reached by current callers.[^errortable]

Do not turn every unexpected payload into an empty result. Decide whether the error should request fresh credentials, explain a service failure, or stop parsing a malformed response. The HTTP-status side of these decisions is covered in [web-request failure handling](web-requests.md); see also [GraphQL errors](graphql.md) and [diagnostics](diagnostics.md) for surfacing details safely.

## Examples

<!-- source: example -->
```powerquery
FinishLogin = (context, callbackUri, state) =>
    let
        // parse the full callbackUri, and extract the Query string
        parts = Uri.Parts(callbackUri)[Query],
        // if the query string contains an "error" field, raise an error
        // otherwise call TokenMethod to exchange our code for an access_token
        result = if (Record.HasFields(parts, {"error", "error_description"})) then
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod("authorization_code", "code", parts[code], context)
    in
        result;

TokenMethod = (grantType, tokenField, code, context) =>
    let
        queryString = [
            grant_type = grantType,
            redirect_uri = redirect_uri,
            client_id = client_id
        ],
        queryWithCodeVerifier =
            if Record.HasFields(context, "code_verifier") then
                Record.AddField(queryString, "code_verifier", context[code_verifier])
            else queryString,

        queryWithCode = Record.AddField(queryWithCodeVerifier, tokenField, code),


        tokenResponse = Web.Contents(api_url & "/powerbi/auth", [
            Content = Text.ToBinary(Uri.BuildQueryString(queryWithCode)),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ],
            ManualStatusHandling = {400}
        ]),
        body = Json.Document(tokenResponse),
        result = if (Record.HasFields(body, {"error", "error_description"})) then
                    error Error.Record(body[error], body[error_description], body)
                 else
                    body
    in
        result;
```

The GoogleSheets variant handles the error status and body in one place:

<!-- source: variant -->
```powerquery
Web.JsonContents = (url)  =>
    let
        response = Web.Contents(url, [ManualStatusHandling = ApiErrorStatusCodes]),
        jsonResponse = Json.Document(response) meta Value.Metadata(response),
        responseStatusCode = Record.FieldOrDefault(Value.Metadata(jsonResponse), "Response.Status", 0)
     in
        if List.Contains(ApiErrorStatusCodes, responseStatusCode) then Web.ErrorResponse(responseStatusCode,jsonResponse) else jsonResponse;

Web.ErrorResponse = (responseCode as number, jsonResponse as record) => 
    let 
        detail = [
        errorstatus = jsonResponse[error][status],
        errormessage = jsonResponse[error][message],
        errorcode = jsonResponse[error][code]
        ],        
        errorResponse = error Error.Record("DataSource.Error", jsonResponse[error][message], detail)
    in
        errorResponse;
```

[^example]: Asana/Asana.m lines 129–171: FinishLogin's two-field check (lines 135–138), TokenMethod's `ManualStatusHandling = {400}` (line 163), the parsed-body check (lines 166–169), and the returned body on the success path. `RefreshToken` (lines 192–196) reads `body[access_token]` from that path.
[^variant]: GoogleSheets/GoogleSheets.pq line 31 checks the callback `error` field; lines 253–259 define `Web.JsonContents` with the status list from line 7; lines 261–270 define `Web.ErrorResponse`.
[^caller]: Asana/Asana.m lines 173–190: GetTasks's `ManualStatusHandling={403}` (line 179) and the record check at line 185.
[^errortable]: Anaplan/Anaplan.pq lines 735–749 define `ErrorTable`. Lines 737–742 define six error records, including the status-0 record at line 737; line 744 builds the table from only the five records with statuses 1 to 5; lines 746–747 perform the lookup and the fallback to key 0. Lines 391–398 show `resp` always carries `models`, so the key-0 call at line 398 is unreachable.
