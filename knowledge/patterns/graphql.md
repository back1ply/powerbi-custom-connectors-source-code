---
type: Power Query Pattern
title: GraphQL requests
description: GraphQL request bodies, cursors, and application errors.
category: Data retrieval
tags: [data-retrieval]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:41Z'
detect: [\bGetGraphQLPage\s*=]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L312
  title: CogniteDataSource/CogniteDataSource.pq
- id: registration
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L311
  title: CogniteDataSource/CogniteDataSource.pq
- id: navEntry
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L287
  title: CogniteDataSource/CogniteDataSource.pq
- id: callback
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L739
  title: CogniteDataSource/CogniteDataSource.pq
- id: branch
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L1039
  title: CogniteDataSource/CogniteDataSource.pq
- id: getgraphql
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L987
  title: CogniteDataSource/CogniteDataSource.pq
- id: validate
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L997
  title: CogniteDataSource/CogniteDataSource.pq
- id: transient
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L1047
  title: CogniteDataSource/CogniteDataSource.pq
- id: shape
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L1082
  title: CogniteDataSource/CogniteDataSource.pq
- id: cursorRead
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L1150
  title: CogniteDataSource/CogniteDataSource.pq
- id: defaults
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/CogniteDataSource.pq#L5
  title: CogniteDataSource/CogniteDataSource.pq
- id: variant
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L213
  title: ProductInsights/ProductInsightsConnector.m
- id: productQuery
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L466
  title: ProductInsights/ProductInsightsConnector.m
- id: productData
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/ProductInsights/ProductInsightsConnector.m#L352
  title: ProductInsights/ProductInsightsConnector.m
- id: generator
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/CogniteDataSource/Table.GenerateByPage.pqm#L5
  title: CogniteDataSource/Table.GenerateByPage.pqm
review:
  content_sha256: 4106885409c76ff73426829455534e4cdebb40592df9ecd7da0a4e5194ca0dc4
  sources_sha256:
    example: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    registration: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    navEntry: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    callback: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    branch: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    getgraphql: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    validate: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    transient: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    shape: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    cursorRead: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    defaults: b8f483ebbd8313de5e3934521cc9d417f1dede58321917bcd7fa883f0766f423
    variant: 7989bc4c862e26b6901709a67005d73756ffa3ff2f32da4316d5636e1fa6bdcc
    productQuery: 7989bc4c862e26b6901709a67005d73756ffa3ff2f32da4316d5636e1fa6bdcc
    productData: 7989bc4c862e26b6901709a67005d73756ffa3ff2f32da4316d5636e1fa6bdcc
    generator: 12d4a8d36904f9684d52a2d82fc67fdf565ebe7be8aa01bf14b5750f78f05637
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# GraphQL requests

## Mechanism

`GraphQLImpl` chooses the paging mode from the query text. If the text contains `$cursor`, it calls `GetAllGraphQLPagesByCursor`. Otherwise it makes one `GetGraphQLPage` call with a null cursor (lines 342–347).[^example] `GraphQL` is bound with `Value.ReplaceType` (line 311) and listed as a navigation entry at line 287.[^registration][^navEntry] It is not a `shared` member in this file. The shared entry point is `CogniteDataSource.Contents` (line 50).

`GetAllGraphQLPagesByCursor` uses `Table.GenerateByPage`. The first call has no cursor; later calls read `Cursor` from the previous table. The callback turns an empty continuation page into null. The loaded generator handles an empty first page differently: it returns that table unchanged without demanding later pages, even if a cursor is present. Test the first-page and continuation cases separately.[^callback][^generator]

`GetGraphQLPage` (lines 987–1142) builds one POST. It rejects a caller variable named `cursor` (lines 998–1006), adds `cursor` only when one is supplied (line 1007), and posts `Json.FromValue([query = payload, variables = variablesUpdated])` with JSON headers (lines 1010–1015).[^getgraphql][^validate] It sends the request through `RetryWithExponentialBackoff(url, request, 0)` (line 1019). A GraphQL-level retry adds `IsRetry = true` (line 1018).

