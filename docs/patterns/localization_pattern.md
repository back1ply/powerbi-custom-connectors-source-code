# Power Query Patterns: Internationalization (i18n) & Localization

When building a custom connector meant for the broader public (or even just for a global enterprise), hardcoding English strings into your UI metadata prevents international users from understanding how to use your tool.

Microsoft requires all Certified Connectors to be fully localized into dozens of languages. 

To achieve this, the Power Query SDK supports bundling standard `.resx` XML Resource files directly inside the compiled `.mez` archive. You can then dynamically load these localized strings into your M code at runtime using the undocumented `Extension.LoadString()` function.

## The `Extension.LoadString` Pattern

If you scan the extracted source code of the Microsoft repository, you will find `Extension.LoadString()` used over 1,600 times across 124 connectors.

### 1. Bundling the `.resx` Resource Files

Inside your Visual Studio project structure, you must create a folder named `resources`. Inside that folder, you create an XML `.resx` file for each supported language. 

The default fallback language must be named `resources.resx`. Other languages use their ISO language codes (e.g., `resources.fr.resx`, `resources.de.resx`, `resources.ja.resx`).

**Directory Structure:**
```text
MyConnector/
├── MyConnector.pq
├── MyConnector.query.pq
└── resources/
    ├── resources.resx         # Default (English)
    ├── resources.es.resx      # Spanish
    └── resources.de.resx      # German
```

**`resources.resx` (Default/English)**
```xml
<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="ExtensionTitle" xml:space="preserve">
    <value>My Database Connector</value>
  </data>
  <data name="EndpointCaption" xml:space="preserve">
    <value>API Server Address</value>
  </data>
</root>
```

**`resources.es.resx` (Spanish)**
```xml
<?xml version="1.0" encoding="utf-8"?>
<root>
  <data name="ExtensionTitle" xml:space="preserve">
    <value>Mi Conector de Base de Datos</value>
  </data>
  <data name="EndpointCaption" xml:space="preserve">
    <value>Dirección del Servidor API</value>
  </data>
</root>
```

When building your project, the MSBuild compiler will automatically package the `resources` directory into your `.mez` file.

### 2. Loading the Strings onto Type Metadata

The Power Query Engine automatically detects the system language of the user's Power BI Desktop installation and routes the `Extension.LoadString` request to the appropriate `.resx` file. If the language isn't supported, it falls back to the default `resources.resx`.

You apply this localization directly to the `type` metadata that defines your function's input UI.

```powerquery
// 1. Define the localized parameters
QueryFunctionType = 
    let
        endpoint = (type text) meta [
            // Pull the localized "API Server Address" string for the UI Label
            Documentation.FieldCaption = Extension.LoadString("EndpointCaption"),
            Documentation.SampleValues = {"https://api.mycompany.com/v1"}
        ],
        
        t = type function (endpointUrl as endpoint) as table
    in
        t meta [
            // Pull the localized "My Database Connector" string for the tool header
            Documentation.DisplayName = Extension.LoadString("ExtensionTitle")
        ];

// 2. Cast the logic function using Value.ReplaceType
[DataSource.Kind = "MyConnector", Publish = "MyConnector.Publish"]
shared MyConnector.Contents = Value.ReplaceType(MyConnector.ContentsImpl, QueryFunctionType);

// 3. Define the actual logic
MyConnector.ContentsImpl = (endpointUrl as text) as table =>
    let
        response = Web.Contents(endpointUrl)
    in
        Json.Document(response);
```

### 3. Localizing the Publish Record

You can also localize the strings injected into the "Get Data" dialog by calling `Extension.LoadString` inside your `Publish` record.

```powerquery
MyConnector.Publish = [
    Beta = false,
    // Provide a translated Button Label and Description
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    SourceImage = MyConnector.Icons,
    SourceTypeImage = MyConnector.Icons
];
```

### Why Use `Extension.LoadString`?
1. **Certification Requirement**: Microsoft enforces UI localization for all official standard connectors.
2. **Clean code**: Abstracting massive blocks of instructional text into a separate XML file makes your `.pq` logic file much easier to read and maintain.
3. **Dynamic Context**: You do not have to write custom M logic to check the user's local culture info (e.g., `Culture.Current`); the Power Query Engine natively resolves the correct `.resx` file based on the environment automatically.
