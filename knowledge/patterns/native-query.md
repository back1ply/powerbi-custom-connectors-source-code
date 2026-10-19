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
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L61
  title: CommonDataService/CommonDataService.pq
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L298
  title: CommonDataService/CommonDataService.pq
- id: wrapper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CommonDataService/CommonDataService.pq#L152
  title: CommonDataService/CommonDataService.pq
- id: contrast
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L375
  title: SingleStoreODBC/SingleStoreODBC.m
- id: hide
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/SingleStoreODBC/SingleStoreODBC.m#L308
  title: SingleStoreODBC/SingleStoreODBC.m
review:
  content_sha256: 66809a04ac39a5b64253f14f9ecddea1f826a33c23b8be15dd73ff85f0d9b3a2
  sources_sha256:
    example: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
    helper: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
    wrapper: fd801ef9f147017cf538400d7a26fa667670eb1840189b5de755fc221a26d660
    contrast: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
    hide: 593c578f7107251b6c2c6ccac6235a10a07971d3e2ecaad0ff6b44b2befca1ff
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Native queries

## Mechanism

`CommonDataService.Database` (lines 61–93) wraps the `Sql.Database` navigation table (line 73) in `Table.View(navTable, [OnNativeQuery = ...])` (lines 74–89). The wrapped table is returned only when `server` is not null (line 90). A null server returns the environment list instead.[^example]

`OnNativeQuery` removes the connector-only `DisplayNames` option from the forwarded record (line 77) and reads `displayNames` and `EnableFolding` from the caller's options (lines 78–79). It then prepares two results. `baseResult` runs the query on `navTable` (line 80). `newResult` runs the same query on `ApplyDisplayNamesOption(navTable, options)` (lines 82–83), inside `try ... otherwise baseResultWithCaptions`.[^example]

The final selection (lines 84–86) is the only place that chooses between them. With `displayNames = null`, the result is `baseResult`. With display names set and folding off, it is `baseResultWithCaptions`. Only when display names are set and folding is on is `newResult` used. The `let` bindings are lazy, so the second query runs only on that branch and the fallback.[^example]

`TryCatch` (lines 152–153) evaluates its thunk inside `try`. On error it calls the handler with the error record. `TableViewError` (line 155) is `try #shared[Table.ViewError] otherwise (x) => x`. When the host provides `Table.ViewError`, errors are wrapped. When it does not, the handler returns the original error unchanged.[^wrapper]

`ApplyDisplayNamesOption` returns `navTable` when display names are null. Otherwise it returns a `SqlDatabase.View`. Its `GetRows` uses the local `newOptions`, which removes `EnableFolding` and `DisplayNames`. Its `GetNativeQuery` instead receives an `options` parameter and passes that record through unchanged. That parameter does not refer to the outer handler's similarly named bindings. The helper also declares `NativeQueryOptions = {"EnableFolding", "PreserveTypes"}`.[^helper]

## Adaptation and failure paths

Choose handler interception, as here, when users navigate to a table and call `Value.NativeQuery` on it, and you must rewrite the query's type or options. Choose a dedicated function when users call a specific SQL entry point. The SingleStore connector does the latter. Its `SingleStoreConnectorImplCustomSQL` calls `Value.NativeQuery` directly on the ODBC data source with `EnableFolding = true` (line 395) and removes trailing semicolons first (line 394).[^contrast] For driver-level capabilities, see [ODBC configuration](odbc.md).

The second native query is wrapped in `try ... otherwise`. If it fails, the captioned base result is returned with no trace. The fallback also depends on `baseResult`, so a failure in the base query is not hidden.[^example]

Reading `TableViewError` as a guaranteed wrapper is a mistake. Without `Table.ViewError` in the environment, the error passes through as the original value. Decide whether you need that wrapper and check it in your host.[^wrapper]

`DisplayNames` and `EnableFolding` are read from the native-query options and are not part of `OptionsMap` (lines 126–132). Typos in those names are not rejected by the validation on line 66, which runs only on the `CommonDataService.Database` arguments.[^example][^helper]

The SingleStore connector sets `HideNativeQuery = false` (line 312) while its own comment says extensions should set it to true (line 311). A connector that allows native queries must set this deliberately. CommonDataService does not set it here.[^hide]

Adaptation checklist:

- List each connector-only option, and confirm that it is removed before any record reaches `Value.NativeQuery`.
- Decide which target each query uses (`navTable` or `newNavTable`), and check that each one gets the options you expect.
- Decide whether a failure in the second query should fall back silently, log through `Diagnostics`, or re-raise.
- Test four combinations: display names null or set, folding on or off, and an invalid SQL string.
- Confirm the result types with and without captions.
- Check the `HideNativeQuery` setting before enabling native queries in a new connector.

See [Table.View handlers](table-view.md), [ODBC configuration](odbc.md), and [schema handling](schema.md).

## Examples

The first excerpt, copied from `CommonDataService/CommonDataService.pq` lines 61–93, is the whole `CommonDataService.Database` function, including the `OnNativeQuery` handler and the navigation wrapper.[^example]

