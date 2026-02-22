# Power Query Patterns: Handling Multiple Environments

Enterprise APIs frequently offer multiple environments:
- US Data Center vs EU Data Center
- Production vs Sandbox/Staging
- V1 vs V2 APIs

While you *could* ask the user to manually type "api.sandbox.com" into a free-text box, providing a locked dropdown menu provides a significantly better user experience and prevents typos from breaking the connection.

## The `Documentation.AllowedValues` Pattern

Power BI's "Get Data" dialog auto-generates its UI based on the metadata attached to your main exported function. By adding `Documentation.AllowedValues` to an argument's metadata, Power BI converts the text-box into a dropdown menu.

### 1. Define the Environment Variables

Instead of hardcoding the URL, use a Record or `if/then` logic to map human-readable names to underlying base URLs.

```powerquery
// Define the environments in a record
EnvironmentMap = [
    Production = "https://api.mycompany.com/v1",
    Sandbox    = "https://api.sandbox.mycompany.com/v1",
    Europe     = "https://api.eu.mycompany.com/v1"
];
```

### 2. Attach Metadata to the Function Parameter

Add a `type text meta [...]` block to the parameter definition of your `Contents` function.

```powerquery
[DataSource.Kind="MyConnector", Publish="MyConnector.Publish"]
shared MyConnector.Contents = Value.ReplaceType(MyConnectorImpl, MyConnectorType);

// The Type definition defines the UI
MyConnectorType = type function (
    Environment as (type text meta [
        Documentation.FieldCaption = "Select Environment",
        Documentation.FieldDescription = "Choose the API environment you wish to pull data from.",
        Documentation.AllowedValues = { "Production", "Sandbox", "Europe" } // This creates the dropdown
    ])
) as table;
```

### 3. The Implementation logic

Use the value passed from the dropdown to look up the correct base URL in your code.

```powerquery
MyConnectorImpl = (Environment as text) =>
    let
        // 1. Look up the Base URL based on the drop-down selection
        baseUrl = Record.Field(EnvironmentMap, Environment),
        
        // 2. Make the call using the selected Base URL
        source = Web.Contents(baseUrl, [RelativePath="users"]),
        json = Json.Document(source),
        table = Table.FromRecords(json)
    in
        table;
```

### Warning for OAuth2

If your connector uses OAuth2, the `StartLogin` function needs to know the environment URL. Since the user selects the environment in the Power BI UI, that selection gets saved into the active connection string. You can retrieve it before login using `Extension.CurrentCredential()[Properties]`.

```powerquery
StartLogin = (resourceUrl, state, display) =>
    let
        // Access what the user selected in the dropdown
        selectedEnv = Extension.CurrentCredential()[Properties][Environment]?,
        
        // Look up the matching Auth URL
        authUrl = if selectedEnv = "Sandbox" then "https://auth.sandbox.com" else "https://auth.production.com"
    in
        [
            LoginUri = authUrl,
            CallbackUri = "https://oauth.powerbi.com/views/oauthredirect.html",
            WindowHeight = 720,
            WindowWidth = 1024
        ];
```
