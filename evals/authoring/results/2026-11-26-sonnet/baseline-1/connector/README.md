# Ledgerly connector for Power Query (preview)

A Power Query custom connector that loads Invoices, Customers and Payments from
the Ledgerly API into Power BI.

**Status:** preview (`Beta = true`). The source has not yet been compiled or run.
Complete the release checklist below before giving it to customers.

## Connecting

1. Get data > Online Services > Ledgerly.
2. Enter your base URL, for example `https://acme.ledgerly.example/api/v2`.
3. Optionally set **Updated since**.
4. Enter your API key.

In M: `Ledgerly.Contents(url, optional updatedSince)`.

## Data notes

- All date and time values are UTC. `due_at` is a date.
- `total` and `amount` are fixed decimals (4 decimal places). Invoices can be in
  different currencies, so group by `currency` before summing.
- Fields the API adds later are ignored until a connector release adds them.
- **Updated since** applies to all three tables, and a refresh then loads only
  the matching records; nothing is merged with earlier data. If a filtered report
  needs older customers for relationships, load Customers through a second
  `Ledgerly.Contents` call without the filter.

## Behaviour

- Pages of 200 records, following `next_cursor`.
- HTTP 429, 502, 503 and 504 are tried up to 5 times. The wait is `Retry-After`
  if present, otherwise 2, 4, 8 and 16 seconds. A `Retry-After` above 120
  seconds fails at once and reports the wait.
- HTTP 401 is reported as a credential error, so Power BI asks for a new key.
- Every connection calls `/me` first to check the key and URL.

## Build and sign

Needs `MakePQX` from the Power Query SDK and a code-signing certificate.
Check the options against `MakePQX <command> --help` for your SDK version.

Copy only `Ledgerly.pq` and `resources.resx` into an empty `build/` folder, so
the test query is not packaged. Then:

```
MakePQX compile build -t Ledgerly.mez
MakePQX pack --mez Ledgerly.mez --target Ledgerly.pqx --certificate <cert.pfx> --password <password>
MakePQX verify Ledgerly.pqx
```

Use a certificate from a public or company certificate authority, timestamp the
signature, and keep the `.pfx` and its password out of source control. Publish
the certificate thumbprint so customers can trust it.

## Customer setup

### Power BI Desktop

1. Put `Ledgerly.pqx` in `Documents\Power BI Desktop\Custom Connectors`.
2. Trust the signing certificate: add its thumbprint to the `REG_MULTI_SZ` value
   `TrustedCertificateThumbprints` under
   `HKLM\Software\Policies\Microsoft\Power BI Desktop`.
3. Restart Power BI Desktop.

### Scheduled refresh (on-premises data gateway)

1. Install a standard-mode on-premises data gateway that can reach your Ledgerly
   URL over HTTPS.
2. Copy `Ledgerly.pqx` to a folder the gateway service account can read, and
   select that folder under **Connectors** in the gateway app. On a cluster, do
   this on every member.
3. Trust the certificate thumbprint on each gateway machine, as for Desktop.
4. In the Power BI service, open the gateway settings and allow custom data
   connectors to be refreshed through the gateway.
5. Add a Ledgerly connection with the same base URL as the report, using the
   key authentication method.
6. Map the semantic model to the connection and set the refresh schedule.

## Release checklist

- [ ] Compile with no errors.
- [ ] Evaluate `Ledgerly.query.pq` against a test account.
- [ ] Confirm the `Authorization` header is sent and the key appears in no URL.
      Unverified: with Key authentication the engine may require
      `ManualCredentials = true` in the `Web.Contents` options to accept a
      custom `Authorization` header. If the first request fails with a
      credential or header error, add it in `Request` and test again.
- [ ] Test a bad key (credential prompt, and gateway test connection fails).
- [ ] Test a wrong path (404), 429 with `Retry-After`, and 503.
- [ ] Test more than 200 records, and an empty list (columns and types remain).
- [ ] Test **Updated since**.
- [ ] Refresh through a gateway from the Power BI service.
- [ ] Add icons: PNGs at 16, 20, 24, 32, 40, 48, 64 and 80 px, referenced with
      `SourceImage` and `SourceTypeImage` in the publish and data source records.
- [ ] Add `LearnMoreUrl` and a support contact.
- [ ] Sign the package and verify the signature.

## Versioning

The version is set in `Ledgerly.pq` (`[Version = "x.y.z"]`). Raise it for every
release.

- **Patch:** fixes with no change to the function, columns or types.
- **Minor:** new optional parameters, tables or columns.
- **Major:** anything that can break an existing report.

Customer reports depend on the data source kind (`Ledgerly`), the function name
(`Ledgerly.Contents`), the base URL as the only required parameter, the
navigation keys (`invoices`, `customers`, `payments`) and the column names and
types. Changing the kind or required parameters also makes users re-enter
credentials. Leaving preview means setting `Beta = false`.