A 200 response with both `errors` and `data` takes the GraphQL retry branch, up to `MaxRetries408 = 2` retries. If all those responses are 200, this is three explicit POSTs. A retryable HTTP status instead invokes the separate transport retry budget inside each GraphQL call. A 200 response with `errors` and no `data` raises `GraphQL error` immediately.[^transient][^defaults][^branch]

HTTP failures first pass through `RetryWithExponentialBackoff`. Retryable statuses are retried or raised there; returned responses, such as 400, 403, 500, or an unflagged 409, reach the outer parser. A JSON error record supplies the message/request-ID form of `CogniteAPIError`; a body without `error` uses `HTTP error <code>`. Non-JSON bodies can fail in `Json.Document` before that mapping. A text-valued `error` also reaches `Record.HasFields` before the later text check, so that apparent fallback is not reliable.[^getgraphql][^branch]

`dataRecord` requires `data` to be a record (lines 1082–1091). The first field of `data` is the list field (line 1092), and its value must be a record with `items` (lines 1094–1108). The continuation comes from `GetCursorGraphQL`, which returns `endCursor` only when `hasNextPage` is true.[^shape][^cursorRead]

## Selection and dependencies

Use this shape for a GraphQL endpoint whose query uses `$cursor` and whose response has one top-level data field containing `items` and page state. Caller variables must parse as a JSON object: arrays and scalars can pass JSON parsing but fail the record parameter contract. The output is a table with `Cursor` metadata for paging.[^example][^getgraphql][^shape]

ProductInsights is the simpler contrast. `ProductInsights.MakeRequest` (lines 213–225) posts a query and calls `Json.Document` on the whole body, with no status handling and no `errors` check. `GetProjectsTableByTeamId` reads `Record.Field(json, "data")` (line 356), so a 200 response with `errors` and no `data` raises a missing-field error. A 4xx or 5xx response raises earlier, inside `Web.Contents`. The query is built with `variables = [teamId = teamId]` (lines 466–474).[^variant][^productQuery][^productData]

Choose the simpler helper for a trusted endpoint where the caller handles errors. Choose the Cognite shape when you need the GraphQL error text and transient retries. For REST cursors, see [pagination](pagination.md). For HTTP retry budgets, see [retries and polling](retry-polling.md). For error messages, see [structured errors](errors.md).

## Adaptation and failure paths

Cursor paging depends on text. Any query text containing `$cursor`, including a comment, takes the paged path (line 343). Keep the cursor variable and the query text in step.[^example]

The first field decides the shape. `Record.FieldNames(dataRecord){0}` fails on an empty data record and otherwise selects only its first field. The output column set comes from the first item, so later-only fields are not included by that expansion. Test empty data records separately from empty item lists.[^shape]

`GetCursorGraphQL` reads `pageInfo` with default null, then `hasNextPage` with default false, and reads `endCursor` only when that flag is true. Microsoft's [Record.FieldOrDefault reference](https://learn.microsoft.com/en-us/powerquery-m/record-fieldordefault) accepts a nullable record; missing `pageInfo` is not by itself evidence of a parameter-type error. Test missing, null, malformed, and contradictory page state when adapting the response contract.[^cursorRead]

`raiseMessage` concatenates `requestId` with text. An absent `x-request-id` produces null, and M's [text-concatenation rule](https://learn.microsoft.com/en-us/powerquery-m/m-spec-operators#concatenation) then produces a null message. Supply a deliberate fallback before combining optional fields into user-facing errors.[^getgraphql]

The transient branch does not classify the error text. The condition is the status and the shape (`errors` plus `data`), as the comment at lines 1039–1046 says, so a timeout and a field error with that shape are retried alike.[^branch]

## Validation checklist

- Confirm that the query text contains `$cursor` only where paging is intended.
- Reject a `cursor` key in caller variables, and test that the error is raised.
- Compare `statusToRaise` (line 1009) with the statuses the API returns. A status outside that list raises from `Web.Contents`.
- Test a 200 with `errors` and `data`, a 200 with `errors` and no `data`, and a 400.
- Test a response without `pageInfo`, and one with `hasNextPage` true and a null `endCursor`.
- Confirm the `MaxRetries408` budget (line 1052) against the API's timeout behavior.

## Examples

