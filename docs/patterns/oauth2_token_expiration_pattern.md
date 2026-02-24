# Power Query Patterns: OAuth2 Token Expiration Parsing

When implementing the `OAuth` record in the `Authentication` block, the Power Query engine expects the JSON payload returned by your token endpoint to strictly follow the OAuth2 specification (RFC 6749). 

Specifically, it expects the expiration time to be represented by an `expires_in` field containing an **integer denoting seconds** relative to the current time:
```json
{
  "access_token": "abc",
  "refresh_token": "def",
  "expires_in": 3600
}
```

If your API does not perfectly match this format, the Power Platform Gateway will either expire your token immediately (forcing constant manual logins) or it will *never* expire the token, meaning Scheduled Refreshes will fail after an hour when the remote server rejects the active token.

## Manipulating the Token Payload

To fix non-compliant APIs, you must intercept the JSON response inside your `FinishLogin` and `Refresh` functions, parse the custom date logic, and inject a valid `expires_in` integer before returning the record to the M Engine.

### 1. Converting `expires_in` strings to integers
Some APIs poorly serialize their payloads and return `"expires_in": "3600"` (as a text string). Power Query will fail to parse this.

```powerquery
TokenMethod = (tokenUrl, body) =>
    let
        Response = Web.Contents(tokenUrl, [
            Content = Text.ToBinary(Uri.BuildQueryString(body)),
            Headers = [ #"Content-Type" = "application/x-www-form-urlencoded" ]
        ]),
        Parts = Json.Document(Response),
        
        // INTERCEPT: Safely cast the string to a number
        FixedParts = 
            if Parts[expires_in]? <> null and Parts[expires_in] is text then
                Parts & [ expires_in = Number.From(Parts[expires_in]) ]
            else
                Parts
    in
        FixedParts;
```

### 2. Converting `expires_at` absolute timestamps to relative seconds
If your API returns an absolute Unix Epoch timestamp (e.g., `1740422114`) representing the exact moment the token dies, you must calculate the difference between that time and *now*.

```powerquery
TokenMethod = (tokenUrl, body) =>
    let
        Response = Web.Contents(tokenUrl, [ ... ]),
        Parts = Json.Document(Response),
        
        FixedParts = 
            if Parts[expires_at]? <> null then
                let
                    // Convert Unix timestamp to Power Query DateTimeZone
                    UnixEpoch = #datetimezone(1970, 1, 1, 0, 0, 0, 0, 0),
                    AbsoluteExpiry = UnixEpoch + #duration(0, 0, 0, Parts[expires_at]),
                    
                    // Get current UTC time
                    CurrentTime = DateTimeZone.UtcNow(),
                    
                    // Calculate relative seconds
                    SecondsUntilExpiry = Duration.TotalSeconds(AbsoluteExpiry - CurrentTime),
                    
                    // Pad the timer slightly to ensure the token doesn't die while in transit
                    SafeExpiry = Number.RoundDown(SecondsUntilExpiry - 60)
                in
                    Parts & [ expires_in = SafeExpiry ]
            else
                Parts
    in
        FixedParts;
```

### 3. Deliberately padding valid `expires_in` limits for safety
Even if your API conforms to the specification perfectly, it is often a best practice to proactively *reduce* the `expires_in` parameter you report back to the Power Query Engine. 

Microsoft's own internal Databricks and Foundry connectors apply a 5-minute (300 seconds) "jitter buffer" to standard token responses.

Why? If an API says a token expires in exactly 3600 seconds, and the Power Query engine tries to use it at the 3599th second, network latency during the HTTP request might mean the token arrives at the remote server at second 3601, resulting in an `HTTP 401 Unauthorized` crash.

By lying to Power Query and telling it the token expires 5 minutes *sooner* than it actually does, you force the M Engine to preemptively invoke your `Refresh` handler safely *before* the token actually dies.

```powerquery
// Example extracted from Palantir Foundry connector
Foundry.DecrementTokenExpiry = (tokenInfo as record) => 
    let
        expiryTime = tokenInfo[expires_in],
        // If the token lives longer than 10 minutes, chop 5 minutes off its reported lifespan.
        newExpiryTime = if expiryTime >= 600 then (expiryTime - 300) else expiryTime
    in
        tokenInfo & [ expires_in = newExpiryTime ];
```
