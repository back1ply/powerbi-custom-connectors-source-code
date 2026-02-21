# Power Query Authentication: API Key (`AuthenticationKind.Key`)

Many modern REST APIs authenticate using a static API key, personal access token (PAT), or specific HTTP Header. The Power Query SDK provides the `Key` authentication kind which securely prompts the user for this string and encrypts it locally.

## Defining the Authentication Record

You define the `Key` authentication method within your Data Source record. You can customize the prompt text that users see when they enter their key in Power BI.

```powerquery
// Example: SurveyMonkey or Databricks PAT style
MyDataSource = [
    TestConnection = (dataSourcePath) => { "MyDataSource.Contents" },
    Authentication = [
        Key = [
            // "Label" is the internal identifier name for this method.
            Label = "API Token",
            // "KeyLabel" is what the user reads on the input box inside Power BI.
            KeyLabel = "Enter your Personal Access Token from your developer console."
        ]
    ]
];
```

## How to use the extracted API Key

Unlike OAuth2, the Power Query engine *does not always know* where to inject the API Key (since APIs differ wildly—some want it in the `Authorization` header, others want a custom header like `x-api-key`, and some want it as a URL query parameter `?api_key=XYZ`).

You must extract the key using `Extension.CurrentCredential()[Key]` and manually insert it into your `Web.Contents` call.

### Boilerplate Template

```powerquery
// 1. A wrapper function that fetches data
GetApiData = (url as text) =>
    let
        // Securely fetch the API key the user entered
        apiKey = Extension.CurrentCredential()[Key],
        
        // Define your Headers. This example simulates a Bearer Token or Custom Header
        headers = [
            #"Authorization" = "Bearer " & apiKey,
            // OR if your API uses a custom header:
            // #"x-api-key" = apiKey,
            
            #"Accept" = "application/json"
        ],
        
        // Make the authenticated request
        Source = Web.Contents(url, [
            Headers = headers,
            ManualStatusHandling = {401, 403}    
        ]),
        
        Json = Json.Document(Source)
    in
        Json;
        
// 2. Your actual connector entry point 
[DataSource.Kind="MyDataSource", Publish="MyDataSource.Publish"]
shared MyDataSource.Contents = () =>
    let
        data = GetApiData("https://api.yourservice.com/v1/users")
    in
        data;

// 3. Define the Source Kind
MyDataSource = [
    TestConnection = (dataSourcePath) => { "MyDataSource.Contents" },
    Authentication = [
        Key = [
            KeyName = "api_key", // Optional: automatically injects into query string if used with `Web.Contents`
            KeyLabel = "Enter your API Key"
        ]
    ]
];
```

## Pro Tip from the Certified Connectors
If your API expects the key exactly as a query string parameter (e.g., `https://api.yourservice.com/data?api_key=XYZ`), setting `KeyName = "api_key"` inside the Authentication record will automatically append it to the URL in some contexts, though manually injecting it provides safer error handling.