Request entry point, CogniteDataSource lines 312–349:

<!-- source: example -->
```powerquery
GraphQLImpl = (space as text, datamodel as text, version as text, query as text, optional variables as nullable text) as table =>
    let
        organization = Extension.CurrentCredential()[Properties][Organization]?,
        project =
            if Record.HasFields(Extension.CurrentCredential()[Properties], "ProjectName") then
                Extension.CurrentCredential()[Properties][ProjectName]
            else
                Extension.CurrentCredential()[Properties][Project]?,
        urls = createUrls(project, organization),
        apiUrl = urls[ApiUrl],
        request_url = apiUrl
            & "/api/v1/projects/"
            & project
            & "/userapis/spaces/"
            & space
            & "/datamodels/"
            & datamodel
            & "/versions/"
            & version
            & "/graphql",

        // validate if the variables is valid JSON
        variablesRecord = if variables <> null then
            try
                Json.Document(variables)
            otherwise
                error Error.Record("CogniteConnectorError", "Invalid JSON in variables", variables)
        else
            [],

        Source =
            if Text.Contains(query, "$cursor") then
                GetAllGraphQLPagesByCursor(request_url, query, variablesRecord)
            else
                // no paging
                GetGraphQLPage(request_url, query, variablesRecord, null)
    in
        Source;
```

Cursor callback, lines 739–768:

<!-- source: callback -->
```powerquery
GetAllGraphQLPagesByCursor = (url as text, payload as text, variables as record) as table =>
    Table.GenerateByPage(
        (previous) =>
            let
                // if previous is null, then this is our first page of data
                nextCursor = if (previous = null) then null else Value.Metadata(previous)[Cursor]?,
                // if nextCursor was set to null by the previous call, we know we have no more data
                // if previous = null it's the first page
                page =
                    if previous = null then
                        // first page
                        GetGraphQLPage(url, payload, variables, null)
                    else if (nextCursor <> null) then
                        // pages
                        let
                            items = GetGraphQLPage(url, payload, variables, nextCursor),
                            pageitems = if Table.RowCount(items) = 0
                            // return null instead of empty table
                            then
                                null
                            else
                                items
                        in
                            pageitems
                    else
                        // last page
                        null
            in
                page
    );
```

Transient and error bindings from `GetGraphQLPage`, lines 1039–1078:

<!-- source: branch -->
```powerquery
        // A GraphQL endpoint can return HTTP 200 with a top-level "errors" array. When a
        // "data" payload is still present the query passed validation and failed during
        // execution (typically a transient backend timeout), so it is worth retrying with
        // backoff. Validation errors (no "data") are permanent and surfaced immediately.
        // The condition deliberately does not inspect the "data" payload: the "errors"
        // branch of the "data" binding below already fails any response carrying an
        // "errors" array, so a partially-resolved result is never returned to the caller
        // either way. Retrying it therefore costs nothing and may recover the page.
        isTransientGraphQLError =
            code = 200
            and Record.HasFields(responseJson, "errors")
            and Record.HasFields(responseJson, "data"),
        // Transient GraphQL errors are timeout-like, so reuse the shorter 408 retry budget.
        maxGraphQLRetries = CogniteDefaults[MaxRetries408],
        data =
            if errorDetails <> null and List.Contains(statusToRaise, code) then
                error Error.Record("CogniteAPIError", raiseMessage, errorDetails)
            else if List.Contains(statusToRaise, code) then
                error Error.Record("CogniteAPIError", "HTTP error " & Text.From(code), responseJson)
            else if Record.HasFields(responseJson, "errors") then
                // A GraphQL endpoint can return HTTP 200 with a top-level "errors" array,
                // often alongside a partially-resolved "data" whose queried field is null
                // (e.g. on a backend timeout or a query-complexity/size limit). Surface these
                // errors BEFORE reading "data" so the real backend message is reported instead
                // of a downstream "We cannot apply field access to the type Null" failure.
                // passing a string works best for the error messages
                error
                    Error.Record(
                        "CogniteAPIError", "GraphQL error", Text.FromBinary(Json.FromValue(responseJson[errors]))
                    )
            else if Record.HasFields(responseJson, "data") then
                responseJson[data]
            else
                error
                    Error.Record(
                        "CogniteConnectorError",
                        "Unknown error parsing query result",
                        // passing a string works best for the error messages
                        Text.FromBinary(Json.FromValue(responseJson))
                    ),
```

