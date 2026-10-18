---
type: Power Query Pattern
title: Actions and table mutation handlers
description: Actions and table mutation handlers in extracted connector implementations.
category: Actions
tags: [actions]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:34:15Z'
detect: ['\b(?:Action\.(?:Sequence|Return)|TableAction\.(?:InsertRows|UpdateRows|DeleteRows))\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L1034
  title: LakeHouse/LakeHouse.pq
---

**Draft: awaiting human review.**

# Mechanism

LakeHouse wraps its transformed warehouse navigation data in a `Table.View` with `OnInsertRows`, `OnUpdateRows`, and `OnDeleteRows` handlers. Each handler returns a diagnostic trace containing an `Action.Sequence`. The sequence combines `cacheTableInsertAction` with the corresponding `TableAction` operation.[^example]

The update and delete handlers apply `Table.SelectRows(content, selector)` before constructing their mutation operation. The insert handler uses `content` directly with the supplied rows. The trace records use named staging-warehouse events and empty `Data` records in this excerpt.[^example]

# Adaptation and failure paths

Read the surrounding warehouse and cache setup before interpreting the sequence as a general-purpose writeback API. The excerpt constructs actions inside an existing connector implementation; it does not establish which hosts execute those actions or imply that ordinary Power BI refresh can write arbitrary data.[^example]

Check which table is passed to each mutation, what the selector chooses, and what initialization action must precede it. Treat those choices as part of the operation being reviewed. A selector that matches extra rows changes the mutation's scope even when the action construction itself is syntactically valid.

No rollback, transaction guarantee, or retry policy is demonstrated by these handlers. Verify those properties in the caller and target service before adapting write behavior. In particular, do not infer atomicity from the presence of `Action.Sequence` or add retries without understanding duplicate-operation behavior.[^example]

See [Table.View handlers](table-view.md), [diagnostics](diagnostics.md), and [structured errors](errors.md).

# Examples

The following excerpt is copied from `LakeHouse/LakeHouse.pq`, lines 1034–1039.[^example] Follow the source for the surrounding implementation.

```powerquery
    Table.View(renamedColumns, [
        GetExpression = () => Value.Expression(Value.Optimize(content)),
        OnInsertRows = (rows) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseInsert", Data = []] , Action.Sequence({ cacheTableInsertAction, TableAction.InsertRows(content, rows) })),
        OnUpdateRows = (updates, selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseUpdate", Data = [] ], Action.Sequence({ cacheTableInsertAction, TableAction.UpdateRows(Table.SelectRows(content, selector), updates) })),
        OnDeleteRows = (selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseDelete", Data = []], Action.Sequence({ cacheTableInsertAction, TableAction.DeleteRows(Table.SelectRows(content, selector)) }))
    ]);
```

[^example]: LakeHouse/LakeHouse.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from this page's `detect` expressions. It reports the first matching line per source file, including comments and helper definitions. A match is a source-reading lead, not a runtime or compatibility guarantee.

# Seen in

<!-- seen-in:start -->

Detected in **2** connectors in this archive.

* [Lakehouse](../connectors/LakeHouse.md): [DeltaTableFastCopy.pqm line 220](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DeltaTableFastCopy.pqm#L220), [LakeHouse.pq line 884](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L884), [MDSync.pqm line 112](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/MDSync.pqm#L112), [SparkCompute.pqm line 364](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/SparkCompute.pqm#L364)
* [Warehouse](../connectors/Warehouse.md): [OutputInterceptor.pqm line 128](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/OutputInterceptor.pqm#L128), [WarehouseOutputInterceptor.pqm line 28](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Warehouse/WarehouseOutputInterceptor.pqm#L28)

<!-- seen-in:end -->
