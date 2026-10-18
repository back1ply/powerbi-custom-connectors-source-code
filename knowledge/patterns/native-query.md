---
type: Power Query Pattern
title: Native queries
description: Native-query interception and display-name handling.
category: Query folding
tags: [query-folding]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bValue\.NativeQuery\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L78
  title: CommonDataService/CommonDataService.pq
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 0fb43b15e45a7b5b3e01b1dd1d537066101d953eed998203b8e1e244c33918b6
  sources_sha256:
    example: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
---

# Mechanism

CommonDataService creates a `Sql.Database` navigation table, then wraps it in `Table.View` with an `OnNativeQuery` handler. The handler removes its connector-specific `DisplayNames` option from the options passed onward, calls `Value.NativeQuery`, and adjusts captions through helper functions.[^example]

The handler also defines a second navigation table with `ApplyDisplayNamesOption`; the final selection determines whether that alternative is used. The second native-query call uses `try ... otherwise baseResultWithCaptions`. The final selection depends on the display-name option and `EnableFolding`; a `TryCatch` wrapper translates a failure to `TableViewError`.[^example]

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