<!-- source: example -->
```powerquery
[DataSource.Kind="CommonDataService", Publish="CommonDataService.UI"]
shared CommonDataService.Database = Value.ReplaceType(
    (optional server as text, optional options as nullable record) as table =>
        let
            validatedServer = ValidateServer(server),
            validatedOptions = ValidateOptions(options, OptionsMap),
            database = Text.Lower(Text.Split(validatedServer, "."){0}, ""),
            sqlOptions = [
                LegacyExtension = true,
                IncludeFieldCaptions = validatedOptions[EnableDisplayNames]? ?? true,
                CreateNavigationProperties = validatedOptions[CreateNavigationProperties]? ?? true
            ],
            navTable = Sql.Database(validatedServer, database, sqlOptions),
            nativeQueryOverride = Table.View(navTable, [
                OnNativeQuery = (query, optional parameters, optional options) =>
                    let
                        newOptions = Record.RemoveFields(options ?? [], {"DisplayNames"}, MissingField.Ignore),
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
            result = if server = null then EnvironmentListTable() else nativeQueryOverride
        in
            result,
    CommonDataService.Type);
```

The second excerpt, copied from `CommonDataService/CommonDataService.pq` lines 298–318, is the helper that builds the second navigation table. It shows the different option record used by `GetRows` and `GetNativeQuery`.[^helper]

<!-- source: helper -->
```powerquery
ApplyDisplayNamesOption = (navTable, opt) =>
let
    displayNames = opt[DisplayNames]?,
    newOptions = Record.RemoveFields(opt ?? [], {"EnableFolding", "DisplayNames"}, MissingField.Ignore),
    newNavTable = SqlDatabase.View([
        Dialect = "T-SQL",
        GeneratorVersion = 1,
        DataSourceName="Dataverse",
        Server="Server",
        Database="Database",
        NativeQueryOptions = {"EnableFolding", "PreserveTypes"},
        GetTables = () => error "GetTables",
        GetColumns = (table) => error "GetColumns",
        GetRows = (tableType, command) => Value.NativeQuery(navTable, command, null, newOptions),
        GetNativeQuery = (command, parameters, options) =>
            AdjustTypeForCaptions(
                Value.NativeQuery(navTable, command, parameters, options),
                displayNames)
    ])
in
    if displayNames = null then navTable else newNavTable;
```

The third excerpt, copied from `CommonDataService/CommonDataService.pq` lines 152–155, is the error wrapper. It is short, but it is the only place the error-wrapping decision is made.[^wrapper]

<!-- source: wrapper -->
```powerquery
TryCatch = (tryFn, catchFn) => let result = try tryFn() in
    if not result[HasError] then result[Value] else catchFn(result[Error]);

TableViewError = try #shared[Table.ViewError] otherwise (x) => x;
```

The fourth excerpt, copied from `SingleStoreODBC/SingleStoreODBC.m` lines 375–397, is the contrasting dedicated-function approach. It is a complete function that issues one native query. It is not an `OnNativeQuery` handler, and its coverage is limited to this one function.[^contrast]

<!-- source: contrast -->
```powerquery
SingleStoreConnectorImplCustomSQL = (ServerAddr as text, Database as nullable text, optional Query as text) =>
    let
        //
        // Connection string settings
        //
        BaseConnectionString =
                [
                    Driver = Config_DriverName,
                    Database = Database,
                    ApplicationIntent = "readonly",
                    APP = "SingleStore Power BI Custom SQL Query Connector",
                    no_ssps=1,
                    NO_CACHE=1
                ],

        ConnectionString = AddServerAndPort(BaseConnectionString, ServerAddr),
        DataSource = GetODBCDataSource(Database, ConnectionString),
        // Strip off any trailing semicolons — Value.NativeQuery will error if they’re present,
        // so we remove them to keep legacy queries ending in “;” working smoothly.
        QueryWithoutSemicolumns = Text.TrimEnd(Query, ";"),
        OdbcDataSource =  if QueryWithoutSemicolumns <> null then Value.NativeQuery(DataSource, QueryWithoutSemicolumns, null, [ EnableFolding = true ]) else DataSource
    in
        OdbcDataSource;
```

[^example]: CommonDataService/CommonDataService.pq lines 61–93: `CommonDataService.Database` wraps `Sql.Database` in `Table.View` with `OnNativeQuery`, which removes `DisplayNames`, defines lazy query alternatives, and selects a result inside `TryCatch`.
[^helper]: CommonDataService/CommonDataService.pq lines 298–318: `ApplyDisplayNamesOption` returns the base table or a `SqlDatabase.View` whose `GetRows` and `GetNativeQuery` receive different option records.
[^wrapper]: CommonDataService/CommonDataService.pq lines 152–155: `TryCatch` catches errors from its thunk, and `TableViewError` wraps the error only when `Table.ViewError` is available in `#shared`.
[^contrast]: SingleStoreODBC/SingleStoreODBC.m lines 375–397: `SingleStoreConnectorImplCustomSQL` strips trailing semicolons and calls `Value.NativeQuery` on the ODBC data source with `EnableFolding = true`.
[^hide]: SingleStoreODBC/SingleStoreODBC.m lines 308–312: the `Odbc.DataSource` options set `HideNativeQuery = false`, while the comment on line 311 says extensions should set it to true.
