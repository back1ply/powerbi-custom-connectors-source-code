---
type: Power Query Pattern
title: Table.View handlers
description: Stateful Table.View handlers and request parameter generation.
category: Query folding
tags: [query-folding]
status: stable
generated:
  by: codex/gpt-6
  at: '2026-10-18T09:58:42Z'
detect: [\bTable\.View\s*\(]
sources:
- id: example
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L37
  title: Asana/Asana.m
- id: helper
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L173
  title: Asana/Asana.m
- id: schema
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L208
  title: Asana/Asana.m
- id: config
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Asana.m#L4
  title: Asana/Asana.m
- id: config-value
  resource: https://github.com/back1ply/powerbi-custom-connectors-source-code/blob/master/connectors/Asana/Config.json#L6
  title: Asana/Config.json
review:
  content_sha256: 89462112834f71c3e3115afc70d913d288563c4fb17b9883c01e51e1bfa3536c
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    helper: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    schema: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    config: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
    config-value: b99f40ec06d0136f9a8a8ab5230aba848e74fd5d5d91055a39a90c9a64bddbb4
verified:
  by: claude/claude-haiku-5-5 + codex/gpt-6
  at: '2026-10-19T10:10:51Z'
---

# Table.View handlers

## Mechanism

`Asana.View` wraps the input link in a state record and returns `Table.View(null, [...])`. The state starts as `[Link = link]` (line 78). The handler record has four members that matter for the type and row paths.[^example]

- `GetType` (line 41) returns `Value.Type(AsanaSchema())`. Type discovery therefore sends a metadata request before any rows are read.[^schema]
- `GetRows` (lines 44–49) calls `CalculateUrl(state)` and then `GetTasks(qp)`. Parameter calculation and row retrieval remain separate steps.[^example][^helper]
- `OnTake` (lines 53–57) handles `Table.FirstN` by building `newState = state & [ Limit = count ]` and returning `@View(newState)`.[^example]
- `CalculateUrl` (lines 60–75) returns a query record, not a URL. It contains `url = state[Link]` and, when `state[Limit]?` is not null, a text `limit` field. The local `url` binding on line 62 is never referenced, so `api_url` does not reach the row request through this function.[^example][^config]

`GetTasks` passes `qp` as `Query` to the literal host `https://reporting-api.integrations.asana.plus`, with `RelativePath = "/v1/data"`, and obtains its bearer token from `RefreshToken()`. The schema request uses `api_url`. The checked-in configuration currently names the same host, but changing that configuration alone will not change the row request. Test both paths after a host change.[^helper][^schema][^config-value]

The source forwards `limit` as a query parameter. It does not show whether the reporting API enforces that limit, so an endpoint that ignored it would return extra rows without any error in this code.[^example]

## Adaptation and failure paths

Choose a `Table.View` state handler when the source can apply a transform remotely. Of the transform handlers, this one implements only `OnTake`. It defines no selection, sort, or filter handler, so those transforms are not handled remotely by this code. When the request is a SQL statement, prefer [native-query interception](native-query.md). When the driver controls query generation, prefer [ODBC configuration](odbc.md). When the problem is paging rather than a row cap, see [pagination](pagination.md).

Composition needs its own test. `OnTake` writes `Limit` from the latest count and does not compare it with an existing value. If the engine invokes the handler of an already-wrapped view, `Table.FirstN(Table.FirstN(t, 5), 10)` could send `limit=10` where the expected result is five rows. This source does not show whether the engine folds the two takes first, so verify the request against the real endpoint.[^example]

The type path and the row path fail independently. A failed `AsanaSchema` request fails whenever the type is requested, even if `GetRows` would succeed. Successful type discovery is therefore not evidence that row retrieval works.[^schema][^helper]

`GetTasks` uses `ManualStatusHandling={403}`, so a 403 body is returned to `Json.Document` rather than raised. The error check on line 185 applies only to a record that contains `error` and `error_description`. Any other record falls through to `ProcessResponse(Json as list)`, which fails on the parameter type instead of reporting the API message.[^helper]

Adaptation checklist:

- List each `Table.View` member you implement, and state which transforms remain local.
- Send only text values in the query record. The comment on lines 64–65 says `Uri.BuildQueryString` requires text literals.
- Test two `Take` calls in both orders, and a `Take` where the state has no `Limit` field.
- Compare the host used for the schema request with the host used for rows.
- Check that the endpoint honors `limit` by comparing row counts with and without the handler.
- Test an empty response and a 403 error body. See [schema handling](schema.md) for the empty-result branch.

See [native-query interception](native-query.md), [schema handling](schema.md), and [web requests](web-requests.md).

## Examples

The following excerpt is copied from `Asana/Asana.m`, lines 37–78. It is a complete `Asana.View` definition and includes the handler record.[^example]

<!-- source: example -->
```powerquery
Asana.View = (link as text) as table =>
    let
        View = (state as record) => Table.View(null, [

            GetType = () => Value.Type(AsanaSchema()),

            // Called last - retrieves the data from the calculated URL
            GetRows = () =>
                let
                    qp = CalculateUrl(state),
                    result = GetTasks(qp)
                in
                    result,

            // OnTake - handles the Table.FirstN transform, limiting
            // the maximum number of rows returned in the result set.
            OnTake = (count as number) =>
                let
                    newState = state & [ Limit = count ]
                in
                    @View(newState),

            // Calculates the final URL based on the current state.
            CalculateUrl = (state) as record =>
                let
                    url = api_url & "/v1/data",

                    // Uri.BuildQueryString requires that all field values
                    // are text literals.
                    defaultQueryString = [ url = state[Link]],

                    // Check for Top defined in our state
                    qsWithLimit =
                        if (state[Limit]? <> null) then
                            defaultQueryString & [ limit = Number.ToText(state[Limit]) ]
                        else
                            defaultQueryString
                in
                    qsWithLimit
        ])
    in
        View([Link = link]);
```

The row-path helper, copied from `Asana/Asana.m`, lines 173–190, receives the `qp` record from `GetRows`. It is the consumer that sends the parameters to the fixed host and handles the error record.[^helper]

<!-- source: helper -->
```powerquery
GetTasks = (qp as record) as table =>
    let
        access_token = RefreshToken(),
        Source = Web.Contents("https://reporting-api.integrations.asana.plus", [
            Headers=[Authorization = "Bearer " & access_token ],
            Timeout=#duration(0, 2, 0, 0),
            ManualStatusHandling={403},
            ManualCredentials = true,
            Query = qp,
            RelativePath = "/v1/data"
        ]),
        Json = Json.Document(Source),
        res =  if Value.Is(Json, type record) and (Record.HasFields(Json, {"error", "error_description"})) then
                    error Error.Record(Json[error], Json[error_description], Json)
               else
                 ProcessResponse(Json)
    in
        res;
```

The type-path helper, copied from `Asana/Asana.m`, lines 208–215, is the function that `GetType` calls. It issues its own request to `api_url`.[^schema]

<!-- source: schema -->
```powerquery
AsanaSchema = () as table =>
   let
       Source = Web.Contents(api_url & "/v1/schema"),
       Json = Json.Document(Source),
       Fields = Json[fields],
       TempTable = #table(Fields, {})
   in
       TempTable;
```

[^example]: Asana/Asana.m lines 37–78: `Asana.View` builds the `[Link = link]` state and the `Table.View` handler with GetType, GetRows, OnTake, and CalculateUrl.
[^helper]: Asana/Asana.m lines 173–190: `GetTasks` gets a token, sends `qp` as the query to a fixed reporting host, and raises only for records with `error` and `error_description`.
[^schema]: Asana/Asana.m lines 208–215: `AsanaSchema` requests `api_url & "/v1/schema"` and returns an empty table built from `Json[fields]`.
[^config]: Asana/Asana.m lines 4–9: `Json.Document` on Config.json supplies `api_url` and the other settings used by this connector.
[^config-value]: Asana/Config.json sets api_url to the host also hardcoded in GetTasks.
