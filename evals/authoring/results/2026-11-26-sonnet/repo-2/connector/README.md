# Ledgerly connector for Power Query (preview)

Imports Invoices, Customers and Payments from a Ledgerly account into Power BI.

**Status: source only.** It has not been built or run. Complete "Before release" first.

## Files

| File | Purpose |
| --- | --- |
| `Ledgerly.pq` | The connector |
| `resources.resx` | Display strings |
| `Ledgerly.query.pq` | SDK test query (schema and empty results); not part of the package |

## Use

    Ledgerly.Contents("https://acme.ledgerly.example/api/v2")
    Ledgerly.Contents("https://acme.ledgerly.example/api/v2", [UpdatedSince = #datetime(2026, 1, 1, 0, 0, 0)])

Choose the **Key** credential and paste the Ledgerly key. All datetime columns are UTC.

`UpdatedSince` filters all three tables. It has no upper bound, so do not use it for
Power BI incremental refresh (`RangeStart`/`RangeEnd`): partitions would overlap.

## Behaviour

| Case | Result |
| --- | --- |
| 401 | Credential error; Power BI asks for a new key |
| 429, 502, 503, 504 | Up to 5 retries, waiting `Retry-After` or 1, 2, 4, 8, 16 s |
| `Retry-After` over 300 s | Fails at once with the rate-limit message |
| 400, 403, 404, 500 | Error with the status, path, and the API's code and message |
| Empty list | Table with all columns and types |
| New API fields | Ignored until a release adds them |

## Build, sign, deploy

1. Package: zip `Ledgerly.pq` and `resources.resx` (both at the zip root) as
   `Ledgerly.mez`, or build with the Power Query SDK for VS Code.
2. Sign the package into a `.pqx` with your code-signing certificate using `MakePQX`
   (NuGet `Microsoft.PowerQuery.SdkTools`). See
   [connector signing](https://learn.microsoft.com/en-us/power-query/handling-connector-signing).
   Keep the certificate and its password out of this folder.
3. Give customers the `.pqx` and the certificate thumbprint. They add it to the registry
   value `TrustedCertificateThumbprints` (`REG_MULTI_SZ`) under
   `HKLM\Software\Policies\Microsoft\Power BI Desktop`, then put the file in
   `Documents\Power BI Desktop\Custom Connectors`.
4. Scheduled refresh: copy the file to the on-premises data gateway's custom connectors
   folder, enable custom connectors on the gateway cluster in the Power BI service,
   add a Ledgerly data source with the same URL and a Key credential, and map the
   semantic model to it.

## Versioning

Raise `[Version = "x.y.z"]` in `Ledgerly.pq` on every release: patch for fixes, minor
for new columns, tables or options, major for anything that can break a saved query
(renamed or removed column, changed type, changed parameters). Do not rename the
`Ledgerly` kind or `Ledgerly.Contents`: saved queries and credentials depend on them.
`Beta = true` marks the preview; set it to `false` for general availability.

## Before release

Nothing below has been done.

- Run the static checks from the reference repository (not run so far):
  `uv run pqkb functions --path <this folder>` and
  `uv run pqkb certification --path <this folder>`. Expect `icons` to fail, since none
  are included.
- Build, then run `Ledgerly.query.pq` against a test account.
- Against a mock or test server, check:
  - 401 asks for new credentials; 404 shows the API message.
  - 429 with `Retry-After`, and 503, retry and then succeed or fail after 6 requests.
  - An HTML error body still gives the status message.
  - Several pages, one page, an empty list, and an empty page with a non-null cursor.
  - The request URL is `<base>/invoices?limit=200`, with the `/api/v2` path kept.
  - The key appears only in the `Authorization` header.
  - Datetimes with `Z`, an offset, and no offset; decimals; null and omitted fields.
- Confirm that the options record accepts the internal `TestConnection` flag, and that
  saving credentials on the gateway succeeds.
- Confirm a scheduled refresh in the service.
- Add icons (PNG 16, 20, 24, 32 and 32, 40, 48, 64 px) and the `Icons`, `SourceImage`
  and `SourceTypeImage` records. None are included.
- Check that `total` and `amount` need no more precision than `Decimal.Type` (floating
  point) gives. Switch to `Currency.Type` if four fixed decimals suit your customers.

## Design record

Answer ids from the reference repository's `knowledge/checklist.yaml`.

| Question | Answer |
| --- | --- |
| auth | key (header) |
| transport | web-contents |
| user-inputs | url-or-server, options-record (`UpdatedSince`), date-range |
| paging | cursor-token, list-generate; stops when `next_cursor` is null |
| data-formats | json |
| schema | declared-schema, explicit-type-conversion; empty results keep columns |
| http-errors | manual-status-handling, structured-error-records, retry-with-delay, rate-limit-aware, default |
| documentation | function-documentation, parameter-captions, parameter-descriptions, sample-values |
| navigation | fixed-list |
| test-connection | dedicated-probe (`GET /me`) |
| folding | none (the only server filter is the `UpdatedSince` option) |
| packaging | single-file, localized-strings, beta-flag |
| diagnostics | none |
| long-running, writes | none |
