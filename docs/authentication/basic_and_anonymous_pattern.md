# Power Query Authentication: Basic, Windows, & Implicit

While `OAuth` and `Key` are the most secure and modern methods, many enterprise APIs and internal data sources still rely on `Username/Password` (Basic Authentication) or Active Directory integration (`Windows`). Lastly, some public APIs do not require any authentication at all (`Implicit`/`Anonymous`).

## The Boilerplate Templates

Below are the boilerplate structures used by Microsoft-certified connectors for these three authentication flows. 

### 1. Basic Auth (`UsernamePassword`)

When you define `UsernamePassword` in your Authentication record, Power BI will prompt the user for a username and password. 

```powerquery
// How to define it:
MyDataSource = [
    TestConnection = (dataSourcePath) => { "MyDataSource.Contents" },
    Authentication = [
        UsernamePassword = [
            Label = "Basic Auth",
            UsernameLabel = "Enter your Username",
            PasswordLabel = "Enter your Password"
        ]
    ]
];

// How to extract it:
GetApiData = (url as text) =>
    let
        // Securely fetch the credentials
        cred = Extension.CurrentCredential(),
        username = cred[Username],
        password = cred[Password],
        
        // Basic auth requires the base64 encoding of "username:password"
        base64Auth = Binary.ToText(Text.ToBinary(username & ":" & password), BinaryEncoding.Base64),
        
        // Define your Headers
        headers = [
            #"Authorization" = "Basic " & base64Auth,
            #"Accept" = "application/json"
        ],
        
        // Make the authenticated request
        Source = Web.Contents(url, [
            Headers = headers    
        ])
    in
        Source;
```

### 2. Windows Authentication (`Windows`)

This is arguably the easiest to implement. If your API supports NTLM or Kerberos (common for on-premise SQL servers or corporate intranet APIs), Power BQ handles it natively.

```powerquery
// How to define it:
MyDataSource = [
    TestConnection = (dataSourcePath) => { "MyDataSource.Contents" },
    Authentication = [
        Windows = [
            Label = "Windows Authentication"
        ]
    ]
];

// How to use it:
// You don't need to manually inject headers. Just make the standard Web.Contents call.
// The Power BI engine automatically negotiates the Windows credentials.
GetApiData = (url as text) =>
    let
        Source = Web.Contents(url)
    in
        Source;
```

### 3. Anonymous / Implicit 

If the API requires no authentication at all (or if you are explicitly handling a custom web handshake that bypasses Power BI's built-in credential manager).

```powerquery
// How to define it:
MyDataSource = [
    TestConnection = (dataSourcePath) => { "MyDataSource.Contents" },
    Authentication = [
        Implicit = [
            // No labels needed. The user simply won't be prompted for credentials.
        ]
        // Note: You can also use Anonymous = []
    ]
];
```
