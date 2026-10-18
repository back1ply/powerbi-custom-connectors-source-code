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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L10
  title: Asana/Asana.m
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: b3aacc9f241f4895303c9793e5898da266bddd63f1c1def1cdec58e565df268d
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana exposes `Asana.Tables` through `Value.ReplaceType(AsanaNavTable, Asana_Type)`. `Asana_Type` describes a function whose URL parameter carries field-caption, description, and sample-value metadata. The declared return is a table with documentation metadata. This excerpt primarily describes the connector's function surface, rather than a row-by-row value conversion.[^example]

The returned-data path is separate. `ProcessResponse` turns the JSON list into a table and, for a nonempty result, expands fields discovered from the first record. Its empty branch uses `#table(Value.Type(AsanaSchema()), {})`. `AsanaSchema` fetches a schema response and constructs a table using its `fields` list.[^example]

# Adaptation and failure paths

Check both empty and nonempty results before calling an implementation schema-enforcing. The nonempty branch's first-row field discovery can miss fields that occur only later, while the empty branch obtains its type from a schema function. Neither the presence of `Value.ReplaceType` nor an empty typed table demonstrates that all incoming values were converted to declared types.[^example]

Keep function documentation, column selection, field expansion, and scalar conversion as separate review questions. When adapting this code to inconsistent API records, decide how missing and extra fields should be handled rather than letting the first returned record silently define the contract.

See [navigation](navigation.md), [Table.View](table-view.md), and [structured errors](errors.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 10–21.[^example] It is a partial excerpt; follow the source link for the complete implementation.

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
```

[^example]: Asana/Asana.m; see the matching `sources` entry.
