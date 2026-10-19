---
type: Power Query Pattern
title: Actions and table mutation handlers
description: Actions and table mutation handlers in extracted connector implementations.
category: Actions
tags: [actions]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: ['\b(?:Action\.(?:Sequence|Return)|TableAction\.(?:InsertRows|UpdateRows|DeleteRows))\s*\(']
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L998
  title: LakeHouse/LakeHouse.pq
- id: caller
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L962
  title: LakeHouse/LakeHouse.pq
- id: builder
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L2806
  title: LakeHouse/LakeHouse.pq
- id: cachetable
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L2776
  title: LakeHouse/LakeHouse.pq
- id: wrapper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L2867
  title: LakeHouse/LakeHouse.pq
- id: flag
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/LakeHouse.pq#L57
  title: LakeHouse/LakeHouse.pq
review:
  content_sha256: 0225d63f9a11ba64b180f56124dcb75b2468b27b5f9cab61cb5a9df48adbcfcd
  sources_sha256:
    example: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
    caller: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
    builder: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
    cachetable: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
    wrapper: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
    flag: c4a813c57670b8bbbf60d80cbffd7f0dd8777c979731589ccf29a9b9e8499729
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Actions and table mutation handlers

## Mechanism

`GetWarehouseDatabaseView` uses cached endpoint data only when it is non-null and passes `Sql.ValidateInstance`. Otherwise it tries `Workspace[GetTDSEndPoint]`, with lookup errors becoming null. It builds `stateTableInsert` with `CacheTableInsertBuilder` and passes that action to `GenerateViewForWarehouseSqlTableData` with the `Sql.Contents` navigation table. When no endpoint is found, it returns null.[^caller]

`GenerateViewForWarehouseSqlTableData` (lines 998–1039) receives `content` and `cacheTableInsertAction` as parameters. Its inner `view` helper (lines 1005–1029) wraps each table's data in a `Table.View` with `OnInvoke` and `TableDefault`, and declares no mutation handlers. The outer `Table.View` (lines 1034–1039) wraps `renamedColumns` and defines `GetExpression`, `OnInsertRows`, `OnUpdateRows`, and `OnDeleteRows`.[^example]

Each mutation handler returns `Diagnostics.Trace(...)` around `Action.Sequence({cacheTableInsertAction, TableAction.X(...)})`. The cache action runs first, then the table mutation. The mutations target `content`, not `renamedColumns`. Insert uses `content` directly. Update and delete use `Table.SelectRows(content, selector)`. The trace records carry only an event name and an empty `Data` record.[^example]

`CacheTableInsertBuilder` (lines 2806–2820) returns `Action.Sequence` of cache actions only when `UseFileCache` is true, the URL is not a private-link workspace, and both cache IDs are non-null. Otherwise it returns `Action.DoNothing`. `UseFileCache` reads the `MashupFlight_UseFileCache` feature switch, which defaults to false. By default, the cache step is therefore a no-op.[^builder][^flag]

When the cache is enabled, `CacheTableAction` (lines 2776–2801) checks whether the key exists. If it does, it touches the entry. If it does not, it creates the cache folder if needed and inserts the entry. `tryCacheActions` (lines 2867–2873) wraps the cache action in `Action.Try`. On error, it emits a warning trace and returns `Action.DoNothing`, so the mutation still runs.[^cachetable][^wrapper]

## Adaptation and failure paths

Use this shape when the host drives row-level writes through a `Table.View` and the connector must keep a side cache in step. If the connector writes to an API directly, prefer explicit request handling in [web requests](web-requests.md). For the handler shape itself, see [Table.View handlers](table-view.md).

Writes do not use the renamed view. A column rename applied to `renamedColumns` changes what the view exposes, but the insert, update, and delete handlers still reference `content`. Test a write after any rename, because the write path may not follow the rename.[^example]

Selector scope is the main risk. `Table.SelectRows(content, selector)` decides which rows an update or delete touches. A selector that matches extra rows widens the mutation, and a selector that matches none may succeed without changing anything. Test exact, zero, and many matches.[^example]

The cache step runs first, and its failures are warned and swallowed by `tryCacheActions`. A cache error therefore does not stop the write. These handlers show no compensating action if the later mutation fails after the cache action succeeds. That does not establish the driver's or host's transaction guarantees; test the combined failure path in the target environment.[^cachetable][^wrapper]

The mutation handlers do not wrap a retry. Nothing in them checks for an existing row before `TableAction.InsertRows`, so a repeated insert action could add a duplicate. This source does not show whether the host retries actions, so check that behavior before adding a retry.[^example]

If the endpoint is not found, the caller returns null (line 988) instead of a view. The `catch(e) => error e` on line 986 rethrows the error unchanged. Test both branches. Also check the `UseFileCache` setting for the target environment, since the same write can take different paths.[^caller][^flag]

Adaptation checklist:

- Identify the target of each mutation (`content` or the renamed view), and test a write after each rename.
- Decide whether the cache step must run. Check the `MashupFlight_UseFileCache` default and the private-link condition for your environment.
- Test each selector with zero, one, and many matching rows.
- Decide whether a cache failure should be surfaced, since `tryCacheActions` currently only warns.
- Check idempotence for insert, and test a duplicate action after a simulated failure.
- Run writes against a staging workspace before you use them against production data.

