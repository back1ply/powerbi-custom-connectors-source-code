# Power Query Patterns: OAuth2 Token Refresh

When a custom connector implements OAuth2, the API typically returns two tokens:
1. `access_token`: Used to authenticate API requests. Usually expires in 1 hour.
2. `refresh_token`: Used to get a *new* `access_token` when the original one expires. Usually lasts for 90 days.

If a developer does not implement a Token Refresh mechanism, users will have to manually re-enter their credentials into the Power BI "Edit Credentials" prompt every single hour.

Fortunately, the Power Query M Engine will handle the token refresh process 100% automatically in the background (even during Scheduled Refreshes in the Cloud), provided you wire up the `Refresh` handler in the Authentication record.

## The `OAuth.Refresh` Pattern

### 1. The Authentication Record

When defining your connector's entry point, you must provide a `Refresh` function inside the `OAuth` record.

```powerquery
MyConnector = [
    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
            
            // This is the critical handler
            Refresh = Refresh
        ]
    ],
    Label = "My Custom Connector"
];
```

### 2. The Refresh Function Implementation

When an API request fails with a `401 Unauthorized` (indicating the Access Token has expired), the Power Query engine immediately halts the query, retrieves the `refresh_token` from the user's secure credential vault, and passes it into your custom `Refresh` function.

Your `Refresh` function must take that token, execute an HTTP POST to the API's `/token` endpoint, and return a JSON record containing the new tokens.

```powerquery
// The engine automatically passes the resourceUrl and the user's saved refresh_token
Refresh = (resourceUrl, refresh_token) => 
    let
        // 1. Define the POST payload according to the OAuth2 specification
        TokenUrl = "https://api.mycompany.com/oauth2/token",
        
        body = [
            grant_type = "refresh_token",
            refresh_token = refresh_token,
            client_id = "YOUR_CLIENT_ID",
            client_secret = "YOUR_CLIENT_SECRET" // Note: See pattern on retrieving Secrets securely
        ],
        
        // 2. Execute the POST request
        Response = Web.Contents(TokenUrl, [
            Content = Text.ToBinary(Uri.BuildQueryString(body)),
            Headers = [
                #"Content-Type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ]
        ]),
        
        // 3. Parse the JSON response
        Parts = Json.Document(Response)
    in
        // 4. Return the parsed record back to the M Engine.
        // The engine expects to find fields named `access_token` and optionally `refresh_token`
        // inside this record. It will overwrite the old tokens in the vault.
        Parts;
```

### 3. Engine Auto-Retry

Once your `Refresh` function successfully returns the new `access_token`, the M Engine permanently saves it to the user's credential vault.

It then **automatically retries** the original `Web.Contents` call that threw the initial 401 error, injecting the new Access Token into the Authorization header. 

This entire process is invisible to the user. Their scheduled refresh will simply pause for half a second while the token is rotated, and then successfully complete.
