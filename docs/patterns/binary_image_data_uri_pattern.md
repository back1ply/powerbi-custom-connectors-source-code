# Power Query Patterns: Rendering Authenticated Binary Images

When you connect to a modern SaaS API (like a CRM, an HR system, or a project management tool), the records often contain links to images (like a user's profile icon, a company logo, or an attached photograph).

For example, an API might return data like this:
```json
{
  "id": 101,
  "name": "Jane Doe",
  "avatarUrl": "/api/v1/users/101/avatar"
}
```

If you simply load this data into Power BI, the `avatarUrl` column is just text. Even if you categorize the column as an **Image URL** in the Power BI Data Model, the Table or Matrix visual will try to download the image *anonymously* (from the end-user's browser or the Power BI Service).

Because your API requires Authentication (OAuth2, API Keys, etc.), the unauthenticated request forged by the Power BI visual will **fail**, resulting in a broken image icon.

## The Workaround: Base64 Data URIs

To force Power Query (and your custom connector's authentication headers) to download the image internally during the refresh process—and then pass that image to the visual—you must convert the raw byte stream into a **Base64 encoded Data URI string**.

A Data URI embeds the entire file directly within a text string. Power BI's "Image URL" category natively understands Data URIs and renders them perfectly.

### Step 1: Downloading the Binary Stream

When you pass an endpoint to `Web.Contents`, the Power Query engine automatically injects the active credential (like your OAuth2 Bearer token). The result of `Web.Contents` is a raw stream payload of type `binary`.

```powerquery
CustomerApiUrl = "https://api.mycompany.com";

GetAnswerImageImpl = (imageUrl as text) =>
    let
        // Web.Contents natively applies authentication headers under the hood
        imageBinary = Web.Contents(CustomerApiUrl & imageUrl),
        
        // Convert the raw bytes into a Base64 encoded string
        base64String = Binary.ToText(imageBinary, BinaryEncoding.Base64),
        
        // Prepend the standard Data URI scheme
        DataUri = "data:image/jpeg;base64, " & base64String
    in
        DataUri;
```

### Step 2: Applying the Type Signature

When defining your function in the `Table.ToNavigationTable` so the user can see it in the Navigator dialog, ensure you explicitly define the input requirements. 

However, because the *output* of our `GetAnswerImageImpl` function is a concatenated text string (the Data URI), the *output type* should be `text`, while the initial `imageBinary` payload is `type binary`.

```powerquery
BinaryToPbiImageType = type function (
    binaryContent as (type binary meta [
        Documentation.FieldCaption = "BinaryContent",
        Documentation.FieldDescription = "The content as binary type from Web.Contents"
    ])) as text meta [ // Note: The output is 'text', not 'binary'
        Documentation.Name = "BinaryToPbiImage",
        Documentation.LongDescription = "Convert an authenticated binary stream into a PowerBI friendly Base64 Data URI"
    ];

BinaryToPbiImageImpl = (binaryContent as binary) as text =>
    let
        Base64 = "data:image/jpeg;base64, " & Binary.ToText(binaryContent, BinaryEncoding.Base64)
    in
        Base64;

// Wrap the implementation in the type signature
BinaryToPbiImage = Value.ReplaceType(BinaryToPbiImageImpl, BinaryToPbiImageType);
```

### Adding Images to a Table

When you generate a table of records, you can invoke your custom function as a transformed column to dynamically pull down every authenticated image inline.

```powerquery
GetUsersTable = () =>
    let
        Source = Json.Document(Web.Contents("https://api.mycompany.com/v1/users")),
        Tabled = Table.FromRecords(Source),
        
        // Add a new column that invokes the image downloader for every row
        WithImages = Table.AddColumn(Tabled, "ProfilePicture", each 
            let
                url = [avatarUrl],
                imageBytes = Web.Contents("https://api.mycompany.com" & url),
                dataUri = "data:image/jpeg;base64, " & Binary.ToText(imageBytes, BinaryEncoding.Base64)
            in
                dataUri
        , type text)
    in
        WithImages;
```

> [!WARNING]
> Due to Power Query memory limitations and the 2.1 GB dataset cap in Power BI Pro, doing this for millions of rows containing high-res 4MB JPEGs will instantly crash the mashup engine with `OutOfMemoryException`.
> 
> This pattern is highly recommended only for small thumbnail avatars (e.g. `?size=64x64`), localized SVGs, or paginated datasets with reasonable limits. If your API supports query parameters to compress or resize the requested image, you absolutely must use them.
