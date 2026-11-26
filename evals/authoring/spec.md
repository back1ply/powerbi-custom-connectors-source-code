# Task: a Power Query connector for the Ledgerly API

Write a Power Query (M) custom connector for Ledgerly, a fictional invoicing service,
that a company could ship to its customers: signed, refreshed on a schedule in the
Power BI service, and maintained for years. Put every file of the connector in the
folder `connector/` (create it). Do not build or run anything; write source only.

## The API

- **Base URL:** each customer has their own, e.g. `https://acme.ledgerly.example/api/v2`.
  The user supplies it. Only HTTPS is allowed.
- **Authentication:** an API key, sent as `Authorization: Bearer <key>`. Never in the URL.
- **Endpoints** (all `GET`, all JSON):
  - `/invoices`, `/customers`, `/payments`: list endpoints.
  - `/me`: returns the key's account; cheap, good for checking credentials.
- **List responses:** `{"data": [ ...records... ], "next_cursor": "abc" }`. Request the
  next page with `?cursor=abc`; `next_cursor` is `null` on the last page. `limit`
  (1-200, default 50) sets the page size. An empty list returns `{"data": [], "next_cursor": null}`.
- **Optional filter:** `updated_since=<ISO 8601 datetime>` on every list endpoint.
- **Fields** (omitted from a record when null):
  - invoice: `id` (text), `number` (text), `customer_id` (text), `issued_at` (datetime),
    `due_at` (date), `total` (decimal), `currency` (text), `status` (text), `updated_at` (datetime)
  - customer: `id` (text), `name` (text), `email` (text), `country` (text), `created_at` (datetime)
  - payment: `id` (text), `invoice_id` (text), `amount` (decimal), `paid_at` (datetime), `method` (text)
- **Errors:** JSON body `{"error": {"code": "...", "message": "..."}}`.
  - `401`: bad or expired key.
  - `404`: unknown path.
  - `429`: rate limited; the `Retry-After` header gives the seconds to wait.
  - `503`: temporary outage; retrying shortly usually works.

## What users need

- A navigator listing Invoices, Customers and Payments.
- Correct column types, and the same columns even when a table is empty.
- Scheduled refresh in the Power BI service through the on-premises data gateway.
- Clear error messages, and resilience to rate limiting and short outages.
- The first public release is a preview.
