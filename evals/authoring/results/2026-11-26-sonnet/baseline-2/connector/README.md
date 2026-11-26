# Ledgerly connector for Power BI (preview)

A Power Query custom connector for the Ledgerly invoicing API. It lists Invoices, Customers
and Payments. This source has not been built or run yet.

## Files

- `Ledgerly.pq`: the connector.
- `resources.resx`: user-facing text.
- `Ledgerly.query.pq`: test query.

## Using it

1. Get Data > Ledgerly (marked as a preview).
2. Enter your API URL (HTTPS), for example `https://acme.ledgerly.example/api/v2`.
3. Optionally set "Updated since". The value is stored in the query, so it does not move
   between refreshes.
4. Enter your API key when asked.

Behaviour:

- Datetime columns are UTC. `total` and `amount` are fixed decimals (4 places).
- 429 and 503 are tried up to 5 times, honouring `Retry-After`. A requested wait over
  120 seconds fails the refresh.
- Every refresh loads the full list (200 records per request). There is no incremental
  refresh.

## Build and sign

Build `Ledgerly.mez` with the Power Query SDK (VS Code extension). The SDK needs its own
project and settings files around these sources; they are not included. The `.mez` must hold
`Ledgerly.pq` and `resources.resx`. No icons are included. To add them, supply the PNG files
and add `SourceImage` and `SourceTypeImage` records to `Ledgerly.Publish`.

Package and sign with `MakePQX` and your company's code-signing certificate (check
`MakePQX --help` for the options of your version):

    MakePQX pack -mz Ledgerly.mez -t Ledgerly.pqx
    MakePQX sign Ledgerly.pqx --certificate codesign.pfx --password <password>
    MakePQX verify Ledgerly.pqx

Never commit the certificate or its password.

## Install for customers

Power BI Desktop:

1. Copy `Ledgerly.pqx` to `Documents\Power BI Desktop\Custom Connectors`.
2. Trust the certificate: add its thumbprint to the multi-string registry value
   `TrustedCertificateThumbprints` under
   `HKLM\Software\Policies\Microsoft\Power BI Desktop`.

Scheduled refresh through the on-premises data gateway:

1. Use a standard-mode gateway.
2. Copy `Ledgerly.pqx` to a folder the gateway service account can read, and select that
   folder under Connectors in the gateway app.
3. Trust the signing certificate on the gateway machine, following Microsoft's instructions
   for trusted third-party connectors.
4. In the gateway cluster settings in the Power BI service, allow custom connectors.
5. Add a Ledgerly connection on the gateway with the same URL as in the report and the API
   key. The connection test calls `/me`.

## Testing

Run `Ledgerly.query.pq` against a test tenant. Check these by hand, since they need a server
that can be made to fail: wrong key (credential prompt), wrong path (404 message), 429 with
`Retry-After`, 503, a list longer than 200 records, and a gateway refresh.

## Versioning

The version is at the top of `Ledgerly.pq`. `0.x` is the preview (`Beta = true`). For general
availability set `1.0.0` and `Beta = false`.

Existing reports depend on the following, so changing any of them is a breaking change:

- the name `Ledgerly.Contents`, its parameters, and the data source kind `Ledgerly`
- the navigation `Key` values (`invoices`, `customers`, `payments`)
- column names and types

Add new options as optional parameters, so that saved credentials keep matching.
