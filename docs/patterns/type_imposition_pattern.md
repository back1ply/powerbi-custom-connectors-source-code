# Power Query Patterns: Schema Enformcent & Type Imposition

When Power Query evaluates `Json.Document(Web.Contents("..."))`, it returns a generic `Record` or `List`. When you convert that List into a Table using `Table.FromRecords()`, every single column in the resulting table is assigned the generic `type any`.

## The Problem with `Table.TransformColumnTypes`

Junior developers usually fix this by wrapping the table in `Table.TransformColumnTypes`:

```powerquery
Table.TransformColumnTypes(source, {
    {"Id", Int64.Type}, 
    {"Name", type text}, 
    {"CreatedAt", type datetime}
})
```

**This is a massive performance bottleneck for APIs.** 

When you call `Table.TransformColumnTypes`, the M engine physically iterates over every single row in the dataset and executes a parsing function. If the API returned 1,000,000 rows, it runs 1,000,000 parsing operations. 

If the API already returned strong JSON types (e.g., numbers are unquoted `{"Id": 123}`, booleans are unquoted `{"isActive": true}`), forcing the engine to parse perfectly valid numbers into numbers again is horribly inefficient.

## The `Value.ReplaceType` Pattern

To enforce a schema onto a table *instantly* (in $O(1)$ time), advanced developers use `Value.ReplaceType`. 

Instead of mutating the data, this function mutates the **Metadata** of the table. It simply tells the engine: *"Trust me, I guarantee the data inside this column matches this type."*

### Implementation

You can define a custom Table Type and slam it onto the untyped data. 

```powerquery
shared MyConnector.GetUsers = () =>
    let
        // 1. Fetch untyped data from the API
        json = Json.Document(Web.Contents("https://api.mycompany.com/users")),
        untypedTable = Table.FromRecords(json), // All columns are `type any`
        
        // 2. Define the exact Schema (Type) the table should have
        // Note the standard M `type table [ ... ]` syntax
        UserTableType = type table [
            Id = Int64.Type,
            Name = type text,
            Email = type text,
            IsActive = type logical
        ],
        
        // 3. Impose the schema using Value.ReplaceType
        // This takes 0.001 seconds regardless of whether there are 10 rows or 10,000,000 rows
        typedTable = Value.ReplaceType(untypedTable, UserTableType)
    in
        typedTable;
```

### Warning: When NOT to use `Value.ReplaceType`

Because `ReplaceType` does not perform data conversion, **it will not parse text into dates or numbers**.

If the API returns numbers wrapped in strings like `{"Id": "123"}`, and you use `Value.ReplaceType` to declare that column as `Int64.Type`, the Power Query Editor UI will show a green bar indicating it's a Number. However, the moment the user tries to perform Math on it, the engine will crash with a Type Mismatch error because the underlying byte allocation is still a Text string.

**Rule of Thumb:**
- If the JSON property is natively the correct type (JSON Boolean -> M Logical, JSON Number -> M Number, JSON String -> M Text), use `Value.ReplaceType`.
- If the JSON property requires parsing (JSON String `"2024-01-01"` -> M Date), you *must* use `Table.TransformColumnTypes` or `Date.FromText`.
