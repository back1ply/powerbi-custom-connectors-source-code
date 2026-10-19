---
type: Power Query Pattern
title: Schema and type enforcement
description: Function metadata, returned table types, and dynamic expansion.
category: Schema and errors
tags: [schema-and-errors]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:SchemaTransformTable|Table\.ChangeType|Value\.ReplaceType)\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L11
  title: Asana/Asana.m
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L200
  title: Asana/Asana.m
- id: contrast
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L283
  title: CommonDataService/CommonDataService.pq
review:
  content_sha256: 26f17b3ffecbcbffb730d79d1dc1a160733f416de56e645d7661b2e191bc37b1
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    helper: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    contrast: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Schema and type enforcement

## Mechanism

`Asana.Tables` is declared as `Value.ReplaceType(AsanaNavTable, Asana_Type)` (line 12). `Value.ReplaceType` changes the declared signature and metadata of the function. It does not inspect or convert the values that the function returns.[^example]

`Asana_Type` declares `link` as `Uri.Type` with caption, description, and sample metadata, and the return as a table with a name and long description. `AsanaNavTable` takes `(link as text)`. This is not a primitive-type conflict: Microsoft's [data-source path documentation](https://learn.microsoft.com/en-us/power-query/handling-resource-path#functions-with-a-uri-parameter) describes `Uri.Type` as an ascribed type applied to a text parameter using `Value.ReplaceType`.[^example]

The returned-data path is separate. `ProcessResponse` (lines 200–206) wraps the JSON list in a one-column table named `Fields`. For a nonempty result it expands the record column using `Record.FieldNames(Table.Column(TempTable, "Fields"){0})`, which reads the field names from the first record only. For an empty result it returns `#table(Value.Type(AsanaSchema()), {})`.[^helper]

`AsanaSchema` (lines 208–215) requests `api_url & "/v1/schema"`, reads `Json[fields]`, and returns `#table(Fields, {})`. This file does not define the shape of the `fields` list, so the API's response contract must be checked directly.[^helper]

None of the Asana code converts a value into a declared type. The nearest example in this repository, `AdjustTypeForCaptions` in CommonDataService (lines 283–296), rewrites column metadata such as captions and keeps the table's key and metadata. It also does not convert values.[^contrast]

## Adaptation and failure paths

Choose a schema-rewriting approach when the table's shape is known in advance and you need metadata for the UI. Choose explicit column typing when the downstream model depends on the types of the values themselves. Keep those two decisions separate in review. `Value.ReplaceType` alone does not satisfy the second.

The nonempty branch takes its columns from the first record. A field that appears only in later records is dropped without an error. A field that is missing from the first record is absent from the result even when later records contain it. The table returned by `Asana.View` gets its type from `GetType`, which reads the schema endpoint (see [table-view](table-view.md)), so the two sources can disagree. Compare the schema response with real row output before relying on either.[^helper]

The empty branch depends on `AsanaSchema`. If the schema request fails, an empty but otherwise valid response also fails, so an empty result is not independent of the schema endpoint.[^helper]

Keep the exported function's URI metadata when changing its text implementation. Validate URL construction separately: the type declaration does not demonstrate that the remote endpoint accepts a particular URL.[^example]

Adaptation checklist:

- Decide where columns come from: the schema endpoint, the first record, or a union across records. Document which one wins.
- Decide what happens to missing and extra fields. Options include null-filling, dropping, or raising an error.
- If a column must hold a specific type, add an explicit conversion step and test it with a bad value. Neither excerpt here performs one.
- Test a first record that lacks a field, a later record with an extra field, an empty list, and a schema request error.
- Preserve URI metadata on the public binding and test the URLs the implementation constructs.

See [navigation](navigation.md), [Table.View](table-view.md), and [structured errors](errors.md).

## Examples

