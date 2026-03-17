# Power Query Patterns: Conditional OAuth Host Resolution

Some connectors must support user-configurable or environment-specific OAuth endpoints — for example, a staging environment that shares the same connector binary as production, or a multi-region SaaS platform where each region hosts its own identity provider.

The Conditional OAuth Host Resolution pattern validates the user-supplied OAuth host URL at data-source-path parse time and falls back to a hardcoded production default if the custom host is absent, null, or malformed. This keeps the connector functional for the common case while still supporting advanced deployments that route to non-standard endpoints.

This pattern differs from simple URL string concatenation: the host is resolved through `Uri.Parts` so that malformed URLs fail visibly rather than producing a silently wrong token endpoint. The connector stores the resolved host in the OAuth `Context` record so that both the authorization request and every subsequent token refresh agree on which endpoint to use.

## The Pattern

### 1. Host Resolution in `StartLogin`

The connector encodes connection parameters (including an optional `authUrl`) as a JSON object in `resourceUrl`. `StartLogin` deserializes this and resolves the effective OAuth host with a guarded conditional.

```powerquery
// Hardcoded fallback — used when no custom authUrl is provided
prodAuthHost = "https://us1a.app.anaplan.com";

IsValidUrl = (url as text) =>
    // Uri.Parts returns null for malformed input; use that as the validity signal
    Uri.Parts(url)[Host] <> null and Uri.Parts(url)[Host] <> "";

StartLogin = (resourceUrl, state, display) =>
    let
        json         = Json.Document(resourceUrl),
        oauthAuthUrl = json[authUrl],

        // Resolve the OAuth host:
        //   - If the caller supplied a non-null, well-formed URL → extract its host.
        //   - Otherwise → fall back to the production default.
        oauthHost = if oauthAuthUrl <> null and IsValidUrl(oauthAuthUrl)
                    then Uri.Parts(oauthAuthUrl)[Host]
                    else Uri.Parts(prodAuthHost)[Host],

        AuthorizeUrl = "https://" & oauthHost & "/auth/authorize?" & Uri.BuildQueryString([
            client_id    = PickClientId(oauthHost),
            response_type = "code",
            state        = state,
            redirect_uri = redirect_uri
        ])
    in
        [
            LoginUri     = AuthorizeUrl,
            CallbackUri  = redirect_uri,
            WindowHeight = windowHeight,
            WindowWidth  = windowWidth,

            // CRITICAL: persist the resolved host so FinishLogin and Refresh
            // can direct token requests to the same endpoint that was authorized
            Context = [ tokenHost = oauthHost ]
        ];
```

### 2. Propagating the Resolved Host Through `FinishLogin`

`FinishLogin` retrieves the persisted host from `Context` and forwards it to `TokenMethod` using the optional-field accessor (`?`). If somehow the context is absent — for example, in older credential records created before this field existed — the `?` operator returns `null` safely rather than raising an error.

```powerquery
FinishLogin = (context, callbackUri, state) =>
    let
        parts = Uri.Parts(callbackUri)[Query]
    in
        // Pass the resolved tokenHost through; TokenMethod will fall back to prod if null
        TokenMethod(parts[code], "authorization_code", context[tokenHost]?, context);
```

### 3. Defensive Fallback in `Refresh`

When Power BI calls `Refresh` to obtain a new access token using the stored `refresh_token`, the resolved host must be recovered from the credential record. A guard with `Record.HasFields` prevents a crash if the field is missing in legacy credentials, substituting a sentinel value that surfaces a clear error message rather than silently hitting the wrong endpoint.

```powerquery
TokenHostNotFoundMessage = "TOKEN_HOST_NOT_FOUND";

Refresh = (clientApplication, dataSourcePath, oldCredential) =>
    let
        // Recover the host from the stored credential, or raise a clear sentinel
        token_host = if Record.HasFields(oldCredential, "tokenHost")
                        and oldCredential[tokenHost] <> null
                     then oldCredential[tokenHost]
                     else TokenHostNotFoundMessage,
        result = TokenMethod(oldCredential[refresh_token], "refresh_token", token_host)
    in
        result;
```

### 4. `TokenMethod` — Final Resolution and Token Fetch

`TokenMethod` receives the resolved host as an optional parameter and applies one last fallback to `prodAuthHost` before building the token URL. This makes `TokenMethod` callable both from `FinishLogin` (with a known host) and in unit-test scenarios where no host is provided.

```powerquery
prodAuthHost = "https://us1a.app.anaplan.com";

TokenMethod = (fieldValue, grantType, optional tokenHost, optional context) =>
    let
        // Last-resort fallback: if no host was threaded through, use production
        token_host    = if (tokenHost <> null) then tokenHost else prodAuthHost,

        codeParameter = if (grantType = "authorization_code")
                        then [ code = fieldValue ]
                        else [ refresh_token = fieldValue ],

        full_token_uri = "https://" & token_host & "/oauth/token",

        Response = Web.Contents(full_token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(
                codeParameter & [
                    client_id    = PickClientId(token_host),
                    grant_type   = grantType,
                    redirect_uri = redirect_uri
                ]
            )),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept"       = "application/json",
                #"X-AUTH-TOKEN" = "true"
            ]
        ]),
        Parts = Json.Document(Response)
    in
        // Surface IdP errors as structured Power Query errors rather than letting
        // the connector return a partial record silently
        if (Parts[error]? <> null)
        then error Error.Record(Parts[error], Parts[message]?)
        else Parts & [ tokenHost = token_host ];  // persist host for next Refresh call
```

### 5. `try … otherwise` for Graceful Navigation Degradation

A related application of the conditional host resolution pattern appears in navigation table construction, where individual project or folder loads should not abort the entire nav tree if one item is temporarily unreachable.

```powerquery
// AssembleViews pattern: load each project's sub-tree defensively;
// return null for any project whose endpoint is unavailable rather than
// crashing the entire navigation table.
projectsAddData = Table.AddColumn(
    projectsRenameColumns,
    "Data",
    each try GetProjectFolders(resourceUrl, [Key], [Name]) otherwise null
)
```

## Why This Pattern Works

**`Uri.Parts` as a URL validator.** Rather than writing a regex or length check, `Uri.Parts` parses the URL according to RFC 3986. If it returns a non-empty `[Host]`, the URL is well-formed enough to use. This is safer than trusting the user-supplied string directly in string concatenation.

**Host resolved once, stored once.** Resolving in `StartLogin` and persisting in `Context` and later in the credential record (`tokenHost`) means the resolution logic runs exactly once per login. Every subsequent call — `FinishLogin`, `Refresh`, `TokenMethod` — simply reads the stored value. This eliminates the risk of the host resolving differently across calls if environment state changes.

**`Record.HasFields` for backward compatibility.** Credential records serialized by older connector versions will not contain `tokenHost`. Guarding with `Record.HasFields` before accessing the field prevents `Expression.Error: The field 'tokenHost' of the record wasn't found` from surfacing to end users on connector upgrade.

**Returning the host in the token response record.** `TokenMethod` appends `tokenHost` to the record it returns (`Parts & [ tokenHost = token_host ]`). Power BI stores the entire token response record as the credential, so the host is automatically preserved for future `Refresh` calls without any additional persistence logic.
