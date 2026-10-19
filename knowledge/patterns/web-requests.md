---
type: Power Query Pattern
title: Web requests and relative paths
description: Web request options and explicit HTTP response branches.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:42Z'
detect: [\bRelativePath\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L655
  title: Anaplan/Anaplan.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L253
  title: GoogleSheets/GoogleSheets.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L173
  title: Asana/Asana.m
- id: getweb
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L590
  title: Anaplan/Anaplan.pq
review:
  content_sha256: c3260678ec920338ae9bdb7988cede32077a4856ba9a257c1b989ab8aecc46a7
  sources_sha256:
    example: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    variant: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
    caller: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    getweb: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Web requests and relative paths

## Mechanism

Anaplan's `GetApiToken` requests a token from `authUrl`. It sets `RelativePath` from a resource string (`Extension.LoadString("AuthTokenPath")`, line 667). Its `Web.Contents` options combine a binary body, headers, a `Query` record, and `ManualStatusHandling = {401}` in one record (lines 664–668). When `isRefresh` is true, it uses a different header record that adds cache-control headers (lines 658–659).[^example]

Inside `getToken`, status 201 reads `tokenInfo`, status 401 raises `Extension.CredentialError`, and other statuses that reach the branch return null. `tokenResponse = try getToken() otherwise null` catches errors from that call. However, the outer `GetApiToken` declares `as record`. A null result violates that non-nullable return contract under M's [function rules](https://learn.microsoft.com/en-us/powerquery-m/m-spec-functions#parameters), outside the inner `try`. The caller's `apiTokenTry <> null` test does not repair that contract. When adapting, choose a nullable return with explicit caller handling or a raised error; test 401, 500, and a 201 body without `tokenInfo`.[^example]

Anaplan's generic path works differently. `GetWebContents` lists six statuses for manual handling, 401, 404, 500, 501, 502 and 503 (line 604). Other error statuses are expected to raise by default before the record branch is reached. For the listed statuses and other non-200 codes that reach it, the function returns `[err = [status = ...]]` (lines 607–609). `GetAllModels` then treats a record without `models` as an empty page (line 373), so a handled non-200 response in the model listing, including 401, becomes an empty list rather than an error. `GetWorkspacesTable` wraps its call in `try ... otherwise EmptyNavTable()` (line 344). Whether that fallback catches a failure depends on when the table is evaluated, so verify it with a 401 response.[^getweb]

## Choosing an error strategy

Use the GoogleSheets style when the API returns a consistent JSON error body. It lists its error statuses (line 7) and turns the body into `Error.Record` (lines 253–270).[^variant]

Use Asana's style when one status needs its body read and everything else should raise. `GetTasks` lists only 403 (line 179), so other failures keep the platform default.[^caller]

Use the Anaplan record style only when every caller checks for `err`. The `GetAllModels` path shows that a caller that skips the check quietly produces an empty result.[^getweb]

## Adaptation and failure paths

Read the complete request before reusing options. The `Query` value at line 668 is a literal string, not a credential taken from the user, so confirm the API's required header, body, and authentication before you substitute anything.[^example]

GoogleSheets' `Web.JsonContents` runs `Json.Document` before its status test (parse at line 256, status test at line 259). A non-JSON error page, such as an HTML 503, therefore fails in the parser and never reaches the status branch. Its `responseCode` argument is also unused in `Web.ErrorResponse` (lines 261–268). Status 401 is not in its list, so it follows the platform default.[^variant]

Asana's error check requires both `error` and `error_description` (line 185). A 403 body that is a record with only one of those fields falls through to `ProcessResponse`, which declares `(Json as list)` (line 200). The mismatch then appears as a type error, not as the provider's message.[^caller]

For each failure, decide whether it should ask for fresh credentials (`Extension.CredentialError`), report a service error, or stop parsing. A silent `null` or an empty table is none of these, so a failure should not look like "no data". See [credential access](credentials.md) for the credential side, [structured errors](errors.md) for error records, and [response metadata](response-metadata.md) for reading `Response.Status`.

## Examples

<!-- source: example -->
```powerquery
GetApiToken = (authUrl as text, isRefresh as logical, optional noCache as number) as record =>
    let
        body = "[]",
        headers = if isRefresh then [#"CacheRemoval" = Number.ToText(noCache), #"Cache-Control" = "no-cache, no-store, must-revalidate", #"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue")] 
            else [#"x-aconnect-client"=Extension.LoadString("AConnectHeaderValue"), #"User-Agent"=Extension.LoadString("AConnectHeaderValue")],
        tokenResponse = try getToken() otherwise null,
        
        getToken = () =>
            let
                contents = Web.Contents(authUrl, 
                    [ Headers = headers, Content=Text.ToBinary(body), 
                    ManualStatusHandling = {401},
                    RelativePath = Extension.LoadString("AuthTokenPath"),
                    Query=[Authorization="Basic encoded_username:password"]]),
                status = Value.Metadata(contents)[Response.Status], 
                tokenResponseJson = if status <> null and status = 201 then Json.Document(contents)[tokenInfo] 
                    else if status = 401 then error Extension.CredentialError("reason", "Invalid credentials") 
                    else null
            in
                tokenResponseJson
    in
        tokenResponse;
```

The GoogleSheets variant converts the error body into an error record:

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

Asana's `GetTasks` handles only the 403 status and checks the body for an error record:

<!-- source: caller -->
```powerquery
GetTasks = (qp as record) as table =>
    let
        access_token = RefreshToken(),
        Source = Web.Contents("https://reporting-api.integrations.asana.plus", [
            Headers=[Authorization = "Bearer " & access_token ],
            Timeout=#duration(0, 2, 0, 0),
            ManualStatusHandling={403},
            ManualCredentials = true,
            Query = qp,
            RelativePath = "/v1/data"
        ]),
        Json = Json.Document(Source),
        res =  if Value.Is(Json, type record) and (Record.HasFields(Json, {"error", "error_description"})) then
                    error Error.Record(Json[error], Json[error_description], Json)
               else
                 ProcessResponse(Json)
    in
        res;
```

[^example]: Anaplan/Anaplan.pq lines 655–676: the `GetApiToken` header choice (lines 658–659), the `Web.Contents` options (lines 664–668), the status dispatch (lines 669–672), and the `try` binding (line 660). The caller's null test is at lines 327–328.
[^getweb]: Anaplan/Anaplan.pq lines 590–611 define `GetWebContents`; line 373 maps a page without `models` to `{}` in `GetAllModels`; lines 341–344 wrap the workspace listing in `try ... otherwise EmptyNavTable()`.
[^variant]: GoogleSheets/GoogleSheets.pq line 7 defines `ApiErrorStatusCodes`; lines 253–259 define `Web.JsonContents` (the `Json.Document` parse at line 256, the status test at line 259); lines 261–270 define `Web.ErrorResponse`.
[^caller]: Asana/Asana.m lines 173–190 define `GetTasks`: the options at lines 176–183 (status list at line 179), the record-only error check at line 185, and `ProcessResponse` expecting a list at line 200.
