# Power Query Patterns: Dynamic Data Sources (Scheduled Refresh Error)

One of the most frustrating errors in Power Query development is successfully building a connector that works in Power BI Desktop, only to publish it to the Power BI Service and find that scheduled refresh fails with the error:

> *"This dataset includes a dynamic data source. Since dynamic data sources aren't refreshed in the Power BI service, this dataset won't be refreshed."*

## What Causes the Error?

The Power BI Service runs a static analysis on your M code before it even attempts to execute it. It looks at the first argument of `Web.Contents(url)` to determine what base URL you are connecting to, so it can bind the credentials stored in the cloud.

If your URL is dynamically generated via string concatenation, Power BI cannot determine the base URL.

**BAD (Will break Scheduled Refresh):**
```powerquery
// String concatenation masks the base URL
GetPage = (userId as text, startDate as text) =>
    let
        url = "https://api.example.com/v1/users/" & userId & "/activity?start=" & startDate,
        Source = Web.Contents(url)
    in
        Source;
```

## The Solution: `RelativePath` and `Query`

To fix this, you must separate your URL into three hardcoded components native to the `Web.Contents` function: The Base URL, the `RelativePath`, and the `Query` record. This allows Power BI's static analyzer to successfully read the base URL ("https://api.example.com/").

**GOOD (Certified Pattern):**
```powerquery
GetPage = (userId as text, startDate as text) =>
    let
        // 1. The base URL must be a static text string
        baseUrl = "https://api.example.com/",
        
        // 2. The dynamic path goes here (must NOT start with a slash if baseUrl ends with one)
        relativePath = "v1/users/" & userId & "/activity",
        
        // 3. For URL parameters (?key=value), use a Record. Power Query will automatically URL-encode them.
        queryParameters = [
            start = startDate
        ],
        
        // 4. Combine them safely
        Source = Web.Contents(baseUrl, [
            RelativePath = relativePath,
            Query = queryParameters
        ])
    in
        Source;
```

### Pro Tip: `Value.NativeQuery` vs `Web.Contents`
While this applies strictly to REST APIs using `Web.Contents`, the exact same rule applies if you are building an ODBC/SQL connector using `Value.NativeQuery`. Never concatenate strings into a SQL statement in Power Query; always pass variables via the `Parameters` record to prevent SQL injection and allow Query Folding.