Single-call helper, ProductInsights lines 213–225:

<!-- source: variant -->
```powerquery
ProductInsights.MakeRequest = (url as text, optional query as text) =>
    let 
        content = Web.Contents(ValidateUrlScheme(url),
        [
            Content = Text.ToBinary(query),
            Headers = [
                #"Content-type" = "application/json",
                #"Accept" = "application/json"
            ]
        ]),
        json = Json.Document(Text.FromBinary(content))
    in
        json;
```

[^example]: CogniteDataSource/CogniteDataSource.pq lines 312–349 (`GraphQLImpl`): request URL (lines 321–331), variables parsing (lines 334–340), and the `$cursor` test (line 343) that selects the callback or one request (lines 344 and 347).
[^registration]: CogniteDataSource/CogniteDataSource.pq line 311: `GraphQL = Value.ReplaceType(GraphQLImpl, GraphQLType)`, binding the typed wrapper around `GraphQLImpl`.
[^navEntry]: CogniteDataSource/CogniteDataSource.pq line 287: `GraphQL` as a row in the navigation table built inside `CogniteDataSourceImpl` (line 248), which `CogniteDataSource.Contents` (line 50) wraps. The table is built only when the project, organization, URL, and CDF access checks pass (lines 276–282).
[^callback]: CogniteDataSource/CogniteDataSource.pq lines 739–768 (`GetAllGraphQLPagesByCursor`): first-page call (line 750), cursor from `Cursor` metadata (line 744), and null on an empty page (lines 755–760).
[^getgraphql]: CogniteDataSource/CogniteDataSource.pq lines 987–1025 (`GetGraphQLPage`, first part): headers, `statusToRaise` (line 1009), the request body (line 1010), `IsRetry` (line 1018), and the response read (lines 1021–1025).
[^validate]: CogniteDataSource/CogniteDataSource.pq lines 997–1007: the reserved `cursor` check (lines 998–1006) and the `variablesUpdated` construction (line 1007).
[^transient]: CogniteDataSource/CogniteDataSource.pq lines 1047–1052 (`isTransientGraphQLError`, `maxGraphQLRetries`) and lines 1126–1138 (the retry call).
[^branch]: CogniteDataSource/CogniteDataSource.pq lines 1039–1078: the transient condition, the status errors (lines 1054–1057), the `errors` branch that raises before reading `data` (lines 1058–1068), and the `data` branch (lines 1069–1070).
[^shape]: CogniteDataSource/CogniteDataSource.pq lines 1082–1121: `dataRecord` (lines 1082–1091), the first-field list name (line 1092), the items record check (lines 1094–1107), the `items` read (line 1108), and the first-item column set (lines 1117–1118).
[^cursorRead]: CogniteDataSource/CogniteDataSource.pq lines 1150–1156 (`GetCursorGraphQL`): reads `pageInfo` through `Record.FieldOrDefault`, and returns `endCursor` only when `hasNextPage = true`.
[^defaults]: CogniteDataSource/CogniteDataSource.pq lines 5–26 (`CogniteDefaults`): `MaxRetries408` is 2 (line 25).
[^variant]: ProductInsights/ProductInsightsConnector.m lines 213–225 (`ProductInsights.MakeRequest`): POST with JSON headers, `Json.Document` on the whole body, and no status handling or `errors` check.
[^productQuery]: ProductInsights/ProductInsightsConnector.m lines 466–474 (`BuildFetchProjectsByTeamIdGraphQLQueryJson`): query and `variables = [teamId = teamId]`, serialized with `Json.FromValue`.
[^productData]: ProductInsights/ProductInsightsConnector.m lines 352–356 (`GetProjectsTableByTeamId`): calls `MakeRequest` (line 355) and reads `data` and `projects` with `Record.Field` (line 356).

[^generator]: Cognite’s loaded page generator returns an empty first table unchanged; its nonempty branch expands later pages.
