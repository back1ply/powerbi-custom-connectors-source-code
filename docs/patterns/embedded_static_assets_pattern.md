# Power Query Patterns: Embedded Static Assets

When building a custom connector, you often need to bundle static configuration data alongside your M code. 
Common examples include:
- A JSON file containing your application's Client ID so you don't leak it in the source `.pq`.
- A CSV file containing a list of supported Country ISO codes for a dropdown menu.
- A static list of API endpoint definitions or GraphQL schemas.

Instead of hardcoding a 1,000-line M `Record` into your `.pq` file (which makes the code unreadable), you can drop standard `.json` or `.csv` files directly into your Visual Studio project and load them dynamically using **`Extension.Contents`**.

## The `Extension.Contents` Pattern

When you compile a `.mez` file (which is just a `.zip` file under the hood), every non-M file in the working directory gets packed into the root of the archive. 

The Power Query engine natively exposes a function called `Extension.Contents("filename.ext")` which returns the binary stream of any file bundled inside the `.mez`.

### 1. Including the Asset

First, ensure your static file is checked into the same directory as your `.pq` file. 

**`Config.json`**
```json
{
  "client_id": "8aa18b2c-...",
  "base_url": "https://api.mycompany.com/v1",
  "timeout_seconds": 60
}
```

If you are using Visual Studio to compile your connector, you **must** select `Config.json` in the Solution Explorer, view its Properties, and change the **Build Action** to `Compile`. This guarantees MSBuild will package it into the `.mez`.

### 2. Loading and Parsing the Asset

At the top of your `MyConnector.pq` file, you can immediately decode the binary stream back into a usable M Object.

```powerquery
let
    // 1. Read the binary from the extension package
    ConfigBinary = Extension.Contents("Config.json"),
    
    // 2. Parse the underlying text as JSON
    ConfigRecord = Json.Document(ConfigBinary),
    
    // 3. Extract the variables for global use
    client_id = ConfigRecord[client_id],
    base_url = ConfigRecord[base_url],

    // Define the main connector using the static assets
    shared MyConnector.Contents = () =>
        let
            response = Web.Contents(base_url & "/data")
        in
            response;
in
    [
        MyConnector.Contents = MyConnector.Contents
    ]
```

### Performance Considerations

The Power Query engine executes the global let block (the top level of your file) exactly *once* per process. 

By defining your `Extension.Contents` parsing logic at the global script scope rather than inside `shared MyConnector.Contents = () =>`, you guarantee the JSON file will only be read from the disk and computationally parsed one single time, even if the user makes thousands of function calls to your connector in their dashboard.