See [Table.View handlers](table-view.md), [diagnostics](diagnostics.md), and [structured errors](errors.md).

## Examples

The first excerpt, copied from `LakeHouse/LakeHouse.pq` lines 998–1039, is the complete `GenerateViewForWarehouseSqlTableData` function. It includes the per-table view, the renamed-column step, and the three mutation handlers that use `cacheTableInsertAction`.[^example]

<!-- source: example -->
```powerquery
GenerateViewForWarehouseSqlTableData = (
    content as table,
    dwName as text,
    dwServerInstance as text,
    cacheTableInsertAction,
    options as record) as table =>
let
    view = (content2, tableName) => Table.View(
        content2,
        [
            GetExpression = () => Value.Expression(Value.Optimize(content2)),
            OnInvoke = (function, args, index) =>
                if (Function.EqualsByName(function, "Lakehouse.SqlTable")) then content2
                else if (Function.EqualsByName(function, "Lakehouse.DeltaTableFastCopy")) then
                    Diagnostics.Trace(
                        TraceLevel.Information,
                        [
                            Name = "GenerateViewForWarehouseSqlTableData/DeltaTableFastCopy", 
                            Data = [Source = Utils[NonPii]("Warehouse"), TableName = tableName, DwServerInstance = dwServerInstance]
                        ],
                        // Restrict this check for reads from Staging Warehouse.
                        [
                            // Run a query to check if DeltaLogPublishing is enabled for StagingDW.
                            Enabled = options[IsModelStorage]? = true and DeltaTableFastCopy[CheckIfDeltaLogPublishingIsEnabled](content, dwName),
                            Source = "Warehouse",
                            ReadFromDW = true,
                            TableName = tableName,
                            DwServerInstance = dwServerInstance
                        ])
                else Function.Invoke(function, List.ReplaceRange(args, index, 1, {content2})),
            TableDefault = (newTable) => @view(newTable, tableName)
        ]),
    withView = Table.AddColumn(content, "TransformedData", (_) => view(_[Data], _[Name])),
    removedDataColumn = Table.RemoveColumns(withView, {"Data"}),
    renamedColumns = Table.RenameColumns(removedDataColumn, {{"TransformedData", "Data"}})
in
    Table.View(renamedColumns, [
        GetExpression = () => Value.Expression(Value.Optimize(content)),
        OnInsertRows = (rows) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseInsert", Data = []] , Action.Sequence({ cacheTableInsertAction, TableAction.InsertRows(content, rows) })),
        OnUpdateRows = (updates, selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseUpdate", Data = [] ], Action.Sequence({ cacheTableInsertAction, TableAction.UpdateRows(Table.SelectRows(content, selector), updates) })),
        OnDeleteRows = (selector) => Diagnostics.Trace(TraceLevel.Information, [Name = "StagingWarehouseDelete", Data = []], Action.Sequence({ cacheTableInsertAction, TableAction.DeleteRows(Table.SelectRows(content, selector)) }))
    ]);
```

The second excerpt, copied from `LakeHouse/LakeHouse.pq` lines 2867–2873, is the failure wrapper for every cache action. It is the reason a cache error does not stop the write.[^wrapper]

<!-- source: wrapper -->
```powerquery
tryCacheActions = (actions, actionName) => Action.Sequence
        ({
            () => Action.Try(actions),
            (r) => if (r[HasError]) then
                        Diagnostics.Trace(TraceLevel.Warning, [Name = actionName, Data = [Exception = Utils[Value.ToText](r[Error])]], Action.DoNothing)
                    else Action.Return(r[Value])
        });
```

Coverage is limited to LakeHouse. `connectors/Warehouse/WarehouseOutputInterceptor.pqm` also defines `OnInsertRows`, `OnUpdateRows`, and `OnDeleteRows` handlers. This page does not cover that file, so do not treat it as a second example of this pattern.

[^example]: LakeHouse/LakeHouse.pq lines 998–1039: `GenerateViewForWarehouseSqlTableData` receives `content` and `cacheTableInsertAction`, builds per-table views, and defines insert, update, and delete handlers on the renamed view that mutate `content`.
[^caller]: LakeHouse/LakeHouse.pq lines 962–990: `GetWarehouseDatabaseView` resolves the endpoint, builds `stateTableInsert` with `CacheTableInsertBuilder`, calls `GenerateViewForWarehouseSqlTableData`, and returns null when no endpoint is found.
[^builder]: LakeHouse/LakeHouse.pq lines 2806–2820: `CacheTableInsertBuilder` returns `Action.Sequence` of cache actions only when the cache is enabled, the URL is not private-link, and both IDs are non-null; otherwise it returns `Action.DoNothing`.
[^cachetable]: LakeHouse/LakeHouse.pq lines 2776–2801: `CacheTableAction` touches an existing cache entry, or creates the folder and inserts a new entry, and wraps both paths in `tryCacheActions`.
[^wrapper]: LakeHouse/LakeHouse.pq lines 2867–2873: `tryCacheActions` wraps an action in `Action.Try`, emits a warning trace on error, and returns `Action.DoNothing`.
[^flag]: LakeHouse/LakeHouse.pq line 57: `UseFileCache` reads the `MashupFlight_UseFileCache` feature switch with a default of false.
