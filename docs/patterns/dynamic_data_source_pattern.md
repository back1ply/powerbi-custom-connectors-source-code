# Power Query Patterns: Dynamic Data Sources & The `Formula.Firewall`

This is arguably the single most important pattern in custom connector development.

If you have ever built a custom function in Power Query that takes a parameter and inserts it into a URL, you have likely encountered the **Dynamic Data Source** error in Power BI Desktop:

> _`Formula.Firewall: Query 'MyQuery' (step 'Source') references other queries or steps, so it may not directly access a data source. Please rebuild this data combination.`_

Alternatively, the connector might work perfectly in Desktop, but when you publish it to the Power BI Service, Scheduled Refresh fails with:

> _`This dataset includes a dynamic data source. Since dynamic data sources aren't refreshed in the Power BI service, this dataset won't be refreshed.`_

## Why Does This Happen?

To ensure data privacy and prevent a malicious query from sending your confidential HR database records to an external URL, the Power Query engine performs a **Static Code Analysis** before executing any M code.

It attempts to discover the Base URL of every `Web.Contents` call to bind the correct Cloud credentials to it securely.

**BAD (Will break Scheduled Refresh & trigger the Firewall):**

```powerquery
// ANTI-PATTERN: String Concatenation masks the base URL
GetPage = (userId as text, startDate as text) =>
    let
        // The static analyzer cannot determine what this URL resolves to
        url = "https://api.example.com/v1/users/" & userId & "/activity?start=" & startDate,
        Source = Web.Contents(url)
    in
        Source;
```

Because it cannot guarantee what the URL is going to be without running the code, it completely blocks the execution in the Cloud to prevent data leakage.

## The Solution: `RelativePath` and `Query`

To fix this, you must **never** concatenate URL strings in a custom connector.

Instead, you must provide a hardcoded Base URL as the first argument to `Web.Contents`. Power Query will authorize this safe Base URL during the static analysis phase.

Then, you pass the dynamic portions of the URL to the `RelativePath` and `Query` arguments inside the options record.

**GOOD (Certified Pattern):**

```powerquery
GetPage = (userId as text, startDate as text) =>
    let
        // 1. The base URL must be a static, hardcoded text string.
        // This is safe and will pass the Formula.Firewall check.
        baseUrl = "https://api.example.com/",

        // 2. The dynamic path goes here (must NOT start with a slash if baseUrl ends with one).
        dynamicPath = "v1/users/" & userId & "/activity",

        // 3. For URL parameters (?key=value), use a Record. Power Query will automatically URL-encode them.
        dynamicQuery = [
            start = startDate
        ],

        // 4. Combine them safely utilizing the Web.Contents secondary options record
        Source = Web.Contents(baseUrl, [
            RelativePath = dynamicPath,
            Query = dynamicQuery,
            Headers = [
                #"Authorization" = "Bearer " & Extension.CurrentCredential()[Key]
            ]
        ])
    in
        Source;
```

### How the Engine Handles It

When the static analyzer runs over this code, it sees `Web.Contents("https://api.example.com/")`. It approves the connection.

At execution time, the engine automatically handles the URL encoding and seamlessly combines the Base URL, `RelativePath`, and `Query` record into the final outbound request:
`GET https://api.example.com/v1/users/12345/activity?start=2023-01-01`

If you implement this correctly, your custom connector will bypass the `Formula.Firewall` and seamlessly refresh in the Power BI Service!

### Pro Tip: `Value.NativeQuery` vs `Web.Contents`

While this applies strictly to REST APIs using `Web.Contents`, the exact same rule applies if you are building an ODBC/SQL connector using `Value.NativeQuery`. Never concatenate strings into a SQL statement in Power Query; always pass variables via the `Parameters` record to prevent SQL injection and allow Query Folding.
