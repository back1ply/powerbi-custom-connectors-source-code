# Power Query Patterns: Binary Decompression (GZIP/Deflate)

When working with APIs, Power Query's `Web.Contents` function automatically handles HTTP transparent compression. If a server responds with `Content-Encoding: gzip`, the M engine will decompress the stream silently before passing the bytes to your `Json.Document` or `Csv.Document` parser.

However, there are two advanced scenarios where you must manually decompress payloads using `Binary.Decompress`:

1. **FTP / Datalake File Downloads**: You are downloading a physical `.gz` or `.zip` file from an Azure Data Lake or FTP server.
2. **Base64 Encoded Strings**: The API responds with a JSON object, but the actual data is a Base64 encoded string of GZIP compressed bytes inside a JSON field.

## The `Binary.Decompress` Pattern

Power Query supports natively decompressing `GZIP` and `Deflate` streams.

### 1. Extracting a `.gz` CSV File from a URL

This pattern safely fetches a compressed file, expands it into a raw string in memory, and then parses the CSV.

```powerquery
shared MyConnector.GetCompressedData = (fileUrl as text) =>
    let
        // 1. Download the raw `.gz` file bytes
        compressedBytes = Web.Contents(fileUrl),
        
        // 2. Safely attempt to decompress the bytes
        decompressedBytes = try Binary.Decompress(compressedBytes, Compression.GZip) otherwise error "File is not a valid GZIP archive",
        
        // 3. Convert the decompressed bytes into a Text document (assuming UTF-8)
        // If the file is Windows-1252 encoded, use 1252 instead of TextEncoding.Utf8
        rawTextString = Text.FromBinary(decompressedBytes, TextEncoding.Utf8),
        
        // 4. Parse the text as a CSV
        csvTable = Csv.Document(rawTextString, [Delimiter=",", Encoding=TextEncoding.Utf8, QuoteStyle=QuoteStyle.Csv])
    in
        csvTable;
```

### 2. Extracting Compressed Data from a JSON Field

Some high-volume logging APIs (like Microsoft Cloud Service diagnostics) wrap large logs in compressed Base64 strings to save JSON overhead.

Example API Response:
`{ "status": "success", "log_payload_base64_gz": "H4sIAAAAAAAA/8vMLcgvKlFIzUvOT0lNzA..." }`

```powerquery
shared MyConnector.DecodeJsonPayload = () =>
    let
        // 1. Get the JSON response
        json = Json.Document(Web.Contents("https://api.mycompany.com/logs/today")),
        
        // 2. Extract the Base64 string
        base64String = json[log_payload_base64_gz],
        
        // 3. Decode Base64 string to raw Binary
        compressedBytes = Binary.FromText(base64String, BinaryEncoding.Base64),
        
        // 4. Decompress the Binary using GZIP (or Compression.Deflate depending on the API)
        decompressedBytes = Binary.Decompress(compressedBytes, Compression.GZip),
        
        // 5. Read the resulting bytes as the actual final JSON data
        finalJson = Json.Document(decompressedBytes)
    in
        finalJson;
```

### Supported Compression Algorithms
* `Compression.GZip` (Used for `.gz` files and standard Unix compression)
* `Compression.Deflate` (Used mostly in older Windows implementations / Zlib)

If you attempt to decompress a file that is not actually compressed, `Binary.Decompress` will throw a hard error. Always wrap the decompression step in `try ... otherwise` if the API source is unpredictable.
