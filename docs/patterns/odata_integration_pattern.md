# Power Query Patterns: Customizing `OData.Feed`

If the API you are connecting to is OData compliant, the M engine provides a native `OData.Feed()` function. 

Unlike `Web.Contents()`, which simply downloads a raw JSON payload that you must parse and manually paginate, `OData.Feed` automatically handles parsing the OData schema, expanding navigation properties, following `@odata.nextLink` for pagination, and even translating Power Query UI filters into OData `$filter` queries natively (Query Folding).

However, many OData APIs require custom authentication headers or specific OData Version 4 headers to function correctly. 

## The Custom OData Pattern

You can pass a third argument to `OData.Feed` — an options record — to inject headers, handle errors, and specify the OData implementation engine.

### Implementation

```powerquery
shared MyConnector.ODataContents = (url as text) =>
    let
        // Retrieve the current user's credentials
        credentials = Extension.CurrentCredential(),
        
        // 1. Build a custom headers record
        headers = [
            #"Authorization" = "Bearer " & credentials[access_token],
            #"Accept" = "application/json;odata.metadata=minimal"
        ],
        
        // 2. Define the OData.Feed options
        options = [
            Headers = headers,
            
            // CRITICAL: Always use "2.0" for modern Connectors. 
            // Implementation "1.0" is the legacy engine and fails on many modern APIs.
            Implementation = "2.0",
            
            // Specify the OData Version (4 is the modern standard)
            ODataVersion = 4,

            // Optional: Hardcode query parameters that should append to EVERY request
            Query = [
                #"api-version" = "2023-10-01"
            ],
            
            // Optional: Ignore errors on specific HTTP status codes
            ManualStatusHandling = {400, 404}
        ],
        
        // 3. Call OData.Feed
        source = OData.Feed(url, null, options)
    in
        source;
```

### 🚨 Anti-Pattern Warning: `Web.Page` is Banned!

While researching certified Microsoft Custom Connectors, it is notable that **zero** certified connectors use the `Web.Page()` function.

You might be tempted to use `Web.Page(Web.Contents("https://mycompany.com/data"))` to scrape an HTML table from a website that lacks an API.

**Do not do this in a Custom Connector.**

`Web.Page()` relies on the local Windows Operating System's Internet Explorer/Edge rendering engine to parse the HTML Document Object Model (DOM). 
1. It is extremely slow. 
2. It fails randomly if the website uses JavaScript to load the table.
3. Most importantly: It is **not supported for Scheduled Refresh in the Power BI Service** without a complex On-Premises Data Gateway setup, because the cloud servers do not run desktop web browsers.

Microsoft will reject your Custom Connector submission if it relies on `Web.Page()`. Always use an official JSON, XML, CSV, or OData API endpoint instead.