The first excerpt, copied from `Asana/Asana.m` lines 11–23, shows the shared function and its declared type. It is a declaration and not a standalone connector: `AsanaNavTable` is defined at line 26.[^example]

<!-- source: example -->
```powerquery
[DataSource.Kind="Asana", Publish="Asana.Publish"]
shared Asana.Tables =  Value.ReplaceType(AsanaNavTable, Asana_Type);

Asana_Type = type function (
    link as (Uri.Type meta [
        Documentation.FieldCaption = Extension.LoadString("UrlParameterCaption"),
        Documentation.FieldDescription = Extension.LoadString("UrlParameterDescription"),
        Documentation.SampleValues = { Extension.LoadString("UrlParameterSampleValue") }
    ]))
    as table meta [
        Documentation.Name = Extension.LoadString("TableName"),
        Documentation.LongDescription = Extension.LoadString("TableDescription")
    ];
```

The second excerpt, copied from `Asana/Asana.m` lines 200–215, is the complete response-to-table path: `ProcessResponse` for nonempty and empty results, and `AsanaSchema` for the schema request. It is the place where the first-record and empty-result behavior described above is implemented.[^helper]

<!-- source: helper -->
```powerquery
ProcessResponse = (Json as list) as table =>
    let
        TempTable = Table.FromList(Json, Splitter.SplitByNothing(), {"Fields"}, null, ExtraValues.Error),
        Result = if Table.RowCount(TempTable) > 0
                    then Table.ExpandRecordColumn(TempTable, "Fields", Record.FieldNames(Table.Column(TempTable, "Fields"){0}))
                    else #table(Value.Type(AsanaSchema()), {})
    in Result;

AsanaSchema = () as table =>
   let
       Source = Web.Contents(api_url & "/v1/schema"),
       Json = Json.Document(Source),
       Fields = Json[fields],
       TempTable = #table(Fields, {})
   in
       TempTable;
```

The third excerpt, copied from `CommonDataService/CommonDataService.pq` lines 283–296, is a contrasting helper. It rebuilds the type of a table from caption records and writes it back with `Value.ReplaceType`. It shows metadata rewriting, not value conversion, and it is included only as a contrast.[^contrast]

<!-- source: contrast -->
```powerquery
AdjustTypeForCaptions = (table, displayNames as nullable list) =>
    if displayNames = null then table else
        let
            tableType = Value.Type(table),
            tt = Table.AddIndexColumn(Record.ToTable(Type.RecordFields(Type.TableRow(tableType))), "Index", 1),
            dt = #table({"Source", "Column", "Caption"}, displayNames),
            j = Table.Join(tt, "Name", dt, "Column", JoinKind.LeftOuter),
            js = Table.Sort(j, {"Index"}),
            w = Table.AddColumn(js, "NewValue", each if [Caption] = null then [Value] else [Type=[Value][Type] meta [Documentation.FieldCaption = [Caption]], Optional = [Value][Optional]]),
            w2 = Record.FromTable(Table.RenameColumns(Table.SelectColumns(w, {"Name", "NewValue"}), {{"NewValue", "Value"}})),
            newType = Type.ReplaceTableKeys(type table Type.ForRecord(w2, false), Type.TableKeys(tableType)) meta Value.Metadata(tableType),
            newTable = Value.ReplaceType(table, newType) meta Value.Metadata(table)
        in
            newTable;
```

[^example]: Asana/Asana.m lines 11–23: the `shared Asana.Tables` declaration wraps `AsanaNavTable` with `Asana_Type`, whose `link` parameter is declared as `Uri.Type` with UI metadata.
[^helper]: Asana/Asana.m lines 200–215: `ProcessResponse` expands the first record's field names or returns an empty typed table, and `AsanaSchema` requests `/v1/schema` and reads `Json[fields]`.
[^contrast]: CommonDataService/CommonDataService.pq lines 283–296: `AdjustTypeForCaptions` replaces column captions in the table type and does not convert any values.
