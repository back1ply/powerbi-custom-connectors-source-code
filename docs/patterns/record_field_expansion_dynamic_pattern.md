# Power Query Patterns: Dynamic Record Field Expansion

APIs often return JSON arrays of objects whose field names are not known until runtime — they may be user-configured, version-dependent, or discovered from a metadata endpoint. Hardcoding field names in `Table.ExpandRecordColumn` breaks the connector whenever the API schema evolves.

The fix is to sample the first row of the table and call `Record.FieldNames` on the nested record in that row. This produces an exact field list at evaluation time, which is then passed directly to `Table.ExpandRecordColumn`.

## The `Record.FieldNames(table{0}[col])` Pattern

### 1. Basic dynamic expansion

```powerquery
// From Acterys.pq — expanding a "Column1" wrapper that JSON.Document returns
// when the top-level JSON is an array of objects.
Source = Json.Document(Web.Contents("https://app.acterys.com:9998/api/Dimension?database=" & DbName)),
#"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),

// table{0}[Column1] reads the first row's Column1 value (a record).
// Record.FieldNames discovers its field names at runtime — no hardcoding.
#"Expanded Column1" = Table.ExpandRecordColumn(
    #"Converted to Table",
    "Column1",
    Record.FieldNames(#"Converted to Table"{0}[Column1])
),
```

### 2. Reuse the same pattern across multiple endpoints

The pattern is endpoint-agnostic. Acterys applies it identically to every JSON array it fetches, regardless of the object shape:

```powerquery
// Database list endpoint
DBExpandedColumn = Table.ExpandRecordColumn(
    #"Converted to TableDB",
    "Column1",
    Record.FieldNames(#"Converted to TableDB"{0}[Column1])
),

// Dimension data endpoint — different fields, same technique
toTable1 = Table.ExpandRecordColumn(
    #"Converted to Table2",
    "Column1",
    Record.FieldNames(#"Converted to Table2"{0}[Column1])
),
```

### 3. Sampling a deeply nested column

When the nested record is not directly in `Column1` but is inside an already-expanded column, reference the correct column name in the row accessor:

```powerquery
// From AssembleViews.m — properties table has a nested record column "PQType"
// whose fields vary per view definition.
AddPQTypeColumn = Table.AddColumn(properties, "PQType",
    each GetPQType([columnType], [columnName])
),

// Discover the fields from the first row of the new column
FieldList = Record.FieldNames(AddPQTypeColumn{0}[PQType]),

ExpandedTypes = Table.ExpandRecordColumn(AddPQTypeColumn, "PQType", FieldList),
```

### 4. Defensive variant with fallback

When there is a risk that the table could be empty (e.g., an API that returns `[]`), guard the row access:

```powerquery
SafeExpand = (tbl as table, colName as text) as table =>
    if Table.IsEmpty(tbl) then tbl
    else
        Table.ExpandRecordColumn(
            tbl,
            colName,
            Record.FieldNames(tbl{0}[colName])  // safe — only reached when tbl is non-empty
        );
```

### Why `table{0}[col]` works

| Expression | Meaning |
|------------|---------|
| `table{0}` | Row accessor — returns the first row as a record |
| `[col]` | Field accessor on that record — returns the nested record value |
| `Record.FieldNames(...)` | Returns the list of field names on the nested record |

The result is passed directly as the third argument (`columns`) to `Table.ExpandRecordColumn`, which creates one output column per discovered field.

**Important:** This technique assumes all rows share the same nested record shape. If field sets can vary per row, use `Table.ExpandRecordColumn` with `MissingField.UseNull` and union all discovered field names across rows instead.
