# Power Query Patterns: Diagnostics & Tracing

When users experience errors with your Custom Connector, debugging it in the wild is extremely difficult because Power Query hides underlying M errors inside generic user-facing prompts like "The remote server returned an error: (400) Bad Request."

To provide a support path, Certified Connectors use the undocumented `Diagnostics.Trace` function to write internal variables, API URLs, and raw responses directly to the Power BI Desktop diagnostic trace logs.

## The `Diagnostics.Trace` Function

The native M function signature looks like this:
`Diagnostics.Trace(traceLevel as number, message as text, value as any, optional delayed as nullable logical) as any`

### Trace Levels
*   `TraceLevel.Critical` (0)
*   `TraceLevel.Error` (1)
*   `TraceLevel.Warning` (2)
*   `TraceLevel.Information` (3)
*   `TraceLevel.Verbose` (4)

## The Standard Helper Wrapper

Because `Diagnostics.Trace` only accepts a text string for the message, it will crash if you try to log a Record, List, or Table. Microsoft uses a standard `Diagnostics.pqm` helper file across many connectors (like SurveyMonkey, Zendesk, and GitHub) that serializes any M value into text before logging it.

### 1. Include the Helper

*Save this as `Diagnostics.pqm` in your project folder.*

```powerquery
let
    // Main logging function
    Diagnostics.LogValue = (prefix as text, value as any) => 
        Diagnostics.Trace(
            TraceLevel.Information, 
            prefix & ": " & (try Diagnostics.ValueToText(value) otherwise "<error getting value>"), 
            value
        ),

    // Converts ANY M type into a readable string for the trace log
    Diagnostics.ValueToText = (value) =>
        let
            Serialize.List = (x) => "{" & List.Accumulate(x, "", (seed,item) => if seed="" then Serialize(item) else seed & ", " & Serialize(item)) & "} ",
            Serialize.Record = (x) => "[ " & List.Accumulate(Record.FieldNames(x), "", (seed,item) => (if seed="" then item else seed & ", " & item) & " = " & Serialize(Record.Field(x, item))) & " ] ",
            Serialize.Table = (x) => "#table(..., " & Serialize(Table.ToRows(x)) & ") ",
            Serialize = (x) as text => 
                   if x is list         then try Serialize.List(x) otherwise "null"
                   else if x is record  then try Serialize.Record(x) otherwise "null"
                   else if x is table   then try Serialize.Table(x) otherwise "null"
                   else try Text.From(x) otherwise "null"                     
        in
            try Serialize(value) otherwise "<serialization failed>"
in
    [ 
        LogValue = Diagnostics.LogValue,
        ValueToText = Diagnostics.ValueToText
    ]
```

### 2. Loading the Helper

Inside your main `MyConnector.pq` file, load the helper:

```powerquery
Diagnostics = Extension.LoadFunction("Diagnostics.pqm");
Diagnostics.LogValue = Diagnostics[LogValue];
```

### 3. Usage

Wrap your variables inside `Diagnostics.LogValue`. Power Query will evaluation the value, pass it to the trace logs, and then pass it along to your code transparently.

```powerquery
// Bad (Hidden error if url is malformed)
let
    url = "https://api.domain.com/data",
    response = Web.Contents(url)
in
    response

// Good (Writes "ApiCall: https://api.domain.com/data" to Power BI trace logs)
let
    url = Diagnostics.LogValue("ApiCall", "https://api.domain.com/data"),
    response = Web.Contents(url)
in
    response
```

### Where to find the logs?
If a user turns on Diagnostics in Power BI Desktop (File > Options and Settings > Options > Diagnostics > Enable tracing), these logs will appear deeply nested in the zip folder at:
`%localappdata%\Microsoft\Power BI Desktop\Traces`
