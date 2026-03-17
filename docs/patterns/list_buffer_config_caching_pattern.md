# Power Query Patterns: `List.Buffer` Config Caching

Power Query is a lazy, demand-driven evaluation engine. When a connector fetches an API token or resolves a base URL at the start of a session, the M engine may re-evaluate that expression every time a downstream table or function references it — potentially firing multiple HTTP requests for the same token within a single refresh.

`List.Buffer` forces **eager evaluation** of a list, pinning the results in memory for the lifetime of the current evaluation context. Wrapping a small config list (token, base URL, auth host) in `List.Buffer` guarantees the expensive HTTP call for the token fires exactly once, and all subsequent references read from the in-memory buffer.

## The `List.Buffer({token, url, ...})` Pattern

### 1. The core pattern

_Note: This is an exact extraction from the Anaplan connector._

```powerquery
// Anaplan Connector.pq — top-level entry point
AnaplanImpl = (optional apiUrl as text) =>
    let
        // Resolve auth mode once
        isOAuth = Extension.CurrentCredential()[AuthenticationKind] = "OAuth2",

        configParams =
            if not isOAuth then
                let
                    // Basic auth: fetch an API token over HTTP (expensive)
                    authUrl            = ...,
                    apiTokenTry        = GetApiToken(authUrl, false),
                    authUrlValidated   = if apiTokenTry <> null then authUrl
                                        else if GetApiToken(prodAuthHost, false) <> null then prodAuthHost
                                        else Extension.CurrentCredential(true),
                    apiToken           = GetApiToken(authUrlValidated, false)
                in
                    // List.Buffer pins {tokenValue, apiUrl, authUrl} in memory.
                    // GetWorkspacesTable — and every function it calls — can index
                    // configParams{0}, configParams{1}, configParams{2} repeatedly
                    // without re-running GetApiToken.
                    List.Buffer({apiToken[tokenValue], apiUrl, authUrl})
            else
                // OAuth: access_token already cached by the framework;
                // still buffer so the URL resolution is not repeated per-table.
                List.Buffer({
                    Extension.CurrentCredential()[access_token],
                    apiUrl & Extension.LoadString("APIVersionPath")
                }),

        source = GetWorkspacesTable(configParams)
    in
        source as table;
```

### 2. Accessing buffered values downstream

Because `configParams` is a plain `list`, downstream functions index into it positionally:

```powerquery
GetWorkspacesTable = (configParams as list) =>
    let
        token   = configParams{0},   // tokenValue or access_token
        baseUrl = configParams{1},   // resolved API base URL
        // authUrl = configParams{2} // only present in basic-auth branch

        headers = [
            #"Authorization" = "Bearer " & token,
            #"Content-Type"  = "application/json"
        ],
        response = Web.Contents(baseUrl & "/workspaces", [Headers = headers])
    in
        Json.Document(response);
```

### 3. Why a `list`, not a `record`

A `record` would be more readable (`config[token]` vs `config{0}`), but `List.Buffer` only exists for lists. `Table.Buffer` exists for tables. There is no `Record.Buffer`. The list convention is therefore idiomatic for this pattern — the positional contract is documented by the call site that builds the list.

### 4. What `List.Buffer` actually does

| Without `List.Buffer` | With `List.Buffer` |
|-----------------------|--------------------|
| Each reference to `configParams` may trigger a full re-evaluation of the `let` block that produced it | The list is materialized once into contiguous memory; all references share the same in-memory copy |
| `GetApiToken(...)` could be called once per workspace, per model, per table | `GetApiToken(...)` is called exactly once per connector invocation |
| Token expiry mid-refresh can cause inconsistent results if different table reads get different tokens | All reads use the same token snapshot |

### 5. When to apply this pattern

Use `List.Buffer` when:

- A value requires an HTTP call to compute (token fetch, metadata endpoint).
- The value is referenced by more than one downstream function or table.
- The value is stable for the duration of a single refresh (tokens, resolved URLs, environment flags).

Do **not** use `List.Buffer` for:

- Large datasets — buffering forces full in-memory materialization, negating streaming benefits.
- Values that must be re-fetched on each table access (e.g., short-lived nonces).
- Single-reference values — the buffer overhead is wasted if the value is only used once.

---

## See Also

- [`caching_table_buffer_pattern.md`](caching_table_buffer_pattern.md) — Covers `Table.Buffer` for caching navigation table lists and `Binary.Buffer` for caching raw HTTP responses. Different buffer type, different data shape; same underlying lazy-evaluation problem.
