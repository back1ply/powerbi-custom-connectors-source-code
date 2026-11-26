# Ledgerly connector for Power BI (preview)

A Power Query custom connector that loads Invoices, Customers and Payments from
the Ledgerly API. This source has not been built or run.

## Before the first build

Add these icon files to this folder. `Ledgerly.pq` references them, and the
connector will not load without them:

`Ledgerly16.png`, `Ledgerly20.png`, `Ledgerly24.png`, `Ledgerly32.png`,
`Ledgerly40.png`, `Ledgerly48.png`, `Ledgerly64.png` (square PNGs of that pixel size).

## Build, test and sign

1. Build with the Power Query SDK (VS Code) or `MakePQX compile`. The output must
   be named `Ledgerly.mez`; set the target name, because the folder name is not it.
2. Set a Key credential for a test account and evaluate `Ledgerly.query.pq`.
   Every logical result should be `true`.
3. Package and sign it as a `.pqx` with the `MakePQX` tool, using your
   code-signing certificate. See
   [connector signing](https://learn.microsoft.com/en-us/power-query/handling-connector-signing).
   Keep the certificate out of source control.
4. Give customers the signed file and the certificate thumbprint.

## Install

- **Power BI Desktop:** copy the signed file to
  `Documents\Power BI Desktop\Custom Connectors` and add the thumbprint to the
  trusted third-party connectors policy (see the signing page above).
- **Gateway (scheduled refresh):** copy the same file to the on-premises data
  gateway's custom connectors folder, trust the thumbprint on that machine, and
  enable custom connectors for the gateway in the Power BI service. Add a Ledgerly
  data source with the same URL and an API key.

## Use

Choose **Get data > Ledgerly**, enter your URL (for example
`https://acme.ledgerly.example/api/v2`) and your API key.

```powerquery
Ledgerly.Contents(
    "https://acme.ledgerly.example/api/v2",
    [UpdatedSince = #datetimezone(2026, 1, 1, 0, 0, 0, 0, 0), PageSize = 200]
){[Name = "Invoices"]}[Data]
```

| Option | Meaning |
| --- | --- |
| `UpdatedSince` | Sent as `updated_since` on all three endpoints. A `datetime` is read as UTC. Fractions of a second are dropped. |
| `PageSize` | 1 to 200, default 200. |

Credentials are stored per URL, as typed. Use one spelling of the URL (same case,
same trailing slash) in Desktop, in queries and in the gateway data source.

`UpdatedSince` is a plain filter, not incremental refresh: the API has no upper
bound, and the connector does not fold query filters.

## Data

Datetime columns are UTC (type `datetime`). `total` and `amount` are Decimal Number
(floating point), so sums can differ in the last digits; set Fixed Decimal Number
in the model if you need exact four-place arithmetic. Amounts are in each
invoice's `currency`; do not sum across currencies. Every column can be null.
Fields the API adds later are ignored until a new connector version declares them.

## Errors and retries

The connector retries HTTP 429, 502, 503 and 504 up to 5 times. It waits for
`Retry-After` when sent, otherwise 1, 2, 4, 8 and 16 seconds. If `Retry-After`
exceeds 300 seconds it fails at once. The limits are at the top of `Ledgerly.pq`.

| Status | What you see | What to do |
| --- | --- | --- |
| 401 | Credential error | Enter a valid API key. |
| 403 | Key not allowed | Check the key's permissions. |
| 404 | Endpoint not found | Check that the URL ends in `/api/v2`. |
| 429 | Rate limited | Refresh less often. |
| 502, 503, 504 | Temporarily unavailable | Try again shortly. |
| 400, 500 | HTTP status and the API's message | Send both to Ledgerly support. |

The connector writes no diagnostic traces.

## Maintaining it

- Raise `[Version]` in `Ledgerly.pq` for every release and update `CHANGELOG.md`.
- Never rename or remove the function, the navigator names, columns or options, or
  change a column's type, without a major version: customers' reports depend on them.
- To add a column, add it to both the table type and the converter list.
- Leave `Beta = true` while in preview.

## Release checklist

- Icons added; `.mez` builds; `Ledgerly.query.pq` passes against a test account.
- Against a test or mock server: 401, 404, 429 with `Retry-After`, 503 then
  success, and persistent 503 each behave as described above. Check the request
  count on the server.
- The request URL is `<base>/invoices`, and later pages carry `cursor`.
- The signed package loads at the default Desktop security level.
- TestConnection succeeds when saving credentials in the service, a bad key is
  rejected, and a scheduled refresh succeeds through the gateway.
- A sample `.pbix` with one query per navigator item refreshes.
