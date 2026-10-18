---
type: Power Query Pattern
title: Native queries
description: Native-query interception and display-name handling.
category: Query folding
tags: [query-folding]
status: draft
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:33:26Z'
detect: [\bValue\.NativeQuery\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L78
  title: CommonDataService/CommonDataService.pq
---

**Draft: awaiting human review.**

# Mechanism

CommonDataService creates a `Sql.Database` navigation table, then wraps it in `Table.View` with an `OnNativeQuery` handler. The handler removes its connector-specific `DisplayNames` option from the options passed onward, calls `Value.NativeQuery`, and adjusts captions through helper functions.[^example]

When display-name behavior is requested, it builds a second navigation table with `ApplyDisplayNamesOption`. The second native-query call uses `try ... otherwise baseResultWithCaptions`. The final selection depends on the display-name option and `EnableFolding`; a `TryCatch` wrapper translates a failure to `TableViewError`.[^example]

# Adaptation and failure paths

Treat the target table and options as part of the query contract. Reusing the SQL text while changing the target or leaving a connector-only option in the forwarded record can change the behavior under review. Follow parameters through both native-query calls rather than assuming they are identical after options are transformed.[^example]

The source contains an explicit fallback for its second call, so inspect which exception information reaches the outer error wrapper. This is an implementation example for caption and folding-related handling, not a test that every later Power Query transformation folds. Verify the target connector's resulting queries when adapting the approach.

See [Table.View handlers](table-view.md), [ODBC](odbc.md), and [schema handling](schema.md).

# Examples

The following excerpt is copied from `CommonDataService/CommonDataService.pq`, lines 78–89.[^example] It is a partial excerpt; follow the source link for the complete implementation.

```powerquery
                        displayNames = options[DisplayNames]?,
                        enableFolding = options[EnableFolding]? ?? false,
                        baseResult = Value.NativeQuery(navTable, query, parameters, newOptions),
                        baseResultWithCaptions = AdjustTypeForCaptions(baseResult, displayNames),
                        newNavTable = ApplyDisplayNamesOption(navTable, options),
                        newResult = try Value.NativeQuery(newNavTable, query, parameters, newOptions) otherwise baseResultWithCaptions,
                        result = TryCatch(
                            () => if displayNames = null then baseResult else if not enableFolding then baseResultWithCaptions else newResult,
                            (e) => error TableViewError(e))
                    in
                        result
            ]),
```

[^example]: CommonDataService/CommonDataService.pq; see the matching `sources` entry.

# Detection limits

The list below is generated from the `detect` expressions in this page. Detection reports the first matching line per source file, including matches in comments, strings, or helper definitions. Treat each result as a source-reading lead; it is not proof of runtime behavior or a complete implementation.

# Seen in

<!-- seen-in:start -->

Detected in **6** connectors in this archive.

* [AmazonAthena](../connectors/AmazonAthena.md): [AmazonAthena.m line 129](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/AmazonAthena/AmazonAthena.m#L129)
* [Dataverse](../connectors/CommonDataService.md): [CommonDataService.pq line 80](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L80)
* [Indexima](../connectors/Indexima.md): [Indexima.m line 162](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Indexima/Indexima.m#L162)
* [Lakehouse](../connectors/LakeHouse.md): [DeltaTableFastCopy.pqm line 45](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DeltaTableFastCopy.pqm#L45), [DualTable.View.pqm line 277](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/LakeHouse/DualTable.View.pqm#L277)
* [Dataflows](../connectors/PowerPlatformDataflows.md): [PowerPlatformDataflows.pq line 1727](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/PowerPlatformDataflows/PowerPlatformDataflows.pq#L1727)
* [SingleStore Direct Query Connector](../connectors/SingleStoreODBC.md): [SingleStoreODBC.m line 395](https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L395)

<!-- seen-in:end -->
