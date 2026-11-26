# Ledgerly connector for Power BI (preview)

A Power Query custom connector that imports Invoices, Customers and Payments from the Ledgerly API.

**Status:** source only. It has not been built, run or tested.

## Files

| File | Purpose |
| --- | --- |
| `Ledgerly.pq` | Connector source |
| `resources.resx` | User-facing strings |
| `Ledgerly.query.pq` | SDK test query and manual failure checks |
| `Ledgerly{16,20,24,32,40,48,64}.png` | **Missing: add before building** |

The seven PNG icons are not included (binary assets). `Ledgerly.pq` references them, so the connector will not load without them. Name them exactly as above, square, at the pixel size in the name.

## Use

1. **Get data > Ledgerly (Beta)**.
2. Enter your base URL, for example `https://acme.ledgerly.example/api/v2`. Enter it the same way everywhere: credentials and gateway data sources are matched on it.
3. Enter the API key. It is sent only as `Authorization: Bearer <key>` over HTTPS.

```
Source = Ledgerly.Contents("https://acme.ledgerly.example/api/v2"),
Invoices = Source{[Key="invoices"]}[Data]

Recent = Ledgerly.Contents(url, [UpdatedSince = #datetimezone(2026, 1, 1, 0, 0, 0, 0, 0)])
```

- `datetime` columns (`issued_at`, `updated_at`, `created_at`, `paid_at`) are **UTC**.
- `total` and `amount` are Decimal Number. Change to Fixed Decimal Number in the query if you need exact currency sums.
- `UpdatedSince` applies to all three tables. A filtered `Customers` table may lack customers that older or filtered invoices refer to.
- Fields the API adds later are ignored until a new connector version declares them.

## Retries and errors

| Status | Behaviour |
| --- | --- |
| 429, 502, 503, 504 | Up to 5 attempts. Waits `Retry-After` seconds, else 2, 4, 8, 16. A `Retry-After` over 300 s fails at once. |
| 401 | Credential error, so Power BI asks for a new key |
| 400, 403, 404, 500 | Error with the API's message; no retry |

Error details carry `Status`, `Code`, `Path`, `Attempts` and `RetryAfterSeconds`. Other statuses use Power Query's default error.

## Build, sign, deploy

1. Add the icons. In VS Code with the Power Query SDK, create or open an extension workspace for these files and build the `.mez` (`Ledgerly.mez`).
2. Set a credential in the SDK and evaluate `Ledgerly.query.pq`. Run the manual checks listed at its end against a mock server.
3. Package as `.pqx` and sign it with your code-signing certificate using `MakePQX` ([connector signing](https://learn.microsoft.com/en-us/power-query/handling-connector-signing)). Publish the certificate thumbprint to customers.
4. Customers add the thumbprint to Power BI Desktop's trusted list, so they need not lower the extension security setting.
5. **Gateway:** copy the signed file into the on-premises data gateway's custom connectors folder, trust the thumbprint on the gateway machine, and enable the connector in the gateway app. The gateway service account needs read access to the folder and outbound HTTPS to the Ledgerly URL.
6. In the Power BI service, add a gateway data source of type Ledgerly with the same URL and the API key, then configure scheduled refresh.

### Release criteria (not yet met)

- [ ] Icons added; builds without warnings
- [ ] Test query all true; manual failure checks pass
- [ ] Wrong key is rejected when saving credentials (Desktop and gateway)
- [ ] Signed package loads at the default security level
- [ ] Scheduled refresh succeeds in the Power BI service
- [ ] Sample `.pbix` with one query per table

## Design record

| Question | Answer |
| --- | --- |
| auth | `key`, sent in `header` |
| transport | `web-contents`, static base URL with `RelativePath` and `Query` |
| user-inputs | `url-or-server`, `options-record` (`UpdatedSince`) |
| paging | `cursor-token`; `List.Generate`; stops when `next_cursor` is null; `limit=200` |
| data-formats | `json` |
| schema | `declared-schema`; empty results keep columns |
| http-errors | `manual-status-handling`, `structured-error-records`, `retry-with-delay`, `rate-limit-aware` |
| navigation | `fixed-list`, lazy data |
| test-connection | `dedicated-probe` (`GET /me`) |
| folding | `none`: the API filters only by `updated_since`, which does not match a general row filter on every table (customers and payments expose no `updated_at`) |
| documentation | function documentation, captions, descriptions, sample values |
| packaging | single file, localized strings, icons, beta flag |
| diagnostics, long-running, writes | `none` |

## Maintaining

- Raise `[Version = "x.y.z"]` on every release and add a line below.
- Do not rename `Ledgerly.Contents`, the data source kind, navigation keys or columns: saved reports depend on them. Adding columns or options is safe if tested with existing reports.
- Remove `Beta = true` and "(Beta)" from `ButtonTitle` at general availability.
- Cursor paging over live data may repeat or skip records changed during a load, depending on how the API builds cursors. Confirm this with the API owner.

## Changelog

- **1.0.0**: first preview.
