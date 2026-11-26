# Ledgerly connector for Power Query (preview)

A Power Query custom connector that loads Invoices, Customers and Payments from the Ledgerly API
into Power BI. This 0.1.0 release is a preview (`Beta = true`). It has not been built or run.

## Use

1. Get Data > Online Services > **Ledgerly (Beta)**.
2. Enter your base URL, e.g. `https://acme.ledgerly.example/api/v2` (HTTPS only).
3. Optionally set **Updated since**. It filters all three tables, and it is a fixed value, not
   incremental refresh. Filtered invoices may refer to customers that were filtered out.
4. Enter your API key. It is sent only in the `Authorization` header.

All `*_at` columns are UTC. `due_at` is a date. `total` and `amount` are fixed decimals
(four decimal places).

## Behaviour

- Pages of 200 records are followed until `next_cursor` is null.
- 429, 502, 503 and 504 are retried up to 5 times, waiting for `Retry-After` when sent and
  2, 4, 8, 16, 32 seconds otherwise. A `Retry-After` above 120 seconds fails immediately.
- 401 asks for new credentials.

## Build and sign

Files: `Ledgerly.pq`, `resources.resx`, `Ledgerly.query.pq` (test only). No Power Query SDK
project file is included.

1. Build the `.mez` with the Power Query SDK.
2. Package and sign it as `.pqx` with `MakePQX` and your code-signing certificate
   (see `MakePQX --help`). Timestamp the signature, and keep the certificate's private key out
   of the repository.
3. Give customers the certificate thumbprint. To trust it in Power BI Desktop, add it to the
   `REG_MULTI_SZ` value `TrustedCertificateThumbprints` under
   `HKLM\Software\Policies\Microsoft\Power BI Desktop`.

## Scheduled refresh (on-premises data gateway)

1. Copy the signed `.pqx` to a folder that the gateway service account
   (`NT SERVICE\PBIEgwService` by default) can read, on every gateway in the cluster.
2. In the gateway app, under **Connectors**, select that folder. Trust the thumbprint on the
   gateway machine as well.
3. In the Power BI service, enable custom connectors for the gateway cluster.
4. Add a Ledgerly data source with the same URL as in the report, choose key authentication
   and enter the API key. The connection test calls `/me`.
5. Map the semantic model to that data source and schedule refresh.

## Before the first release

- [ ] Add icons. None are included, so add the PNGs and the `Icons` and `SourceImage` entries
      in `Ledgerly.Publish`.
- [ ] Build, then test the connection, an empty table, several pages, 401, 404, 429 and 503.
- [ ] Confirm on the wire that the `Authorization` header is sent and that a 401 prompts for a
      new key.
- [ ] Confirm gateway refresh with the signed `.pqx`.

## Maintaining

- Renaming the `Ledgerly` data source kind or `Ledgerly.Contents`, or changing its required
  parameters, breaks saved credentials and reports.
- Renaming a navigation `Key` or a column breaks saved queries.
- New API fields are ignored until added to a schema in `Ledgerly.pq`.
- Change `Version` in `Ledgerly.pq` for each release.
