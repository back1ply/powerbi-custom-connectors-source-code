# Power Query Patterns: Parsing NDJSON (Newline Delimited JSON)

Most modern REST APIs return data as a single, well-formed JSON object or a JSON array. 
For example: `[ {"id": 1, "name": "Apples"}, {"id": 2, "name": "Oranges"} ]`

Power Query parses this effortlessly using `Json.Document(response)`.

However, some high-volume streaming APIs, data lake export formats, and specialized protocols (like Databricks Delta Sharing) return data in **NDJSON (Newline Delimited JSON)** or **JSONL (JSON Lines)** format. 

In NDJSON, the data is not wrapped in a JSON array `[ ]`, and there are no commas `,` separating the objects. Instead, each individual JSON object is on its own line, separated only by a newline character `\n`:

```json
{"id": 1, "name": "Apples"}
{"id": 2, "name": "Oranges"}
{"id": 3, "name": "Bananas"}
```

If you pass an NDJSON payload into `Json.Document()`, Power Query will instantly crash with an `ExtraCharacters` error, because valid JSON cannot have multiple root objects.

## The `Lines.FromBinary` NDJSON Pattern

To parse NDJSON, you must first split the raw binary response into a List of text strings (one for each line), and *then* parse each string individually as its own JSON document.

### Implementation

The Microsoft `DeltaSharing` connector uses this exact pattern to read streamed table query responses.

```powerquery
shared MyConnector.GetNDJSONData = () =>
    let
        // 1. Fetch the raw payload, but DO NOT call Json.Document yet
        rawBinary = Web.Contents("https://api.mycompany.com/v1/stream/orders"),
        
        // 2. Split the binary stream by newline characters (\n or \r\n) into a List of Text strings
        listOfTextLines = Lines.FromBinary(rawBinary),
        
        // 3. Remove any empty lines (common at the end of streaming responses)
        nonEmptyLines = List.Select(listOfTextLines, each _ <> ""),
        
        // 4. Parse each individual line as its own JSON document
        listOfJsonRecords = List.Transform(nonEmptyLines, each Json.Document(_)),
        
        // 5. Convert the resulting List of Records into an M Table
        finalTable = Table.FromRecords(listOfJsonRecords)
    in
        finalTable;
```

### Why this is powerful

1. **Memory Efficiency**: While `Json.Document()` attempts to deserialize the entire payload at once (which can crash Power BI Desktop on a 2GB file), splitting it by lines allows you to process it sequentially.
2. **Resilience**: If an API's stream breaks midway through, leaving a half-written JSON object on line 500 (`{"id": 500, "name": "P` ), `Json.Document` will fail the entire parsing operation. With NDJSON parsing, you can wrap the inner `Json.Document(_)` in a `try ... otherwise null` to silently discard corrupt tail lines while keeping the 499 valid orders.

```powerquery
        // Resilient parsing: drops corrupt lines instead of crashing the query
        listOfJsonRecords = List.Transform(
            nonEmptyLines, 
            each try Json.Document(_) otherwise null
        ),
        cleanRecords = List.RemoveNulls(listOfJsonRecords),
```
