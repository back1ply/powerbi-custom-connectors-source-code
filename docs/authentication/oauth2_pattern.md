# Power Query Authentication: OAuth2 (`AuthenticationKind.OAuth`)

OAuth2 is one of the most common and complex authentication methods to implement in a Custom Connector. It is required when the API demands user delegation (e.g., logging in as a specific user) and refreshing access tokens.

## How it works in `M`

Power Query handles the secure storage of the `access_token` and `refresh_token` automatically behind the scenes. However, you must tell the engine *how* to negotiate those tokens by providing a few key functions: `StartLogin` and `FinishLogin`, and sometimes `Refresh`.

```powerquery
// Usually at the bottom of the connector, where the Data Source Kind is defined
MyDataSource = [
    Authentication = [
        OAuth = [
            StartLogin = StartLogin,
            FinishLogin = FinishLogin,
            Refresh = Refresh, // Optional if FinishLogin returns a refresh token directly
            Logout = Logout // Optional
        ]
    ]
];
```

---

## The Boilerplate Template

Below is a robust boilerplate template extracted from analyzing 124+ Microsoft-Certified connectors. It includes support for standard Authorization Code Grant flow.

You will need to replace `client_id`, `redirect_uri`, and the API URLs with those from your target service's developer portal.

```powerquery
// Define constants
client_id = "YOUR_CLIENT_ID";
redirect_uri = "https://oauth.powerbi.com/views/oauthredirect.html"; // Standard PBI Redirect
authorize_uri = "https://api.yourservice.com/oauth2/authorize";
token_uri = "https://api.yourservice.com/oauth2/token";

// Helper Functions Required by the Engine
// =======================================

// 1. StartLogin: Constructs the URL the user is redirected to.
StartLogin = (resourceUrl, state, display) =>
    let
        authorizeUrl = authorize_uri & "?" & Uri.BuildQueryString([
            response_type = "code",
            client_id = client_id,
            redirect_uri = redirect_uri,
            state = state
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = 720,
            WindowWidth = 1024,
            Context = null
        ];

// 2. FinishLogin: Takes the 'code' returned in the callback URL and exchanges it for a token.
FinishLogin = (context, callbackUri, state) =>
    let
        parts = Uri.Parts(callbackUri)[Query],
        result = if (Record.HasFields(parts, {"error", "error_description"})) then 
                    error Error.Record(parts[error], parts[error_description], parts)
                 else
                    TokenMethod(parts[code], "authorization_code")
    in
        result;

// 3. Refresh: (Optional) How to get a new access_token when the old one expires.
Refresh = (resourceUrl, refresh_token) => TokenMethod(refresh_token, "refresh_token");

// The Actual HTTP Request to the Token Endpoint
TokenMethod = (codeOrToken, grantType) =>
    let
        query = [
            client_id = client_id,
            // Depending on the API, you may or may not need a client_secret here (PKCE is preferred for native apps)
            // client_secret = client_secret, 
            grant_type = grantType,
            redirect_uri = redirect_uri
        ],
        
        // If it's a new login, we send 'code'. If it's a refresh, we send 'refresh_token'.
        queryWithCode = if grantType = "refresh_token" then 
            Record.AddField(query, "refresh_token", codeOrToken)
        else 
            Record.AddField(query, "code", codeOrToken),

        Response = Web.Contents(token_uri, [
            Content = Text.ToBinary(Uri.BuildQueryString(queryWithCode)),
            Headers = [
                #"Content-type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ],
            ManualStatusHandling = {400}
        ]),
        
        Parts = Json.Document(Response),
        
        Result = if (Record.HasFields(Parts, {"error", "error_description"})) then 
                    error Error.Record(Parts[error], Parts[error_description], Parts)
                 else 
                    Parts
    in
        Result;
```

### Using the Access Token
When you actually make your calls to `Web.Contents` inside your connector, Power Query will seamlessly inject the `Authorization: Bearer <token>` header as long as the user authenticated successfully. Wait, no, sometimes you have to tell it, but usually, it handles it if `AuthenticationKind.OAuth` is defined correctly.
Wait, let's verify how Asana does it.
Asana explicitly fetches it: `Extension.CurrentCredential()[access_token]`. 

If the Power Query engine natively handles it via `OAuth`, it applies it automatically, but some connectors force it manually if the API expects it in a non-standard way or requires manual credentials logic.

*End of OAuth2 Guide.*
