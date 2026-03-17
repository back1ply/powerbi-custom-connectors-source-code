# Power Query Patterns: Multi-Tenant Client ID Detection

When a single connector must serve multiple tenants, cloud regions, or deployment environments (staging, production, regional clusters), hardcoding one `client_id` is insufficient. Each tenant's identity provider application registration carries its own `client_id`, and sending the wrong one will cause the token request to be rejected outright.

The Multi-Tenant Client ID Detection pattern solves this by maintaining a static lookup record of all known `client_id` values and selecting the correct one at runtime by inspecting the OAuth host URL the user has been routed to.

This pattern is applicable whenever the same connector binary is deployed against multiple IdP tenants — for example, a SaaS vendor that runs separate Okta or Auth0 app registrations per cloud region, or that uses different infrastructure environments (chimera, r2p2, amazon, google, regional clusters) that each require their own registered application.

## The Pattern

The implementation has two parts: a `ClientIds` record that acts as a named constant table, and a `PickClientId` helper function that performs the hostname-based selection.

### 1. The `ClientIds` Lookup Record

All registered `client_id` values are declared up front as fields on a single record. This keeps secrets co-located and easy to audit, while allowing field access by name rather than by positional index.

```powerquery
ClientIds = [
    chimera  = "hV0MX4pUs4AyFvjEe1TuQ2D4uCc1qKTn",
    r2p2     = "UqDxVaF80i2I0kDvREDQ8UqoOo7yeGz8",
    rke      = "qDAbpAhINMHv3S1G7N8kIHas4OOJCZgG",
    ast      = "ozy670BBq1j4dkSIJtKnA3jsmUL8etdp",
    gst      = "ky6c2RtYrLSQO1BY9izCVhFcQzvVg3bP",
    aus_stg  = "meUM999HWMA9R966XdMPNmyaJkP7j4lQ",
    aus_prod = "HhjwtBUkCnOw4c4U7s5YVlthhDTW0c27",
    ca_stg   = "kVBkaQFH3PXDehVs...",
    ca_prod  = "...",
    eu_prod  = "..."
];
```

### 2. The `PickClientId` Selector Function

`PickClientId` receives the OAuth host string extracted from the user's authorization URL and returns the correct `client_id` by checking for well-known substrings. The order of the `if` chain matters: more specific patterns (e.g., `au1a.app2-stg`) must appear before broader ones (e.g., `amazon`).

```powerquery
PickClientId = (oauthHost as text) =>
    let
        clientId =
            // Internal test environments — matched first because their hostnames
            // are substrings of more general patterns (e.g. "amazon")
            if Text.Contains(oauthHost, "chimera")               then ClientIds[chimera]
            else if Text.Contains(oauthHost, "r2p2")             then ClientIds[r2p2]
            else if Text.Contains(oauthHost, "amazon")           then ClientIds[ast]
            else if Text.Contains(oauthHost, "google")           then ClientIds[gst]
            // Regional staging/prod pairs — more specific before less specific
            else if Text.Contains(oauthHost, "au1a.app2-stg")    then ClientIds[aus_stg]
            else if Text.Contains(oauthHost, "au1a.app2.anaplan") then ClientIds[aus_prod]
            else if Text.Contains(oauthHost, "ca1a.app-stg.anaplan") then ClientIds[ca_stg]
            else if Text.Contains(oauthHost, "ca1a.app.anaplan")
              or Text.Contains(oauthHost, "ca2a.app.anaplan")
              or Text.Contains(oauthHost, "ca.app.anaplan")      then ClientIds[ca_prod]
            else if Text.Contains(oauthHost, "eu3.app.anaplan")  then ClientIds[eu_prod]
            // Default / production fallback
            else ClientIds[rke]
    in
        clientId;
```

### 3. Wiring Into `StartLogin` and `TokenMethod`

`PickClientId` is called in both the authorization URL construction (inside `StartLogin`) and the token request body (inside `TokenMethod`). The host is derived from the user-supplied `authUrl` field, with a fallback to the default production host.

```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        json         = Json.Document(resourceUrl),
        oauthAuthUrl = json[authUrl],
        // Resolve the host: use the custom authUrl if valid, otherwise default to prod
        oauthHost    = if oauthAuthUrl <> null and IsValidUrl(oauthAuthUrl)
                       then Uri.Parts(oauthAuthUrl)[Host]
                       else Uri.Parts(prodAuthHost)[Host],

        AuthorizeUrl = "https://" & oauthHost & "/auth/authorize?" & Uri.BuildQueryString([
            client_id            = PickClientId(oauthHost),   // <-- tenant-aware selection
            response_type        = "code",
            code_challenge_method = "plain",
            code_challenge       = codeVerifier,
            state                = state,
            redirect_uri         = redirect_uri
        ])
    in
        [
            LoginUri     = AuthorizeUrl,
            CallbackUri  = redirect_uri,
            WindowHeight = windowHeight,
            WindowWidth  = windowWidth,
            // Persist the resolved host so TokenMethod can call PickClientId again
            Context      = [ codeVerifier = codeVerifier, tokenHost = oauthHost ]
        ];

TokenMethod = (fieldValue, grantType, optional tokenHost, optional context) =>
    let
        token_host    = if (tokenHost <> null) then tokenHost else prodAuthHost,
        codeParameter = if (grantType = "authorization_code")
                        then [ code = fieldValue ]
                        else [ refresh_token = fieldValue ],
        query = codeParameter & [
            client_id    = PickClientId(token_host),           // <-- same logic at token time
            grant_type   = grantType,
            redirect_uri = redirect_uri
        ],
        full_token_uri = "https://" & token_host & "/oauth/token",
        Response       = Web.Contents(full_token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(query)),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept"       = "application/json"
            ]
        ])
    in
        Json.Document(Response);
```

## Why This Pattern Works

**Record-based lookup over switch tables.** A Power Query record is the natural equivalent of a constant map. Field access (`ClientIds[rke]`) is readable and refactor-safe — adding a new tenant means adding one field to `ClientIds` and one `else if` branch to `PickClientId`, with no changes elsewhere.

**Hostname substring matching over exact equality.** OAuth hosts often include environment prefixes or version suffixes (`us1a.app.anaplan.com`, `us2a.app.anaplan.com`). `Text.Contains` handles this gracefully without requiring an exact host enumeration.

**`client_id` must be consistent across both legs.** The authorization request and the token exchange must present the same `client_id`. Storing the resolved `tokenHost` in the `Context` record (passed through `StartLogin` → `FinishLogin` → `TokenMethod`) ensures both calls agree on which tenant registration to use, even if the connector is refreshed later by `Refresh` with a stale credential record.

**Default fallback prevents silent failure.** The final `else ClientIds[rke]` ensures a valid `client_id` is always produced. Without it, an unrecognized host would produce a null value and generate a cryptic HTTP 400 from the IdP rather than a clear connector error.
