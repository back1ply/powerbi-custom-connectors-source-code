# Power Query Patterns: PKCE in OAuth2

Proof Key for Code Exchange (PKCE, defined in RFC 7636) is an extension to the OAuth2 Authorization Code flow. It was originally designed to protect mobile applications from authorization code interception attacks, but has since become the industry-standard best practice for *all* OAuth2 clients, including Power BI custom connectors.

When implementing the `OAuth` record in the `Authentication` block of a custom connector, many modern identity providers (like Okta, Auth0, or advanced Entra ID apps) **require** PKCE to be present.

Implementing PKCE in Power Query requires using undocumented cryptographic hash utilities (`Crypto.CreateHash` and `CryptoAlgorithm.SHA256`) that are exclusively available within the Custom Connectors SDK and are restricted in standard Power BI Dataflows.

## The PKCE Boilerplate Logic

To implement PKCE, we must generate a random `code_verifier` string, create a Base64-URL-encoded SHA-256 hash of that string (the `code_challenge`), pass it in the initial `StartLogin` URL, and then provide the original `code_verifier` back to the identity provider during the `FinishLogin` step.

Power Query's `Authentication` pipeline manages state between these two steps via the `Context` record.

### 1. `StartLogin`

Here is a complete, production-ready `StartLogin` function implementing the PKCE transformation:

```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        // 1. Define a helper to safely Base64Url encode our cryptographic hash 
        // (Standard Base64 is not URL-safe according to RFC 7636)
        Base64UrlEncode = (binaryData as binary) =>
            let
                unescapedStr = Binary.ToText(binaryData, BinaryEncoding.Base64),
                base64EncodedAsTextEscaped = Text.Replace(Text.Replace(Text.Replace(unescapedStr, "+", "-"), "/", "_"), "=", "")
            in
                base64EncodedAsTextEscaped,

        // 2. Generate the Cryptographic PKCE Verifier
        // We concatenate two GUIDs to ensure sufficient randomness (entropy).
        codeVerifier = Text.NewGuid() & Text.NewGuid(),
        
        // 3. Generate the PKCE Challenge
        // We hash the verifier using SHA-256, and then Base64Url encode it.
        // NOTE: Crypto and CryptoAlgorithm are undocumented functions specific to the Extension framework.
        codeChallenge = Base64UrlEncode(Crypto.CreateHash(CryptoAlgorithm.SHA256, Text.ToBinary(codeVerifier, TextEncoding.Ascii))),

        // 4. Construct the Authorization URL
        authorizeUrl = "https://login.myapi.com/oauth2/authorize?" & Uri.BuildQueryString([
            client_id = client_id,
            response_type = "code",
            state = state,
            redirect_uri = redirect_uri,
            
            // Inject the PKCE Parameters
            code_challenge = codeChallenge,
            code_challenge_method = "S256"
        ])
    in
        [
            LoginUri = authorizeUrl,
            CallbackUri = redirect_uri,
            WindowHeight = 800,
            WindowWidth = 800,
            
            // 5. CRITICAL: Store the original codeVerifier in the Context record
            // The Power Query engine will hold this state and pass it into FinishLogin
            Context = [ CodeVerifier = codeVerifier ]
        ];
```

### 2. `FinishLogin`

When the user successfully logs into the provider in the pop-up window, the provider redirects back to the `redirect_uri` with an authorization `code`. 

Power BI captures this and calls `FinishLogin`. We must now extract the `code_verifier` from the `context` parameter and POST it to the token endpoint to prove we are the original requester.

```powerquery
FinishLogin = (context, callbackUri, state) =>
    let
        // 1. Extract the authorization code from the callback URL query parameters
        Parts = Uri.Parts(callbackUri)[Query],
        
        // 2. Retrieve the original codeVerifier we saved in the StartLogin context
        codeVerifier = context[CodeVerifier],

        // 3. Construct the Token Request body
        TokenBody = [
            client_id = client_id,
            grant_type = "authorization_code",
            code = Parts[code],
            redirect_uri = redirect_uri,
            
            // Inject the original PKCE verifier to complete the exchange
            code_verifier = codeVerifier
        ],

        // 4. Execute the Token Exchange
        Response = Web.Contents("https://login.myapi.com/oauth2/token", [
            Content = Text.ToBinary(Uri.BuildQueryString(TokenBody)),
            Headers = [
                #"Content-Type" = "application/x-www-form-urlencoded",
                #"Accept" = "application/json"
            ],
            ManualCredentials = true
        ]),
        
        Parts = Json.Document(Response)
    in
        Parts;
```

### Why Use Context Variables?
The most important architectural aspect of this pattern is Power Query's `Context = [ CodeVerifier = codeVerifier ]` state management. Because `StartLogin` and `FinishLogin` are entirely separate evaluations within the M Engine (often spanning minutes while the user types in their password in the UI), standard M variables cannot span the gap. The `Context` record is the *only* way to pass the PKCE secret securely from the start of the authentication flow to the end.
