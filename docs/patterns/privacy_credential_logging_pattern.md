# Power Query Patterns: Privacy and Credential Logging

If you implement the [Diagnostics & Tracing Pattern](diagnostics_tracing_pattern.md), your connector will write valuable debugging information to the Power BI Desktop trace logs (located at `C:\Users\{User}\AppData\Local\Microsoft\Power BI Desktop\Traces`).

However, the number one reason Microsoft rejects submissions to the Certified Connector program is the accidental logging of PII (Personally Identifiable Information) or sensitive credentials like API Keys and OAuth2 Bearer Tokens.

When you pass the `options` record of a `Web.Contents` call into `Diagnostics.Trace`, the `Authorization` header is converted to text and saved in plain sight.

## The `Diagnostics.ValueToText` Sanitization Pattern

To prevent credentials from leaking into log files, certified connectors intercept the options record and explicitly scrub sensitive keys *before* turning the record into text.

### Implementation

You can modify the `Diagnostics.pqm` helper or create your own logging wrapper that looks for specific header names and replaces their values.

```powerquery
// A helper to recursively replace sensitive values in records
ScrubCredentials = (target as any) as any =>
    let
        // The list of dictionary keys or HTTP headers that must never be logged
        SensitiveKeys = {
            "Authorization",
            "api_key",
            "client_secret",
            "refresh_token",
            "password"
        },
        
        ProcessRecord = (rec as record) => 
            let
                fieldNames = Record.FieldNames(rec),
                // Iterate over every field in the record
                transformOptions = List.Transform(fieldNames, (fieldName) => 
                    let
                        fieldValue = Record.Field(rec, fieldName),
                        // If the field name is in our deny-list, overwrite it
                        sanitizedValue = if List.Contains(SensitiveKeys, fieldName) then 
                            "*** OBFUSCATED ***" 
                        // If the field value is another nested record (like the Headers record), recurse
                        else if Type.Is(Value.Type(fieldValue), type record) then
                            @ScrubCredentials(fieldValue)
                        else 
                            fieldValue
                    in
                        {fieldName, sanitizedValue}
                )
            in
                Record.FromList(List.Transform(transformOptions, each _{1}), List.Transform(transformOptions, each _{0}))
    in
        // Only apply this logic to records, leave other primitive types alone
        if Type.Is(Value.Type(target), type record) then ProcessRecord(target) else target;
```

### Usage

Before passing your Web.Contents options to your tracing function, you pipe them through the scrubber.

```powerquery
shared MyConnector.Contents = () =>
    let
        options = [
            Headers = [
                #"Authorization" = "Bearer MySuperSecretToken123",
                #"Accept" = "application/json"
            ]
        ],
        
        // 1. Scrub the options record
        safeOptions = ScrubCredentials(options),
        
        // 2. Log it safely (SafeOptions will have "*** OBFUSCATED ***" instead of the token)
        _ = Diagnostics.Trace(TraceLevel.Information, "Making API Call", safeOptions, () => 
            // 3. Make the actual network call using the original UN-SCRUBBED options
            Web.Contents("https://api.mycompany.com", options)
        )
    in
        _;
```

By ensuring every `Diagnostics.Trace` call that touches HTTP headers or authentication records passes through a scrubber, you guarantee your connector handles user credentials securely and will pass Microsoft's security reviews.
