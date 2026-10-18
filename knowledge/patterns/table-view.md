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
verified:
  by: codex/gpt-6
  at: '2026-10-18T10:34:39Z'
review:
  content_sha256: 312a87c9fab54f565e235bd753fbf754cec95eacff73468d7d1ec826327787c7
  sources_sha256:
    example: 05ddd2acfc64395cc732dfc54b3e2ea8690ee77c30f083e840ed71a3d08cbb89
---

# Mechanism

Asana constructs a `Table.View(null, ...)` whose state initially contains the input link. `GetType` returns the type of `AsanaSchema()`. `GetRows` computes query parameters from the current state and passes them to `GetTasks`, so parameter calculation and row retrieval remain separate steps.[^example]

`OnTake` produces a new state by adding `Limit = count` and recursively returns `@View(newState)`. `CalculateUrl` includes a textual `limit` query parameter when that state field is present. This is the concrete relationship between the view handler and the later request; the view does not merely truncate an already-returned table in that branch.[^example]

# Adaptation and failure paths

Treat each handler as an implementation commitment. This source shows `OnTake`, but that does not demonstrate support for filtering, sorting, skipping, or aggregation. Follow the state through the final request before claiming that a transformation is handled remotely.[^example]

Check how successive transformations combine their state, especially when a handler overwrites a previous value. Here `state & [Limit = count]` replaces the limit field. When adapting the approach, test compositions as well as isolated transformations, and compare the actual endpoint request with the result expected by the caller.[^example]

The type path calls a schema function that performs a web request, while the row path calls `GetTasks`. Include failures in both paths when reviewing the connector; successful type discovery is not evidence that row retrieval succeeded.[^example]

See [native-query interception](native-query.md), [schema handling](schema.md), and [web requests](web-requests.md).

# Examples

The following excerpt is copied from `Asana/Asana.m`, lines 37–78.[^example]

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

[^example]: Asana/Asana.m; see the matching `sources` entry.
