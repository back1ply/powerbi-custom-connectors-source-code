# Power Query Patterns: Schema & Type Enforcement

APIs return JSON, which has limited primitive types (mostly strings, booleans, and floats). When imported into Power BI, `Json.Document` usually leaves these columns typed as `Any`. 

If a user expects a column named `created_at` to behave as a `DateTime` type or `revenue` as `Currency`, leaving them as `Any` ruins the Power BI modeling experience. However, manually hardcoding `Table.TransformColumnTypes` for every single API endpoint is tedious and difficult to maintain.

## The `Table.ChangeType` Pattern

Microsoft Certified Connectors use a dynamic wrapper function called `Table.ChangeType` (often placed in a separate `.pqm` file) that takes an untyped table and a strict M `type table` definition, and automatically applies the correct `*Type.From()` function across every column.

### 1. Define your schemas

It is best practice to define a schema record for your endpoints.

```powerquery
// 1. Define the M types for each endpoint
UserSchema = type table [
    id = Int64.Type,
    created_at = type datetime,
    is_active = type logical,
    revenue = Currency.Type,
    name = type text
];

InvoiceSchema = type table [
    invoice_id = type text,
    total_amount = type number,
    paid_date = type date
];
```

### 2. Include the `Table.ChangeType` Helper Function

*Note: This is an exact extraction from Microsoft's Zendesk/WorkplaceAnalytics connectors.*

```powerquery
// Save this at the bottom of your file or in a separate Utils.pqm file.
Table.ChangeType = (table, tableType as type) as nullable table =>
    if (not Type.Is(tableType, type table)) then error "type argument should be a table type" else
    if (table = null) then table else
    let
        columnsForType = Type.RecordFields(Type.TableRow(tableType)),
        columnsAsTable = Record.ToTable(columnsForType),
        schema = Table.ExpandRecordColumn(columnsAsTable, "Value", {"Type"}, {"Type"}),
        previousMeta = Value.Metadata(tableType),

        // Ensure we are working with a table
        _table = if (Type.Is(Value.Type(table), type table)) then table else error "table argument should be a table",

        // Reorder and ensure columns match schema
        reordered = Table.SelectColumns(_table, schema[Name], MissingField.UseNull),

        // Process primitive values
        map = (t) => if Type.Is(t, type table) or Type.Is(t, type list) or Type.Is(t, type record) or t = type any then null else t,        
        mapped = Table.TransformColumns(schema, {"Type", map}),
        omitted = Table.SelectRows(mapped, each [Type] <> null),
        existingColumns = Table.ColumnNames(reordered),
        removeMissing = Table.SelectRows(omitted, each List.Contains(existingColumns, [Name])),
        primitiveTransforms = Table.ToRows(removeMissing),
        
        // This line dynamically applies the correct data type casting based on the schema
        changedPrimitives = Table.TransformColumnTypes(reordered, primitiveTransforms),
    
        // Set the final table type signature
        withType = Value.ReplaceType(changedPrimitives, tableType)
    in
        if (List.IsEmpty(Record.FieldNames(columnsForType))) then table else withType meta previousMeta;
```

### 3. Usage

When fetching your data, you simply pass the raw JSON table and the schema definition into the helper.

```powerquery
GetUserTable = () =>
    let
        Source = Web.Contents("https://api.example.com/users"),
        Json = Json.Document(Source),
        // Json[data] is untyped
        RawTable = Table.FromRecords(Json[data]), 
        
        // Magic happens here. All columns are instantly cast to Int64, DateTime, Currency, etc.
        TypedTable = Table.ChangeType(RawTable, UserSchema)
    in
        TypedTable;
```
