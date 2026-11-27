---
name: write-connector
description: Write, extend, or review a Power Query (M) custom connector to production and publishing grade, using Microsoft's Power Query SDK guidance and evidence from the certified connectors in this repository. Use this skill when the user wants to build a new Power BI / Excel / Fabric connector for an API or database, add authentication, paging, navigation, schema, error handling, TestConnection, folding, or documentation to one, or check a connector before signing and shipping it.
license: MIT
metadata:
  version: "0.1.0"
---

# Write a connector

Build the connector in Microsoft's TripPin order: each step adds one capability on top
of a connector that already works. Recommend what Microsoft's SDK guidance says; use
the certified connectors in `connectors/` as worked examples of it, never as the
authority. Certified connectors ship mistakes too ([pitfalls](references/pitfalls.md)).

Sources for every step, live Learn pages and the archived certification rules, are in
[references/sources.md](references/sources.md). The bar a finished connector must meet
is in [references/quality-bar.md](references/quality-bar.md).

## The vocabulary

`knowledge/checklist.yaml` names every design decision a connector makes (one
question per SDK topic) and defines each answer id, citing the Learn page it follows.
Use its ids when you plan, and record your choice for each question as you go: the
finished set of answers is the connector's design record.

To find real implementations of an answer, open `bundle/topics/<question>.md`
(every archived connector grouped by its answer, with the cited line), read the
pattern pages it links for that answer, and search the source:

```bash
rg -n "Table.GenerateByPage" connectors --glob "*.{pq,pqm,m}"
```

`knowledge/profiles/<Name>.json` holds model-generated answers for each archived
connector with cited lines (about 95% exact against hand labels); `evals/gold/` holds
hand-checked ones. Verify a cited line before you copy from it.

## Steps

Finish each step's check before starting the next.

1. **Scope.** Write down the source's base URL or driver, its authentication, how it
   pages, its error responses and rate limits, and the tables users need. Check: every
   checklist question has a planned answer id, or `unknown` with what would settle it.
2. **Skeleton.** A section document with a `[Version = "1.0.0"]` header, one `shared`
   data source function named `<Kind>.<Verb>` (`Contents`, `Tables`, `Databases`...),
   a data source kind record, and a Publish record with `Beta = true`. Check:
   `uv run pqkb functions --path <folder>` lists the shared function.
3. **Authentication.** Declare only the kinds the source supports; send credentials
   over HTTPS, in headers or POST bodies (`CredentialQueryString` when a GET is
   unavoidable). OAuth: pass `state` through `StartLogin`, use PKCE when the provider
   supports it, implement `Refresh`, and keep client secrets out of the package. Check:
   sign-in works in Power BI Desktop and a token refresh succeeds.
4. **Data source path.** Required parameters form the credential key; make them
   exactly what identifies the source (usually a URL or server). Optional settings go
   in an `options` record. Check: two different sources get separate credentials.
5. **Navigation.** Return a navigation table (`Table.ToNavigationTable`) whose rows
   are listed from the source where possible; keep `Data` lazy. Check: opening the
   navigator does not fetch table data.
6. **Paging.** Use `Table.GenerateByPage` with an explicit stop rule from the API
   (next link, cursor, or total), copying
   [references/Table.GenerateByPage.pqm](references/Table.GenerateByPage.pqm): Microsoft's
   sample version turns empty pages into null rows
   ([pitfalls](references/pitfalls.md)). Every page, empty ones included, must carry
   the entity's declared table type. Build every request as
   `Web.Contents(baseUrl, [RelativePath = ..., Query = [...]])`: the base URL stays
   static, which the service needs in order to validate it for refresh. Check: an empty
   endpoint returns zero rows, and an empty first page with a next cursor, an empty
   middle page, the last page, and a single page all return the right rows; and
   `Table.FirstN(table, 1)` requests only the first page, so a preview does not
   download the whole table.
7. **Schema.** Declare a table type per entity and enforce it (`Table.ChangeType` or
   `Value.ReplaceType`) so empty and sparse pages keep their columns. Check: an empty
   result has the declared columns and types.
8. **Errors and retries.** Use `ManualStatusHandling` only for statuses you then read;
   raise `Error.Record` with the API's message; retry transient statuses (429, 503)
   with `Value.WaitFor` or `Function.InvokeAfter` and a retry limit, passing
   `IsRetry = true` on retries so the engine's cache does not return the failed
   response. Check: a forced 401, 404, and 429 each produce the intended result.
9. **Diagnostics.** Trace through one switch (`EnableTraceOutput = false` before
   release); never trace credentials or row data. Check: no `Diagnostics.Trace` call
   runs with the switch off.
10. **TestConnection.** Add `TestConnection` to the kind record, calling the shared
    function with the path's values (or a cheap probe). Check: credentials save in the
    Power BI service through the gateway.
11. **Folding (when the source can filter or select).** OData sources fold through
    `OData.Feed`; databases through `Odbc.DataSource` (or ADBC, Microsoft's newer path);
    REST sources through `Table.View` handlers. Check: a filter or top-N step shows up in
    the request, not only in the local result.
12. **Documentation and packaging.** Function and parameter metadata (`Documentation.*`,
    `FieldCaption`, `FieldDescription`, `SampleValues`), strings in `resources.resx`,
    icons in four sizes each. Check: `uv run pqkb certification --path <folder>` reports
    no `fail`, and every `review` item has a written answer.
13. **Ship.** Sign the `.mez` and give users the thumbprint, or document the security
    setting; follow the [quality bar](references/quality-bar.md) for versioning and
    updates. Check: the signed package loads in Power BI Desktop at the default
    security level, and a scheduled refresh succeeds in the service.

## Testing

Use the Power Query SDK for VS Code: evaluate queries in the SDK, then the SDK test
framework and `PQTest` (links in [sources](references/sources.md)) for repeatable
tests, including the failure cases each step's check names.

`PQTest run-test --httpMock <file>` answers `Web.Contents` calls from a text file of
request/response pairs, so each step's check runs on the real engine with no live
service: empty pages, 401, 404, 429 with `Retry-After`, 503. Four behaviours of the
mock (SdkTools 2.160.2):

- It intercepts only hosts that appear in the file; other hosts go to the network.
- A request matches the first entry whose query parameters are a subset of its own,
  so list the most specific URL (with `cursor=`) before the bare one.
- It is stateless: the same URL always gets the same response, so test retries by
  sending the error every time and expecting a clean failure after the retry limit.
- `test-connection` takes no mock; use `run-test` for everything that needs one.

Store the key with `set-credential -cfp <file>` so tests never touch your own
credentials. `evals/authoring/runtime.py` is a worked example of all of this.
