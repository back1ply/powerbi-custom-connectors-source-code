---
type: Power Query Pattern
title: OAuth2 login and token refresh
description: OAuth2 callbacks and refresh-token exchange.
category: Authentication
tags: [authentication]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:StartLogin|FinishLogin|Refresh)\s*=']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L48
  title: GoogleSheets/GoogleSheets.pq
- id: start
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L9
  title: GoogleSheets/GoogleSheets.pq
- id: callback
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/GoogleSheets/GoogleSheets.pq#L28
  title: GoogleSheets/GoogleSheets.pq
- id: anaplan-refresh
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Anaplan/Anaplan.pq#L92
  title: Anaplan/Anaplan.pq
- id: asana-refresh
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L173
  title: Asana/Asana.m
review:
  content_sha256: 0d69eb74af9dbd6b0622f0b1eb6f519c6180fd7efe6f5ad8c6062e24798eba3e
  sources_sha256:
    example: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
    start: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
    callback: 519949be7c5aeca7a8a3247800070971191df416b28a9b3db18b8a8cdeac7dd9
    anaplan-refresh: e706d3009d50e259a16ea6deef1d58f1cf5d1b23a9800cc12e2384266b56221f
    asana-refresh: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# OAuth2 login and token refresh

## Mechanism

GoogleSheets registers `StartLogin`, `FinishLogin` and `Refresh` in its OAuth record (lines 64–76). `StartLogin` builds a Google authorization URL with the client identifier, a read-only spreadsheets scope, `access_type = "offline"`, `prompt = "consent"`, `state`, and the callback URL. It returns `Context = null`, so this flow keeps no verifier between the two steps.[^start]

`FinishLogin` checks the callback query for an `error` field first and raises `Error.Record("DataSource.Error", ...)` when it is present. Otherwise it posts the `code` to the token endpoint with `grant_type = "authorization_code"` and parses the JSON response.[^callback]

`Refresh` is a separate POST with `grant_type = "refresh_token"`, the stored refresh token, the client identifier and the client secret. It returns the parsed response without further checks.[^example] The secret in this archive is `<redacted>` (line 5), so the values here are a reading aid, not a working registration.[^start]

## Choosing this flow

GoogleSheets illustrates authorization-code and refresh-token exchanges. Microsoft's [OAuth guidance](https://learn.microsoft.com/en-us/power-query/handling-authentication#implementing-an-oauth-flow) advises against confidential secrets in client-side OAuth flows because users can inspect the extension or its traffic. Asana supplies a [PKCE](pkce.md) comparison and carries its verifier in `Context`. It registers no `Refresh` callback; `GetTasks` explicitly calls `RefreshToken()` in its request path.[^asana-refresh]

Anaplan registers `Refresh = (clientApplication, dataSourcePath, oldCredential)`, while GoogleSheets uses two arguments. Microsoft documents both [original and advanced callback signatures](https://learn.microsoft.com/en-us/power-query/handling-authentication#original-oauth-signatures). The advanced form receives the previous credential record; the original form receives the refresh token. Keep the callback body aligned with the selected signature.[^anaplan-refresh][^example]

## Adaptation and failure paths

The error branch checks only the `error` field. A callback that carries a `code` but a different failure field continues to the token request, and a successful browser redirect is not evidence that the exchange succeeded.[^callback] The `state` value passed to `StartLogin` is never compared with the callback in this file. The archive does not show whether the host validates it, so review callback-state handling separately before adopting the flow.[^callback]

Neither the token request nor `Refresh` sets `ManualStatusHandling`, so a non-2xx token response follows the platform's default status handling. Check the message your users see for an expired refresh token before relying on it.[^example]

`Refresh` returns the parsed body unchanged, including any fields the provider supplies. It has no local branch to preserve an old refresh token when the response omits one. Test token rotation and omission with the host; returning the full record is not evidence that those fields are discarded.[^example]

Keep `CallbackUrl` identical in the authorization request and the token request. This file uses the same constant for the authorization `redirect_uri` (line 18), the `CallbackUri` (line 22), and the token exchange (line 40).[^callback]

See [credential access](credentials.md) for how saved credentials reach a data source.

## Examples

<!-- source: example -->
```powerquery
Refresh = (resourceUrl, refresh_token) =>
    let
        Response = Web.Contents("https://oauth2.googleapis.com/token", [
            Content = Text.ToBinary(Uri.BuildQueryString([
                grant_type = "refresh_token",
                client_id = ClientId,
                client_secret = ClientSecret,
                refresh_token = refresh_token
                ])),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"]]),
        Parts = Json.Document(Response)
    in
        Parts;
```

The login start builds the authorization URL and returns no verifier:

<!-- source: start -->
```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        AuthorizeUrl = "https://accounts.google.com/o/oauth2/v2/auth?" & Uri.BuildQueryString([
            client_id = ClientId,
            scope = "https://www.googleapis.com/auth/spreadsheets.readonly",
            response_type = "code",
            access_type = "offline",
            prompt = "consent",
            state = state,
             redirect_uri = CallbackUrl])
    in
        [
            LoginUri = AuthorizeUrl,
            CallbackUri = CallbackUrl,
            WindowHeight = 780,
            WindowWidth = 480,
            Context = null
        ];
```

The callback checks for a provider error, then exchanges the code:

<!-- source: callback -->
```powerquery
FinishLogin = (context, callbackUri, state) =>
    let
        Parts = Uri.Parts(callbackUri)[Query],
        Response = if (Parts[error]? <> null) then
                      error Error.Record("DataSource.Error", Parts[error])
                   else
                         Web.Contents("https://oauth2.googleapis.com/token", [
                             Content = Text.ToBinary(Uri.BuildQueryString([
                             client_id = ClientId,
                             client_secret = ClientSecret,
                             grant_type = "authorization_code",
                             code = Parts[code],
                             redirect_uri = CallbackUrl])),
        Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"]]),
        token = Json.Document(Response)
    in
        token;
```

[^start]: GoogleSheets/GoogleSheets.pq lines 9–26 build the authorization URL and return `Context = null`; line 5 holds the redacted secret, and lines 64–76 register OAuth.
[^callback]: GoogleSheets/GoogleSheets.pq lines 28–46: the `error` check at line 31, the authorization-code exchange at lines 34–43, and the shared `CallbackUrl` at lines 18, 22 and 40. `FinishLogin` takes a `state` argument (line 28) but its body never reads it.
[^example]: GoogleSheets/GoogleSheets.pq lines 48–62 define `Refresh`. Its `Web.Contents` options contain only `Content` and `Headers`, with no `ManualStatusHandling`.
[^anaplan-refresh]: Anaplan/Anaplan.pq lines 92–97 define a three-argument `Refresh` that reads `oldCredential[tokenHost]`.
[^asana-refresh]: Asana/Asana.m lines 83–89 register OAuth without a `Refresh` field; lines 173–198 call `RefreshToken()` from `GetTasks` and define it.
